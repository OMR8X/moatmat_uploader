import 'package:moatmat_uploader/Features/notifications/domain/entities/app_notification.dart';

class SendNotificationToUsersRequest {
  AppNotification notification;
  List<String> userIds;
  SendNotificationToUsersRequest({
    required this.notification,
    required this.userIds,
  });
}
