import 'package:dartz/dartz.dart';
import 'package:moatmat_uploader/Core/errors/exceptions.dart';
import 'package:moatmat_uploader/Features/notifications/domain/repositories/notifications_repository.dart';

class DeleteDeviceTokenUsecase {
  final NotificationsRepository repository;

  DeleteDeviceTokenUsecase({required this.repository});

  Future<Either<Failure, Unit>> call() async {
    return await repository.deleteDeviceToken();
  }
}
