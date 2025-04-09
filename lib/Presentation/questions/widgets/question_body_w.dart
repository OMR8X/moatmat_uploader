import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:moatmat_uploader/Core/resources/sizes_resources.dart';
import 'package:moatmat_uploader/Features/tests/domain/entities/question/question_word_color.dart';
import 'package:moatmat_uploader/Features/tests/domain/entities/question/question.dart';
import 'package:moatmat_uploader/Presentation/equations/widget/equation_text_builder_w.dart';
import '../../../Core/resources/colors_r.dart';
import '../../../Core/resources/spacing_resources.dart';
import '../../equations/widget/math_tex_w.dart';
import '../../equations/widget/text_w.dart';

class QuestionBodyWidget extends StatefulWidget {
  const QuestionBodyWidget({super.key, required this.question});
  final Question question;
  @override
  State<QuestionBodyWidget> createState() => _QuestionBodyWidgetState();
}

class _QuestionBodyWidgetState extends State<QuestionBodyWidget> {
  @override
  void didUpdateWidget(covariant QuestionBodyWidget oldWidget) {
    setState(() {});
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            //
            //
            if (widget.question.upperImageText != null && widget.question.upperImageText != "")
              QuestionTextBuilderWidget(
                text: widget.question.upperImageText!,
                equations: widget.question.equations,
                colors: const [],
              ),
            //
            if (widget.question.image != null && widget.question.image != "") ...[
              const SizedBox(height: SizesResources.s2),
              QuestionImageBuilderWidget(image: widget.question.image!),
              const SizedBox(height: SizesResources.s2),
            ],

            //
            if (widget.question.lowerImageText != null && widget.question.lowerImageText != "") ...[
              const SizedBox(height: SizesResources.s2),
              QuestionTextBuilderWidget(
                text: widget.question.lowerImageText!,
                equations: widget.question.equations,
                colors: widget.question.colors,
              ),
            ],
          ],
        ),
      ],
    );
  }
}

class QuestionImageBuilderWidget extends StatelessWidget {
  const QuestionImageBuilderWidget({
    super.key,
    required this.image,
  });

  final String image;

  @override
  Widget build(BuildContext context) {
    if (image.contains("supabase")) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          image,
          width: SpacingResources.mainWidth(context) - 50,
        ),
      );
    } else {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(
          image,
          width: SpacingResources.mainWidth(context) - 50,
        ),
      );
    }
  }
}

class QuestionTextBuilderWidget extends StatefulWidget {
  const QuestionTextBuilderWidget({
    super.key,
    required this.text,
    required this.equations,
    required this.colors,
  });
  final String text;
  final List<String> equations;
  final List<QuestionWordColor> colors;

  @override
  State<QuestionTextBuilderWidget> createState() => _QuestionTextBuilderWidgetState();
}

class _QuestionTextBuilderWidgetState extends State<QuestionTextBuilderWidget> {
  late List<String> words;
  late List<Color?> colors;
  @override
  void initState() {
    //
    words = widget.text.split(RegExp(r'(?<=\n)|(?=\n)| '));
    //
    colors = [];
    //
    for (int i = 0; i < words.length; i++) {
      colors.add(null);
    }

    for (var color in widget.colors) {
      if (color.index >= colors.length - 1) {
        continue;
      }
      colors[color.index] = color.color;
    }
    super.initState();
  }

  @override
  void didUpdateWidget(covariant QuestionTextBuilderWidget oldWidget) {
    //
    words = widget.text.split(RegExp(r'(?<=\n)|(?=\n)| '));
    //
    colors = [];
    //
    for (int i = 0; i < words.length; i++) {
      colors.add(null);
    }
    for (var color in widget.colors) {
      if (color.index >= colors.length - 1) {
        continue;
      }
      colors[color.index] = color.color;
    }
    setState(() {});
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SpacingResources.mainWidth(context) - SpacingResources.sidePadding,
      child: Directionality(
        textDirection: isArabic(widget.text) ? TextDirection.rtl : TextDirection.ltr,
        child: Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: List.generate(words.length, (index) {
            //
            if (containsEscapeSequence(words[index])) {
              //
              String equation = getEquationByFromText(words[index]);
              //
              return FittedBox(
                child: MathTexWidget(equation: equation, color: colors[index]),
              );
              //
            } else {
              //
              if (words[index] == '\n') {
                //
                return const NewLineWidget();
                //
              } else {
                //
                return SizedBox(
                  height: (13) * 2,
                  child: TextWidget(
                    text: words[index],
                    color: colors[index],
                  ),
                );
                //
              }
            }
          }),
        ),
      ),
    );
  }

  bool isArabic(String text) {
    return RegExp(r'[\u0600-\u06FF]').hasMatch(text);
  }

  bool containsEscapeSequence(String input) {
    RegExp regex = RegExp(r'\\[0-9]');
    return regex.hasMatch(input);
  }

  String getEquationByFromText(String text) {
    //
    text = text.replaceAll("\\", "");
    //
    int index = int.tryParse(text) ?? 0;
    //
    if (index <= (widget.equations.length - 1) && widget.equations.isNotEmpty) {
      text = widget.equations[index];
    }
    //
    return text;
  }
}
