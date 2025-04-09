import 'package:flutter/material.dart';
import 'package:moatmat_uploader/Core/functions/parsers/date_to_text_f.dart';
import 'package:moatmat_uploader/Core/resources/sizes_resources.dart';

import '../../../Core/functions/math/mark_to_latter_f.dart';
import '../../../Core/functions/parsers/period_to_text_f.dart';
import '../../../Core/resources/colors_r.dart';
import '../../../Core/resources/shadows_r.dart';
import '../../../Core/resources/spacing_resources.dart';
import '../../../Features/students/domain/entities/result.dart';

class ResultTileWidget extends StatelessWidget {
  const ResultTileWidget({
    super.key,
    required this.result,
    required this.onExploreResult,
  });
  final Result result;
  final VoidCallback onExploreResult;
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
          decoration: BoxDecoration(
            color: ColorsResources.onPrimary,
            boxShadow: ShadowsResources.mainBoxShadow,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: SizesResources.s3,
                horizontal: SizesResources.s3,
              ),
              child: Row(
                children: [
                  //
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            result.testName,
                            style: const TextStyle(
                              fontSize: 14,
                              color: ColorsResources.blackText1,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: SizesResources.s2),
                          Text(
                            "درجة الطالب : ${markToLatterFunction(result.mark / 100)}",
                            style: const TextStyle(
                              fontSize: 10,
                              color: ColorsResources.blackText1,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: SizesResources.s2),
                          Text(
                            "الوقت المنقضي : ${periodToTextFunction(result.period)}",
                            style: const TextStyle(
                              fontSize: 10,
                              color: ColorsResources.blackText1,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: SizesResources.s2),
                          Text(
                            "التاريخ : ${dateToTextFunction(result.date)}",
                            style: const TextStyle(
                              fontSize: 10,
                              color: ColorsResources.blackText1,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: SizesResources.s2),
                          Text(
                            "النوع : ${result.testId != null ? "اختبار" : "بنك"}",
                            style: const TextStyle(
                              fontSize: 10,
                              color: ColorsResources.blackText1,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  //
                  TextButton(
                    onPressed: onExploreResult,
                    child: const Text(
                      "تفاصيل",
                      style: TextStyle(
                        fontSize: 10,
                        color: ColorsResources.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
