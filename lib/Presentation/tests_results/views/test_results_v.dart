import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moatmat_uploader/Core/functions/math/mark_to_latter_f.dart';
import 'package:moatmat_uploader/Core/widgets/toucheable_tile_widget.dart';
import 'package:moatmat_uploader/Features/tests/domain/entities/test/test.dart';
import 'package:moatmat_uploader/Presentation/tests_results/views/answers_percentage_v.dart';

import '../../../Core/widgets/view/search_in_results_v.dart';
import '../../students/views/student_v.dart';
import '../state/cubit/test_results_cubit.dart';

class TestResultsView extends StatefulWidget {
  const TestResultsView({super.key, required this.test});
  final Test test;
  @override
  State<TestResultsView> createState() => _TestResultsViewState();
}

class _TestResultsViewState extends State<TestResultsView> {
  @override
  void initState() {
    context.read<TestResultsCubit>().init(widget.test);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TestResultsCubit, TestResultsState>(
        builder: (context, state) {
          if (state is TestResultsInitial) {
            return Scaffold(
              appBar: AppBar(
                title: Text("نتائج ${widget.test.information.title}"),
                actions: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => SearchInResultsView(
                            results: state.details.marks.map((e) {
                              return e.$1;
                            }).toList(),
                            onPick: (r) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => StudentView(
                                    userId: r.userId,
                                    result: r,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.search),
                  )
                ],
              ),
              body: RefreshIndicator(
                onRefresh: () async {
                  context.read<TestResultsCubit>().update();
                  return;
                },
                child: ListView.builder(
                  itemCount: state.details.marks.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        if (index == 0)
                          TouchableTileWidget(
                            title: "عرض نسب الاختيارات",
                            subTitle: "نسب اختيارات الطلاب للاجوبة",
                            iconData: Icons.arrow_forward_ios,
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => AnswersPercentage(
                                    details: state.details,
                                    test: widget.test,
                                  ),
                                ),
                              );
                            },
                          ),
                        TouchableTileWidget(
                          //
                          title: "%${state.details.marks[index].$2 * 100}",
                          //
                          subTitle: markToLatterFunction(
                              state.details.marks[index].$2),
                          //
                          subTitle2: state.details.marks[index].$1.userName,
                          //
                          icon: Text(("%${state.details.average * 100}")),
                          //
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => StudentView(
                                  userId: state.details.marks[index].$1.userId,
                                  result: state.details.marks[index].$1,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
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
