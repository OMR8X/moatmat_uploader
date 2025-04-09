import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moatmat_uploader/Presentation/groups/state/groups/students_groups_cubit.dart';
import 'package:moatmat_uploader/Presentation/groups/views/group_v.dart';
import 'package:moatmat_uploader/Presentation/groups/views/groups_v.dart';
import 'package:moatmat_uploader/Presentation/groups/widgets/group_tile_w.dart';

class GroupsViewsManager extends StatefulWidget {
  const GroupsViewsManager({super.key});

  @override
  State<GroupsViewsManager> createState() => _GroupsViewsManagerState();
}

class _GroupsViewsManagerState extends State<GroupsViewsManager> {
  @override
  void initState() {
    context.read<StudentsGroupsCubit>().init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<StudentsGroupsCubit, StudentsGroupsState>(
        builder: (context, state) {
          if (state is StudentsGroupsInitial) {
            return GroupsView(
              groups: state.groups,
              onTap: (index) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => GroupView(group: state.groups[index]),
                  ),
                );
              },
            );
          } else if (state is StudentsGroupsError) {
            return Center(
              child: Text(state.error),
            );
          }
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        },
      ),
    );
  }
}
