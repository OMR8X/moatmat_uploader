import 'package:dartz/dartz.dart';
import 'package:moatmat_uploader/Features/notifications2/domain/entities/notification.dart';
import 'package:moatmat_uploader/Features/notifications2/domain/repository/repository.dart';

class SendNotification {
  final NotificationRepository repository;

  SendNotification({required this.repository});

  Future<Either<Exception, Unit>> call({
    required String userId,
    required NotificationData notification,
  }) async {
    return repository.sendNotification(
      notification: notification,
      userId: userId,
    );
  }
}
