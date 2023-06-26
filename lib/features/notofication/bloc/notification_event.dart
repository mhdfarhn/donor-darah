part of 'notification_bloc.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object> get props => [];
}

class LoadNotifications extends NotificationEvent {}

class SendNotification extends NotificationEvent {
  final String donorRequestId;
  final String receiverEmail;
  final String receiverName;
  final String title;
  final String text;
  final NotificationCategory category;

  const SendNotification({
    required this.donorRequestId,
    required this.receiverEmail,
    required this.receiverName,
    required this.title,
    required this.text,
    required this.category,
  });

  @override
  List<Object> get props => [
        donorRequestId,
        receiverEmail,
        receiverName,
        title,
        text,
        category,
      ];
}
