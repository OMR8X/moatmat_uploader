import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moatmat_uploader/Features/notifications2/domain/usecases/send_notification_uc.dart';
import 'package:moatmat_uploader/Features/students/domain/entities/result.dart';
import 'package:moatmat_uploader/Presentation/groups/state/groups/students_groups_cubit.dart';
import 'package:moatmat_uploader/Presentation/groups/views/add_to_group_v.dart';
import 'package:moatmat_uploader/Presentation/groups/views/groups_v.dart';
import 'package:moatmat_uploader/Presentation/notifications2/views/send_notification_v.dart';
import 'package:moatmat_uploader/Presentation/students/state/my_students/my_students_cubit.dart';
import 'package:moatmat_uploader/Presentation/students/state/student/student_cubit.dart';
import 'package:moatmat_uploader/Presentation/students/views/student_result_details_v.dart';
import '../../../Core/functions/show_alert.dart';
import '../../../Core/resources/sizes_resources.dart';
import '../widgets/result_tile_w.dart';

class StudentView extends StatefulWidget {
  const StudentView({
    super.key,
    required this.userId,
    this.result,
  });
  final String userId;
  final Result? result;
  @override
  State<StudentView> createState() => _StudentViewState();
}

class _StudentViewState extends State<StudentView> {
  @override
  void initState() {
    context.read<StudentCubit>().init(id: widget.userId, result: widget.result);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<StudentCubit, StudentState>(
        builder: (context, state) {
          if (state is StudentInitial) {
            return Scaffold(
              appBar: AppBar(
                title: Text(state.userData.name),
                actions: [
                  //
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              AddToGroupView(userData: state.userData),
                        ),
                      );
                    },
                    icon: const Icon(Icons.add),
                  ),
                  //
                  const SizedBox(width: SizesResources.s2),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => SendNotificationView(
                            userData: state.userData,
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.notification_add),
                  ),
                  //
                  const SizedBox(width: SizesResources.s2),
                  //
                  IconButton(
                    onPressed: () async {
                      showAlert(
                        context: context,
                        title: "تاكيد الحذف",
                        body:
                            "هل انت متاكد من انك تريد حذف جميع نتائج الطالب التي تخص اختباراتك؟",
                        onAgree: () async {
                          //
                          List<int> results = [];
                          //
                          results = state.results.map((e) => e.id).toList();
                          //
                          await context
                              .read<StudentCubit>()
                              .deleteResult(results);
                          //
                          context.read<MyStudentsCubit>().init();
                          //
                          Navigator.of(context).pop();
                        },
                      );
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                      size: 18,
                    ),
                  ),
                ],
              ),
              body: RefreshIndicator(
                onRefresh: () async {
                  context.read<StudentCubit>().init(id: widget.userId);
                  return;
                },
                child: ListView.builder(
                  itemCount: state.results.length,
                  itemBuilder: (context, index) {
                    return ResultTileWidget(
                      //
                      result: state.results[index],
                      //
                      onExploreResult: () {
                        context
                            .read<StudentCubit>()
                            .showResultDetails(state.results[index]);
                      },
                    );
                  },
                ),
              ),
            );
          } else if (state is StudentResultDetails) {
            return StudentResultDetailsView(
              test: state.test,
              bank: state.bank,
              testAverage: state.testAverage,
              wrongAnswers: state.wrongAnswers,
              result: state.result,
              userData: state.userData,
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
