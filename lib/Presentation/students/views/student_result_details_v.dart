import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moatmat_uploader/Core/functions/math/calculate_mark_f.dart';
import 'package:moatmat_uploader/Core/functions/math/mark_to_latter_f.dart';
import 'package:moatmat_uploader/Core/functions/parsers/date_to_text_f.dart';
import 'package:moatmat_uploader/Core/functions/show_alert.dart';
import 'package:moatmat_uploader/Core/resources/colors_r.dart';
import 'package:moatmat_uploader/Core/resources/fonts_r.dart';
import 'package:moatmat_uploader/Core/resources/shadows_r.dart';
import 'package:moatmat_uploader/Core/resources/sizes_resources.dart';
import 'package:moatmat_uploader/Core/resources/spacing_resources.dart';
import 'package:moatmat_uploader/Core/widgets/ui/divider_w.dart';
import 'package:moatmat_uploader/Features/banks/domain/entities/bank.dart';
import 'package:moatmat_uploader/Features/tests/domain/entities/question/answer.dart';
import 'package:moatmat_uploader/Features/tests/domain/entities/question/question.dart';
import 'package:moatmat_uploader/Presentation/questions/widgets/answer_item_widget.dart';
import 'package:moatmat_uploader/Presentation/questions/widgets/question_item_widget.dart';
import 'package:moatmat_uploader/Presentation/students/state/student/student_cubit.dart';

import '../../../Core/functions/parsers/period_to_text_f.dart';
import '../../../Core/functions/parsers/time_to_text_f.dart';
import '../../../Features/students/domain/entities/result.dart';
import '../../../Features/students/domain/entities/user_data.dart';
import '../../../Features/tests/domain/entities/test/test.dart';

class StudentResultDetailsView extends StatefulWidget {
  const StudentResultDetailsView({
    super.key,
    required this.test,
    required this.bank,
    required this.testAverage,
    required this.wrongAnswers,
    required this.result,
    required this.userData,
  });
  final Test? test;
  final Bank? bank;
  final double testAverage;
  final List<(Question, int?)> wrongAnswers;
  final Result result;
  final UserData userData;

  @override
  State<StudentResultDetailsView> createState() => _StudentResultDetailsViewState();
}

class _StudentResultDetailsViewState extends State<StudentResultDetailsView> {
  int id = 0;
  List<Question> questions = [];
  @override
  void initState() {
    if (widget.test != null) {
      id = widget.test!.id;
      questions = widget.test!.questions;
    }
    if (widget.bank != null) {
      id = widget.bank!.id;
      questions = widget.bank!.questions;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(
              onPressed: () {
                context.read<StudentCubit>().pop();
              },
              icon: const Icon(Icons.arrow_back_ios),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 4),
              child: Text("تفاصيل النتيجة"),
            )
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              showAlert(
                context: context,
                title: "تاكيد الحذف",
                body: "هل انت متاكد من انك تريد حذف نتيجة الطالب؟",
                onAgree: () {
                  context.read<StudentCubit>().deleteResult(
                    [widget.result.id],
                  );
                },
              );
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
              size: 18,
            ),
          )
        ],
      ),
      body: Center(
        child: ListView(
          children: [
            //
            InfoItemWidget(
              t1: "الاسم",
              t2: widget.userData.name,
            ),
            //
            InfoItemWidget(
              t1: "العلامة",
              t2: "%${(calculateMarkFunction(
                    widget.result,
                    questions,
                  ) * 100)}",
            ),
            //
            InfoItemWidget(
              t1: "المعدل العام",
              t2: "%${widget.testAverage.toStringAsFixed(2)}",
            ),

            //
            InfoItemWidget(
              t1: "التصنيف",
              t2: (markToLatterFunction(calculateMarkFunction(
                widget.result,
                questions,
              ))),
            ),
            //
            InfoItemWidget(
              t1: "تاريخ الحل",
              t2: dateToTextFunction(widget.result.date),
            ),
            //
            InfoItemWidget(
              t1: "وقت الحل",
              t2: timeToText(widget.result.date),
            ),
            //
            InfoItemWidget(
              t1: "مدة الحل",
              t2: periodToTextFunction(widget.result.period),
            ),
            InfoItemWidget(
              t1: "رقم الاختبار",
              t2: id.toString(),
            ),

            //
            const SizedBox(height: SizesResources.s4),
            //
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: SpacingResources.mainWidth(context),
                  child: const Row(
                    children: [
                      Text("الإجابات الخاطئة :"),
                    ],
                  ),
                ),
              ],
            ),
            //
            const SizedBox(height: SizesResources.s2),
            //
            ListView.separated(
              //
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              //
              itemCount: widget.wrongAnswers.length,
              separatorBuilder: (context, index) {
                return const DividerWidget();
              },
              //
              itemBuilder: (context, i) {
                //
                Question question = widget.wrongAnswers[i].$1;
                //
                Answer? answer;
                //
                if (widget.wrongAnswers[i].$2 != null) {
                  answer = question.answers[widget.wrongAnswers[i].$2!];
                }
                //

                return Column(
                  children: [
                    QuestionItemWidget(question: question),
                    ...List.generate(
                      question.answers.length,
                      (i) {
                        return AnswerItemWidget(
                          answer: question.answers[i],
                          selected: question.answers[i].id == answer?.id,
                        );
                      },
                    ),
                    if (answer == null)
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "لم يتم الاجابة",
                          style: TextStyle(
                            color: ColorsResources.red,
                          ),
                        ),
                      )
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class InfoItemWidget extends StatelessWidget {
  const InfoItemWidget({
    super.key,
    required this.t1,
    required this.t2,
    this.w1,
    this.w2,
  });
  final String? t1, t2;
  final Widget? w1, w2;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: SpacingResources.mainWidth(context),
          margin: const EdgeInsets.symmetric(
            vertical: SizesResources.s1,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: SizesResources.s3,
            vertical: SizesResources.s3,
          ),
          decoration: BoxDecoration(
            color: ColorsResources.onPrimary,
            borderRadius: BorderRadius.circular(10),
            boxShadow: ShadowsResources.mainBoxShadow,
          ),
          child: Row(
            children: [
              //
              if (w1 != null) w1!,
              if (t1 != null)
                Text(
                  t1!,
                  style: FontsResources.styleMedium(
                    size: 12,
                  ),
                ),
              const Spacer(),
              //
              if (t2 != null)
                Text(
                  t2!,
                  style: FontsResources.styleRegular(
                    size: 12,
                  ),
                ),
              if (w2 != null) w2!,
            ],
          ),
        ),
      ],
    );
  }
}
