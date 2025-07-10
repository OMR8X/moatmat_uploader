import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:moatmat_uploader/Features/notifications/data/datasources/notification_local_data_source.dart';
import 'package:moatmat_uploader/Features/notifications/data/datasources/notifications_remote_datasource.dart';
import 'package:moatmat_uploader/Features/notifications/data/repositories/notifications_repository_implements.dart';
import 'package:moatmat_uploader/Features/notifications/domain/repositories/notifications_repository.dart';

import 'package:moatmat_uploader/Features/notifications/domain/usecases/create_notifications_channel_usecase.dart';
import 'package:moatmat_uploader/Features/notifications/domain/usecases/delete_device_token_usecase.dart';
import 'package:moatmat_uploader/Features/notifications/domain/usecases/display_firebase_notification_usecase.dart';
import 'package:moatmat_uploader/Features/notifications/domain/usecases/display_notification_usecase.dart';
import 'package:moatmat_uploader/Features/notifications/domain/usecases/get_device_token_usecase.dart';
import 'package:moatmat_uploader/Features/notifications/domain/usecases/get_notifications_usecase.dart';
import 'package:moatmat_uploader/Features/notifications/domain/usecases/initialize_firebase_notifications_usecase.dart';
import 'package:moatmat_uploader/Features/notifications/domain/usecases/initialize_local_notifications_usecase.dart';
import 'package:moatmat_uploader/Features/notifications/domain/usecases/mark_notification_seen.dart';
import 'package:moatmat_uploader/Features/notifications/domain/usecases/refresh_device_token_usecase.dart';
import 'package:moatmat_uploader/Features/notifications/domain/usecases/register_device_token_usecase.dart';
import 'package:moatmat_uploader/Features/notifications/domain/usecases/subscribe_to_topic_usecase.dart';
import 'package:moatmat_uploader/Features/notifications/domain/usecases/unsubscribe_to_topic_usecase.dart';
import 'package:moatmat_uploader/Presentation/notifications/state/initialize_notifications_cubit/initialize_notifications_cubit.dart';
import 'package:moatmat_uploader/Presentation/notifications/state/notification_settings_bloc/notification_settings_bloc.dart';
import 'package:moatmat_uploader/Presentation/notifications/state/notifications_bloc/notifications_bloc.dart';

final locator = GetIt.instance;

Future<void> injectNotifications() async {
  await injectDS();
  await injectRepo();
  await injectUC();
  await injectPlugins();
  await injectBlocs();
  //
  await locator<InitializeLocalNotificationsUsecase>().call();
  await locator<InitializeFirebaseNotificationsUsecase>().call();
}

Future<void> injectUC() async {
  locator.registerFactory<InitializeFirebaseNotificationsUsecase>(
    () => InitializeFirebaseNotificationsUsecase(repository: locator()),
  );
  locator.registerFactory<InitializeLocalNotificationsUsecase>(
    () => InitializeLocalNotificationsUsecase(repository: locator()),
  );

  locator.registerFactory<GetDeviceTokenUsecase>(
    () => GetDeviceTokenUsecase(repository: locator()),
  );
  locator.registerFactory<DisplayNotificationUsecase>(
    () => DisplayNotificationUsecase(repository: locator()),
  );
  locator.registerFactory<DisplayFirebaseNotificationUsecase>(
    () => DisplayFirebaseNotificationUsecase(repository: locator()),
  );

  locator.registerFactory<CreateNotificationsChannelUsecase>(
    () => CreateNotificationsChannelUsecase(repository: locator()),
  );
  locator.registerFactory<SubscribeToTopicUsecase>(
    () => SubscribeToTopicUsecase(repository: locator()),
  );
  locator.registerFactory<UnsubscribeToTopicUsecase>(
    () => UnsubscribeToTopicUsecase(repository: locator()),
  );
  locator.registerFactory<GetNotificationsUsecase>(
    () => GetNotificationsUsecase(repository: locator()),
  );
  locator.registerFactory<RefreshDeviceTokenUsecase>(
    () => RefreshDeviceTokenUsecase(repository: locator()),
  );

  locator.registerLazySingleton(
    () => DeleteDeviceTokenUsecase(repository: locator()),
  );
  locator.registerLazySingleton(
    () => RegisterDeviceTokenUseCase(repository: locator()),
  );

  locator.registerFactory<MarkNotificationSeenUseCase>(
    () => MarkNotificationSeenUseCase(repository: locator()),
  );
}

Future<void> injectRepo() async {
  locator.registerLazySingleton<NotificationsRepository>(
    () => NotificationsRepositoryImplements(
        locator<NotificationsRemoteDatasource>(),
        locator<NotificationLocalDataSource>()),
  );
}

Future<void> injectDS() async {
  locator.registerLazySingleton<NotificationsRemoteDatasource>(
    () => NotificationsRemoteDatasourceImpl(),
  );
  locator.registerLazySingleton<NotificationLocalDataSource>(
    () => NotificationLocalDataSourceImpl(sharedPreferences: locator()),
  );
}

Future<void> injectBlocs() async {
  locator.registerFactory(() => InitializeNotificationsCubit(
        initializeLocalNotifications: locator(),
        initializeFirebaseNotifications: locator(),
      ));
  locator.registerLazySingleton(() => NotificationSettingsBloc(
        getDeviceToken: locator(),
        subscribeToTopic: locator(),
        unsubscribeFromTopic: locator(),
      ));

  locator.registerLazySingleton(() => NotificationsBloc(
        getNotificationsUsecase: locator(),
        markNotificationSeen: locator(),
      ));
}

Future<void> injectPlugins() async {
  locator.registerSingleton<FlutterLocalNotificationsPlugin>(
      FlutterLocalNotificationsPlugin());
}
