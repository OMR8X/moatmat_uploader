import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:moatmat_uploader/Presentation/tests/state/my_tests/my_tests_cubit.dart';
import 'package:moatmat_uploader/Presentation/tests/views/test_details_v.dart';
import 'package:moatmat_uploader/Presentation/tests/views/tests_and_folders_builder_v.dart';

import '../../../Core/widgets/appbar/contact_us_w.dart';
import '../../../Core/widgets/appbar/report_icon_w.dart';
import '../../../Core/widgets/appbar/search_icon_w.dart';
import 'add_test_vew.dart';

class MyTestsView extends StatefulWidget {
  const MyTestsView({super.key, required this.material});
  final String material;
  @override
  State<MyTestsView> createState() => _MyTestsViewState();
}

class _MyTestsViewState extends State<MyTestsView> {
  @override
  void initState() {
    context.read<MyTestsCubit>().init(material: widget.material);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("تصفح الاختبارات"),
        actions: const [
          ContactUsWidget(),
        ],
      ),
      body: BlocBuilder<MyTestsCubit, MyTestsState>(
        builder: (context, state) {
          if (state is MyTestsInitial) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<MyTestsCubit>().update();
              },
              child: TestsAndFoldersViewBuilder(
                tests: state.tests,
                folders: const [],
                onOpenTest: (i, t) async {
                  await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => TestDetailsView(
                        test: state.tests[i],
                      ),
                    ),
                  );
                  if (mounted) {
                    context.read<MyTestsCubit>().update();
                  }
                },
                onOpenFolder: (i, f) async {},
                onBack: () {},
                onDeleteFolder: (int i, String f) {},
                onUpdateFolder: (int i, String f) {},
              ),
            );
          } else if (state is MyTestsError) {
            return const Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                  child: Text(
                "data",
                textAlign: TextAlign.center,
              )),
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
