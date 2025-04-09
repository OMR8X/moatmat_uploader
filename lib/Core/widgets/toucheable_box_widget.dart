import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../resources/colors_r.dart';
import '../resources/fonts_r.dart';
import '../resources/shadows_r.dart';
import '../resources/sizes_resources.dart';
import '../resources/spacing_resources.dart';

class TouchableBoxWidget extends StatelessWidget {
  const TouchableBoxWidget(
      {super.key,
      required this.title,
      this.subTitle,
      this.iconData,
      this.onTap});
  final String title;
  final String? subTitle;
  final IconData? iconData;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: SizesResources.s1),
          width: SpacingResources.mainHalfWidth(context),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: ShadowsResources.mainBoxShadow,
            color: ColorsResources.onPrimary,
          ),
          child: Material(
            borderRadius: BorderRadius.circular(12),
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.all(SizesResources.s4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: FontsResources.styleLight().copyWith(
                            color: ColorsResources.blackText1,
                            fontWeight: FontWeight.w500,
                            fontSize: 10,
                          ),
                        ),
                        if (subTitle != null) ...[
                          const SizedBox(height: SizesResources.s2),
                          Text(
                            subTitle!,
                            textAlign: TextAlign.start,
                            style: FontsResources.styleLight().copyWith(
                              color: ColorsResources.blackText1,
                              fontSize: 10,
                            ),
                          ),
                        ]
                      ],
                    ),
                    Icon(
                      iconData,
                      color: ColorsResources.blackText2,
                      size: 8,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
