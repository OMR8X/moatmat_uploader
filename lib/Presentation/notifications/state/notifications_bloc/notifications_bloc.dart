import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moatmat_uploader/Features/notifications/domain/entities/app_notification.dart';
import 'package:moatmat_uploader/Features/notifications/domain/usecases/get_notifications_usecase.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  final GetNotificationsUsecase _getNotificationsUsecase;

  NotificationsBloc({
    required GetNotificationsUsecase getNotificationsUsecase,
  })  : _getNotificationsUsecase = getNotificationsUsecase,
        super(NotificationsInitial()) {
    on<GetNotifications>(_onGetNotifications);
  }

  Future<void> _onGetNotifications(
    GetNotifications event,
    Emitter<NotificationsState> emit,
  ) async {
    emit(NotificationsLoading());
    final result = await _getNotificationsUsecase();
    result.fold(
      (failure) => emit(NotificationsFailure("خطأ اثناء الحصول على الإشعارات")),
      (notifications) => emit(NotificationsLoaded(notifications)),
    );
  }
}
