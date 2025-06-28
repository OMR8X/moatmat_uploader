import 'package:dartz/dartz.dart';
import 'package:moatmat_uploader/Features/notifications2/domain/entities/notification.dart';
import 'package:moatmat_uploader/Features/notifications2/domain/repository/repository.dart';

class SendBulkNotification {
  final NotificationRepository repository;

  SendBulkNotification({required this.repository});

  Future<Either<Exception, Unit>> call({
    required List<String> userIds,
    required NotificationData notification,
  }) async {
    return repository.sendBulkNotification(
      notification: notification,
      userIds: userIds,
    );
  }
}
