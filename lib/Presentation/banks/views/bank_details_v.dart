import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moatmat_uploader/Features/banks/domain/entities/bank.dart';
import 'package:moatmat_uploader/Presentation/banks/state/my_banks/my_banks_cubit.dart';
import 'package:moatmat_uploader/Presentation/banks/views/add_bank_view.dart';

import '../../../Core/functions/dialogs/add_item_to_folder.dart';
import '../../../Core/functions/show_alert.dart';
import '../../../Core/injection/app_inj.dart';
import '../../../Core/resources/sizes_resources.dart';
import '../../../Core/resources/spacing_resources.dart';
import '../../../Core/services/folders_s.dart';
import '../../../Core/widgets/toucheable_tile_widget.dart';
import '../../../Features/auth/domain/entites/teacher_data.dart';
import '../../folders/view/add_item_to_folder_v.dart';
import '../../tests/widgets/purchases_informations_w.dart';
import '../state/bank_information/bank_information_cubit.dart';

class BankDetailsView extends StatefulWidget {
  const BankDetailsView({
    super.key,
    this.bank,
    this.bankId,
  });

  final Bank? bank;
  final int? bankId;

  @override
  State<BankDetailsView> createState() => _BankDetailsViewState();
}

class _BankDetailsViewState extends State<BankDetailsView> {
  @override
  void initState() {
    context.read<BankInformationCubit>().init(
          bank: widget.bank,
          bankId: widget.bankId,
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<BankInformationCubit, BankInformationState>(
        builder: (context, state) {
          if (state is BankInformationInitial) {
            return Scaffold(
              appBar: AppBar(
                title: Text(state.bank.information.title),
              ),
              body: Column(
                children: [
                  TouchableTileWidget(
                    title: "تعديل",
                    iconData: Icons.edit,
                    onTap: () async {
                      if (locator<TeacherData>().options.allowUpdate) {
                        //
                        await Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AddBankView(
                            bank: state.bank,
                          ),
                        ));
                        //
                        if (mounted) {
                          context.read<MyBanksCubit>().init();
                          Navigator.of(context).pop();
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("غير مسموح بالعملية"),
                          ),
                        );
                      }
                    },
                  ),
                  TouchableTileWidget(
                    title: "إضافة البنك إلى مجلد",
                    iconData: Icons.folder,
                    onTap: () async {
                      if (locator<TeacherData>().options.allowUpdate) {
                        //
                        await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => AddItemToFolderView(
                              id: state.bank.id,
                              isTest: false,
                              teacherEmail: state.bank.teacherEmail,
                            ),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("غير مسموح بالعملية"),
                          ),
                        );
                      }
                    },
                  ),
                  TouchableTileWidget(
                    title: "حذف",
                    iconData: Icons.delete,
                    onTap: () {
                      if (locator<TeacherData>().options.allowDelete) {
                        showAlert(
                          context: context,
                          title: "تأكيد",
                          body: "هل انت متاكد من انك تريد حذف الاختبار",
                          onAgree: () {
                            context.read<MyBanksCubit>().deleteBank(state.bank);
                            Navigator.of(context).pop();
                          },
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("غير مسموح بالعملية"),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            );
          } else if (state is BankInformationError) {
            return Center(
              child: Text(state.message ?? ""),
            );
          }
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        },
      ),
    );
  }
}
