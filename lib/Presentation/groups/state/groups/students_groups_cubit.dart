import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:moatmat_uploader/Core/injection/app_inj.dart';
import 'package:moatmat_uploader/Features/groups/domain/usecases/add_group_uc.dart';
import 'package:moatmat_uploader/Features/groups/domain/usecases/add_to_group_uc.dart';
import 'package:moatmat_uploader/Features/groups/domain/usecases/get_groups_uc.dart';
import 'package:moatmat_uploader/Features/groups/domain/usecases/remove_from_group_uc.dart';
import 'package:moatmat_uploader/Features/groups/domain/usecases/remove_group_uc.dart';
import 'package:moatmat_uploader/Features/students/domain/entities/user_data.dart';

import '../../../../Features/groups/domain/entities/group.dart';
import '../../../../Features/groups/domain/entities/group_item.dart';

part 'students_groups_state.dart';

class StudentsGroupsCubit extends Cubit<StudentsGroupsState> {
  StudentsGroupsCubit() : super(StudentsGroupsLoading());
  List<Group> groups = [];
  init() async {
    //
    emit(StudentsGroupsLoading());
    //
    var res = await locator<GetGroupsUc>().call();
    //
    res.fold(
      (l) {
        emit(StudentsGroupsError(error: l.toString()));
      },
      (r) {
        groups = r;
        emit(StudentsGroupsInitial(groups: r));
      },
    );
  }

  update() async {
    //
    var res = await locator<GetGroupsUc>().call();
    //
    res.fold(
      (l) {
        emit(StudentsGroupsError(error: l.toString()));
      },
      (r) {
        groups = r;
        emit(StudentsGroupsInitial(groups: r));
      },
    );
  }

  addGroup({required String group}) async {
    //
    emit(StudentsGroupsLoading());
    //
    await locator<AddGroupUc>().call(
      group: Group(
        id: 0,
        name: group,
        items: [],
      ),
    );
    //
    update();
  }

  addGroupItem({required int groupId, required UserData userData}) async {
    //
    emit(StudentsGroupsLoading());
    //
    await locator<AddToGroupUc>().call(
      groupId: groupId,
      item: GroupItem(
        id: 0,
        customClass: "",
        userData: userData,
      ),
    );
    //
    update();
  }

  deleteGroupItem({required int groupId, required int itemId}) async {
    //
    emit(StudentsGroupsLoading());
    //
    await locator<RemoveFromGroupUc>().call(
      groupId: groupId,
      itemId: itemId,
    );
    //
    update();
  }

  deleteGroup({required int groupId}) async {
    //
    emit(StudentsGroupsLoading());
    //
    await locator<RemoveGroupUc>().call(
      groupId: groupId,
    );
    //
    update();
  }
}
