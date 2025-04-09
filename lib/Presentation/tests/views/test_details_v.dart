import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moatmat_uploader/Core/functions/show_alert.dart';
import 'package:moatmat_uploader/Core/injection/app_inj.dart';
import 'package:moatmat_uploader/Core/widgets/toucheable_tile_widget.dart';
import 'package:moatmat_uploader/Features/auth/domain/entites/teacher_data.dart';
import 'package:moatmat_uploader/Features/tests/domain/entities/test/test.dart';
import 'package:moatmat_uploader/Presentation/tests/state/my_tests/my_tests_cubit.dart';
import 'package:moatmat_uploader/Presentation/tests/state/test_information/test_information_cubit.dart';
import 'package:moatmat_uploader/Presentation/tests/views/add_test_vew.dart';

import '../../folders/view/add_item_to_folder_v.dart';

class TestDetailsView extends StatefulWidget {
  const TestDetailsView({
    super.key,
    this.test,
    this.testId,
  });
  final int? testId;
  final Test? test;
  @override
  State<TestDetailsView> createState() => _TestDetailsViewState();
}

class _TestDetailsViewState extends State<TestDetailsView> {
  late Test test;
  @override
  void initState() {
    context.read<TestInformationCubit>().init(
          test: widget.test,
          testId: widget.testId,
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TestInformationCubit, TestInformationState>(
        builder: (context, state) {
          if (state is TestInformationInitial) {
            return Scaffold(
              appBar: AppBar(
                title: Text(state.test.information.title),
              ),
              body: Column(
                children: [
                  TouchableTileWidget(
                    title: "تعديل",
                    iconData: Icons.edit,
                    onTap: () async {
                      if (locator<TeacherData>().options.allowUpdate) {
                        //
                        await Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AddTestView(
                            test: state.test,
                          ),
                        ));
                        //
                        if (mounted) {
                          context.read<MyTestsCubit>().init();
                          Navigator.of(context).pop();
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("غير مسموح بالعملية"),
                          ),
                        );
                      }
                    },
                  ),
                  TouchableTileWidget(
                    title: "إضافة الاختبار إلى مجلد",
                    iconData: Icons.folder,
                    onTap: () async {
                      if (locator<TeacherData>().options.allowUpdate) {
                        //
                        await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => AddItemToFolderView(
                              id: state.test.id,
                              isTest: true,
                              teacherEmail: state.test.teacherEmail,
                            ),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("غير مسموح بالعملية"),
                          ),
                        );
                      }
                    },
                  ),
                  TouchableTileWidget(
                    title: "حذف",
                    iconData: Icons.delete,
                    onTap: () {
                      if (locator<TeacherData>().options.allowDelete) {
                        showAlert(
                          context: context,
                          title: "تأكيد",
                          body: "هل انت متاكد من انك تريد حذف الاختبار",
                          onAgree: () {
                            context.read<MyTestsCubit>().deleteTest(state.test);
                            Navigator.of(context).pop();
                          },
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("غير مسموح بالعملية"),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            );
          } else if (state is TestInformationError) {
            return Scaffold(
              appBar: AppBar(),
              body: Center(
                child: Text(state.message ?? ""),
              ),
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
