import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moatmat_uploader/Core/functions/show_alert.dart';
import 'package:moatmat_uploader/Presentation/groups/state/groups/students_groups_cubit.dart';
import 'package:moatmat_uploader/Presentation/groups/widgets/group_tile_w.dart';

import '../../../Features/groups/domain/entities/group.dart';

class GroupsView extends StatelessWidget {
  const GroupsView({
    super.key,
    required this.groups,
    required this.onTap,
  });
  //
  final List<Group> groups;
  final Function(int index) onTap;
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: groups.length,
        itemBuilder: (context, index) {
          return GroupTileWidget(
            group: groups[index],
            onLongPress: () {
              showAlert(
                context: context,
                title: "حذف مجموعة ${groups[index].name}",
                body: "هل انت متاكد من رغبتك بحذف المجموعة؟",
                agreeBtn: "حذف",
                onAgree: () {
                  context.read<StudentsGroupsCubit>().deleteGroup(
                        groupId: groups[index].id,
                      );
                },
              );
            },
            onTap: () {
              onTap(index);
            },
          );
        },
      ),
    );
  }
}
