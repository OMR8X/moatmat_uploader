import 'package:flutter/material.dart';
import '../../resources/colors_r.dart';
import '../../resources/fonts_r.dart';
import '../../resources/shadows_r.dart';
import '../../resources/sizes_resources.dart';
import '../../resources/spacing_resources.dart';

class CheckingWidget extends StatefulWidget {
  const CheckingWidget({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final bool? value;
  final void Function(bool? value) onChanged;
  @override
  State<CheckingWidget> createState() => _CheckingWidgetState();
}

class _CheckingWidgetState extends State<CheckingWidget> {
  bool? value = false;
  @override
  void initState() {
    value = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: SizesResources.s1),
          width: SpacingResources.mainWidth(context),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: ShadowsResources.mainBoxShadow,
            color: ColorsResources.onPrimary,
          ),
          child: Material(
            borderRadius: BorderRadius.circular(10),
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                widget.onChanged(!value!);
                setState(() {
                  value = !value!;
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(SizesResources.s1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: SpacingResources.mainWidth(context) - 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.title,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.clip,
                            style: FontsResources.styleMedium(
                              color: ColorsResources.blackText2,
                            ),
                          ),
                          Checkbox(
                            value: value ?? false,
                            onChanged: (v) {
                              widget.onChanged(v);
                              setState(() {
                                value = v;
                              });
                            },
                          ),
                        ],
                      ),
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
