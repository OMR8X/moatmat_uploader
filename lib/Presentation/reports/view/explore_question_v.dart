import 'package:flutter/material.dart';
import 'package:moatmat_uploader/Features/banks/domain/entities/bank.dart';
import 'package:moatmat_uploader/Features/tests/domain/entities/test/test.dart';

import '../../banks/views/add_bank_view.dart';
import '../../tests/views/add_test_vew.dart';

class ExploreQuestionView extends StatelessWidget {
  const ExploreQuestionView({
    super.key,
    this.test,
    this.bank,
  });
  final Test? test;
  final Bank? bank;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("تفاصيل السؤال"),
        actions: [
          TextButton(
            onPressed: () {
              if (bank != null) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => AddBankView(bank: bank),
                  ),
                );
              }
              if (test != null) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => AddTestView(test: test),
                  ),
                );
              }
            },
            child: Text("تعديل ال${test != null ? "الاختبار" : "البنك"}"),
          ),
        ],
      ),
    );
  }
}
