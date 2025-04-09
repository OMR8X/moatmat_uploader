import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:moatmat_uploader/Core/widgets/material_picker_v.dart';

import '../../banks/views/add_bank_view.dart';
import '../../banks/views/banks_search_result_v.dart';
import '../../banks/views/my_banks_v.dart';
import '../../tests/views/add_test_vew.dart';
import '../../tests/views/my_tests_v.dart';
import '../../tests/views/tests_search_result_v.dart';

class PagesHolderView extends StatefulWidget {
  const PagesHolderView({super.key});

  @override
  State<PagesHolderView> createState() => _PagesHolderViewState();
}

class _PagesHolderViewState extends State<PagesHolderView> {
  int index = 0;
  late final PageController _pageController;
  @override
  void initState() {
    _pageController = PageController(
      initialPage: index,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (value) {
          index = value;
          setState(() {});
        },
        children: [
          //
          MaterialPickerView(
            onPick: (s) {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => MyTestsView(
                  material: s,
                ),
              ));
            },
            onSearch: (p0) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => TestsSearchResultView(keyword: p0),
                ),
              );
            },
          ),
          //
          // MyBanksView()
          MaterialPickerView(
            onPick: (s) {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => MyBanksView(material: s),
              ));
            },
            onSearch: (p0) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => BanksSearchResultView(keyword: p0),
                ),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (value) {
          _pageController.animateToPage(value, curve: Curves.easeIn, duration: const Duration(milliseconds: 200));
          index = value;
          setState(() {});
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.quiz),
            label: "اختباراتي",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            label: "بنوكي",
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_home,
        children: [
          SpeedDialChild(
            label: "إضافة بنك",
            child: const Icon(Icons.add),
            onTap: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AddBankView(),
                ),
              );
              FocusManager.instance.primaryFocus?.unfocus();
            },
          ),
          SpeedDialChild(
            label: "إضافة أختبار",
            child: const Icon(Icons.add),
            onTap: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const AddTestView()),
              );
              FocusManager.instance.primaryFocus?.unfocus();
            },
          ),
        ],
      ),
    );
  }
}
