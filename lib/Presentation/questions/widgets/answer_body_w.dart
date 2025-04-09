import 'package:flutter/material.dart';
import 'package:moatmat_uploader/Features/tests/domain/entities/question/answer.dart';

import '../../../Core/resources/sizes_resources.dart';
import '../../../Core/resources/spacing_resources.dart';
import 'question_body_w.dart';

class AnswerBodyWidget extends StatefulWidget {
  const AnswerBodyWidget({super.key, required this.answer});
  final Answer answer;
  @override
  State<AnswerBodyWidget> createState() => _AnswerBodyWidgetState();
}

class _AnswerBodyWidgetState extends State<AnswerBodyWidget> {
  @override
  void didUpdateWidget(covariant AnswerBodyWidget oldWidget) {
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
            if (widget.answer.text != null && widget.answer.text != "") ...[
              const SizedBox(height: SizesResources.s2),
              QuestionTextBuilderWidget(
                text: widget.answer.text!,
                equations: widget.answer.equations ?? [],
                colors: const [],
              ),
            ],
            //
            if (widget.answer.image != null && widget.answer.image != "") ...[
              const SizedBox(height: SizesResources.s2),
              AnswerImageBuilderWidget(image: widget.answer.image!),
              const SizedBox(height: SizesResources.s2),
            ],
            //
          ],
        ),
      ],
    );
  }
}

class AnswerImageBuilderWidget extends StatelessWidget {
  const AnswerImageBuilderWidget({
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
          width: SpacingResources.mainWidth(context) / 2,
        ),
      );
    } else {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(
          image,
          width: SpacingResources.mainWidth(context) / 2,
        ),
      );
    }
  }
}
