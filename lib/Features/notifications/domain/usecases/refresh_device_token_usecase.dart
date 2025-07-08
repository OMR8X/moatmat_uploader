import 'package:dartz/dartz.dart';

import 'package:moatmat_uploader/Core/errors/exceptions.dart';
import '../repositories/notifications_repository.dart';

class RefreshDeviceTokenUsecase {
  final NotificationsRepository repository;

  RefreshDeviceTokenUsecase({required this.repository});

  Future<Either<Failure, String>> call() async {
    return await repository.refreshDeviceToken();
  }
}
