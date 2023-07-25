import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/constants.dart';
import '../../../core/data/models/models.dart';
import '../../../core/data/services/firebase/firestore_service.dart';
import '../../../core/utils/enums.dart';
import '../data/models/notification_model.dart';
import '../data/services/notification_service.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final NotificationService _notification = NotificationService();
  final FirestoreService _firestore = FirestoreService();

  NotificationBloc() : super(NotificationInitial()) {
    on<SendDonorRequestNotification>((event, emit) async {
      emit(NotificationSending());
      try {
        final User? currentUser = FirebaseAuth.instance.currentUser;
        final UserModel user = await _firestore.getUser(currentUser!.email!);

        final String category =
            AppFunction.notificationCategory(event.category);
        final String? token =
            await _firestore.getUserToken(event.receiverEmail);

        final String text =
            '${user.name} (${event.distance}) membutuhkan donor Anda.';
        final NotificationModel notification = NotificationModel(
          donorRequestId: event.donorRequestId,
          senderEmail: user.email,
          senderName: user.name,
          receiverEmail: event.receiverEmail,
          receiverName: event.receiverName,
          accepted: event.isAccepted,
          title: event.title,
          text: text,
          category: category,
          createdAt: Timestamp.now(),
          updatedAt: Timestamp.now(),
        );

        if (token != null) {
          final bool isNotificationSent = await _notification.sendNotification(
            token: token,
            title: event.title,
            text: text,
          );
          debugPrint(isNotificationSent.toString());
          if (isNotificationSent) {
            debugPrint('storing notification');
            await _notification.storeNotificationToFirestore(notification);
            debugPrint('notification stored');
            emit(NotificationSent());
          } else {
            emit(const NotificationNotSent('Pengguna sedang tidak aktif'));
          }
        } else {
          emit(const NotificationNotSent('Pengguna sedang tidak aktif'));
        }
      } catch (e) {
        emit(NotificationError(e.toString()));
      }
    });

    on<LoadNotifications>((event, emit) async {
      emit(NotificationLoading());
      try {
        List<NotificationModel> notifications =
            await _notification.loadNotifications();

        emit(NotificationLoaded(notifications));
      } catch (e) {
        emit(NotificationError(e.toString()));
      }
    });
  }
}
