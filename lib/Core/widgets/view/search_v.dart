import 'package:flutter/material.dart';

import '../../resources/sizes_resources.dart';
import '../../validators/not_empty_v.dart';
import '../fields/elevated_button_widget.dart';
import '../fields/text_input_field.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key, required this.onSearch});
  final Function(String) onSearch;

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  //
  final _formKey = GlobalKey<FormState>();
  String text = "";
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            //
            const SizedBox(height: SizesResources.s2),
            //
            MyTextFormFieldWidget(
              hintText: "ادخل الاسم",
              maxLines: 1,
              validator: (text) {
                return notEmptyValidator(text: text);
              },
              onSaved: (p0) {
                text = p0 ?? "";
              },
            ),
            //
            const SizedBox(height: SizesResources.s4),
            //
            ElevatedButtonWidget(
              text: "بحث",
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  _formKey.currentState?.save();
                  Navigator.of(context).pop();
                  widget.onSearch(text);
                }
              },
            ),
            //
          ],
        ),
      ),
    );
  }
}
