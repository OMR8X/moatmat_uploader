import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moatmat_uploader/Core/widgets/toucheable_tile_widget.dart';
import 'package:moatmat_uploader/Features/banks/domain/entities/bank.dart';
import 'package:moatmat_uploader/Features/students/domain/entities/test_details.dart';

import '../../../Core/resources/sizes_resources.dart';
import '../../../Core/resources/spacing_resources.dart';
import '../../../Core/widgets/fields/elevated_button_widget.dart';

class AnswersPercentage extends StatefulWidget {
  const AnswersPercentage({
    super.key,
    required this.details,
    required this.bank,
  });
  final RepositoryDetails details;
  final Bank bank;

  @override
  State<AnswersPercentage> createState() => _AnswersPercentageState();
}

class _AnswersPercentageState extends State<AnswersPercentage> {
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("نسب اختيار الأجوبة"),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: widget.bank.questions.length,
              itemBuilder: (context, index) {
                return Center(
                  child: Column(
                    children: List.generate(
                      widget.bank.questions[index].answers.length,
                      (i) {
                        final p = widget.details.selectionPercents[index][i];
                        return TouchableTileWidget(
                          title: func(i),
                          icon: Text("%${p * 100}"),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: SizesResources.s8),
            child: SizedBox(
              width: SpacingResources.mainWidth(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButtonWidget(
                    text: "السابق",
                    width: SpacingResources.mainHalfWidth(context),
                    onPressed: () {
                      _controller.previousPage(
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeIn,
                      );
                    },
                  ),
                  const Spacer(),
                  ElevatedButtonWidget(
                    text: "التالي",
                    width: SpacingResources.mainHalfWidth(context),
                    onPressed: () {
                      _controller.nextPage(
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeIn,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String func(int index) {
    return String.fromCharCode(65 + index); // ASCII value of 'A' is 65
  }
}
