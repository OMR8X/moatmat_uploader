import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Core/injection/app_inj.dart';
import '../../../Core/resources/colors_r.dart';
import '../../../Core/widgets/toucheable_tile_widget.dart';
import '../../../Features/auth/domain/entites/teacher_data.dart';
import '../../../Features/tests/domain/entities/question/question.dart';
import '../../folders/view/pick_teacher_item_v.dart';
import '../../questions/widgets/question_item_widget.dart';
import '../state/cubit/questions_picker_cubit.dart';

class QuestionsPickerViewsManager extends StatefulWidget {
  const QuestionsPickerViewsManager({
    super.key,
    required this.result,
  });
  //
  final Function(List<Question> questions) result;
  //
  @override
  State<QuestionsPickerViewsManager> createState() => _QuestionsPickerViewsManagerState();
}

class _QuestionsPickerViewsManagerState extends State<QuestionsPickerViewsManager> {
  @override
  void initState() {
    context.read<QuestionsPickerCubit>().init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<QuestionsPickerCubit, QuestionsPickerState>(
        builder: (context, state) {
          if (state is QuestionsPickerTeacher) {
            return Scaffold(
              appBar: AppBar(),
              body: ListView.builder(
                itemCount: state.teachers.length,
                itemBuilder: (context, index) {
                  return TouchableTileWidget(
                    title: state.teachers[index].name,
                    onTap: () {
                      context.read<QuestionsPickerCubit>().setTeacher(state.teachers[index].email);
                    },
                  );
                },
              ),
            );
          } else if (state is QuestionsPickerRepository) {
            return PopScope(
              canPop: true,
              child: DefaultTabController(
                length: 2,
                child: Scaffold(
                  appBar: AppBar(
                    bottom: const TabBar(
                      tabs: [
                        Tab(text: 'اختبارات'),
                        Tab(text: 'بنوك'),
                      ],
                    ),
                    actions: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(
                          Icons.close,
                          size: 30,
                          color: ColorsResources.red,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          widget.result(
                            context.read<QuestionsPickerCubit>().questions,
                          );
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(
                          Icons.done,
                          size: 30,
                          color: ColorsResources.green,
                        ),
                      ),
                    ],
                  ),
                  body: TabBarView(
                    children: [
                      PickTeacherItemView(
                        isTest: true,
                        teacherEmail: state.teacher,
                        onPickTest: (test) {
                          context.read<QuestionsPickerCubit>().setRepository(
                                bank: null,
                                test: test,
                              );
                        },
                      ),
                      PickTeacherItemView(
                        isTest: false,
                        teacherEmail: state.teacher,
                        onPickBank: (bank) {
                          context.read<QuestionsPickerCubit>().setRepository(
                                bank: bank,
                                test: null,
                              );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else if (state is QuestionsPickerQuestions) {
            return PopScope(
              canPop: false,
              onPopInvoked: (didPop) {},
              child: Scaffold(
                appBar: AppBar(
                  actions: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.close,
                        size: 30,
                        color: ColorsResources.red,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        widget.result(
                          context.read<QuestionsPickerCubit>().questions,
                        );
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.done,
                        size: 30,
                        color: ColorsResources.green,
                      ),
                    ),
                  ],
                ),
                body: ListView.builder(
                  itemCount: state.questions.length,
                  itemBuilder: (context, index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        QuestionItemWidget(
                          question: state.questions[index],
                          onTap: () {
                            context.read<QuestionsPickerCubit>().addQuestion(
                                  state.questions[index],
                                );
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("تمت إضافة السؤال"),
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
          return Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.close,
                    size: 30,
                    color: ColorsResources.red,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    widget.result(
                      context.read<QuestionsPickerCubit>().questions,
                    );
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.done,
                    size: 30,
                    color: ColorsResources.green,
                  ),
                ),
              ],
            ),
            body: const Center(
              child: CupertinoActivityIndicator(),
            ),
          );
        },
      ),
    );
  }
}
