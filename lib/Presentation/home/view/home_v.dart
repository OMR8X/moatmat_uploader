import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:moatmat_uploader/Core/functions/dialogs/add_group_d.dart';
import 'package:moatmat_uploader/Presentation/banks/views/add_bank_view.dart';
import 'package:moatmat_uploader/Presentation/groups/state/groups/students_groups_cubit.dart';
import 'package:moatmat_uploader/Presentation/groups/views/groups_views_manager.dart';
import 'package:moatmat_uploader/Presentation/tests/views/add_test_vew.dart';

import '../../../Core/widgets/appbar/contact_us_w.dart';
import '../../../Core/widgets/appbar/report_icon_w.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("الصفحة الرئيسية"),
        actions: const [
          ReportIconWidget(),
          ContactUsWidget(),
        ],
      ),
      body: const GroupsViewsManager(),
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
