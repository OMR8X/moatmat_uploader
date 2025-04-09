import 'package:moatmat_uploader/Features/groups/data/datasources/groups_ds.dart';
import 'package:moatmat_uploader/Features/groups/data/repository/groups_repository_impl.dart';
import 'package:moatmat_uploader/Features/groups/domain/repository/groups_repository.dart';
import 'package:moatmat_uploader/Features/groups/domain/usecases/add_to_group_uc.dart';
import 'package:moatmat_uploader/Features/groups/domain/usecases/get_groups_uc.dart';
import 'package:moatmat_uploader/Features/groups/domain/usecases/remove_from_group_uc.dart';
import 'package:moatmat_uploader/Features/groups/domain/usecases/remove_group_uc.dart';
import '../../Features/groups/domain/usecases/add_group_uc.dart';
import 'app_inj.dart';

injectGroups() {
  injectDS();
  injectRepo();
  injectUC();
}

void injectUC() {
  locator.registerFactory<AddToGroupUc>(
    () => AddToGroupUc(
      repository: locator(),
    ),
  );
  locator.registerFactory<RemoveFromGroupUc>(
    () => RemoveFromGroupUc(
      repository: locator(),
    ),
  );
  locator.registerFactory<GetGroupsUc>(
    () => GetGroupsUc(
      repository: locator(),
    ),
  );
  locator.registerFactory<AddGroupUc>(
    () => AddGroupUc(
      repository: locator(),
    ),
  );
  locator.registerFactory<RemoveGroupUc>(
    () => RemoveGroupUc(
      repository: locator(),
    ),
  );
}

void injectRepo() {
  locator.registerFactory<GroupsRepository>(
    () => GroupsRepositoryImpl(
      dataSource: locator(),
    ),
  );
}

void injectDS() {
  locator.registerFactory<GroupsDS>(
    () => GroupsDSImpl(),
  );
}
