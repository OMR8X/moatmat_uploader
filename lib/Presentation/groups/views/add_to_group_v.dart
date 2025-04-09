import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moatmat_uploader/Features/students/domain/entities/user_data.dart';
import 'package:moatmat_uploader/Presentation/groups/state/groups/students_groups_cubit.dart';
import 'package:moatmat_uploader/Presentation/groups/views/groups_v.dart';

class AddToGroupView extends StatelessWidget {
  const AddToGroupView({
    super.key,
    required this.userData,
  });
  final UserData userData;
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<StudentsGroupsCubit>();
    return Scaffold(
      appBar: AppBar(
        title: Text("إضافة ${userData.name} إلى مجموعة"),
      ),
      body: GroupsView(
        groups: cubit.groups,
        onTap: (i) {
          //
          cubit.addGroupItem(userData: userData, groupId: cubit.groups[i].id);
          //
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("تمت الإضافة"),
            ),
          );
          //
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
