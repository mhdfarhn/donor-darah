part of 'notification_bloc.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object> get props => [];
}

class LoadNotifications extends NotificationEvent {}

class SendDonorRequestNotification extends NotificationEvent {
  final String donorRequestId;
  final String receiverEmail;
  final String receiverName;
  final String title;
  final String distance;
  final bool isAccepted;
  final NotificationCategory category;

  const SendDonorRequestNotification({
    required this.donorRequestId,
    required this.receiverEmail,
    required this.receiverName,
    required this.title,
    required this.distance,
    required this.isAccepted,
    required this.category,
  });

  @override
  List<Object> get props => [
        donorRequestId,
        receiverEmail,
        receiverName,
        title,
        distance,
        isAccepted,
        category,
      ];
}
