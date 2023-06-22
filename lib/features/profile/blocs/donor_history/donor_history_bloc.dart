import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_function.dart';
import '../../../../core/data/models/models.dart';
import '../../../../core/data/services/firebase/firestore_service.dart';

part 'donor_history_event.dart';
part 'donor_history_state.dart';

class DonorHistoryBloc extends Bloc<DonorHistoryEvent, DonorHistoryState> {
  final FirestoreService _firestore = FirestoreService();

  DonorHistoryBloc() : super(DonorHistoryInitial()) {
    on<CreateDonorHistory>((event, emit) async {
      emit(DonorHistoryLoading());
      try {
        await _firestore.createDonorHistory(
          date: event.date,
          location: event.location.isNotEmpty ? event.location : '-',
        );

        UserModel user = await _firestore.getUser(event.email);

        if (user.lastDonation == null) {
          await _firestore.updateLastDonation(user, event.date);
        } else {
          if (AppFunction.isLatestTimestamp(event.date, user.lastDonation!)) {
            await _firestore.updateLastDonation(user, event.date);
          }
        }

        List<DonorHistoryModel> donorHistories =
            await _firestore.getDonorHistories();

        emit(DonorHistoryLoaded(donorHistories));
      } catch (e) {
        emit(DonorHistoryError(e.toString()));
      }
    });

    on<LoadDonorHistories>((event, emit) async {
      emit(DonorHistoryLoading());
      try {
        List<DonorHistoryModel> donorHistories =
            await _firestore.getDonorHistories();
        emit(DonorHistoryLoaded(donorHistories));
      } catch (e) {
        emit(DonorHistoryError(e.toString()));
      }
    });
  }
}
