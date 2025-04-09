import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moatmat_uploader/Presentation/banks/state/my_banks/my_banks_cubit.dart';
import 'package:moatmat_uploader/Presentation/banks/views/bank_details_v.dart';
import 'package:moatmat_uploader/Presentation/banks/widgets/bank_tile_w.dart';
import '../../../Core/resources/sizes_resources.dart';
import '../../../Core/widgets/appbar/contact_us_w.dart';
import '../../../Core/widgets/appbar/report_icon_w.dart';

class MyBanksView extends StatefulWidget {
  const MyBanksView({super.key, required this.material});
  final String material;
  @override
  State<MyBanksView> createState() => _MyBanksViewState();
}

class _MyBanksViewState extends State<MyBanksView> {
  @override
  void initState() {
    context.read<MyBanksCubit>().init(material: widget.material);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("تصفح البنوك"),
        actions: const [
          ContactUsWidget(),
        ],
      ),
      body: BlocBuilder<MyBanksCubit, MyBanksState>(
        builder: (context, state) {
          if (state is MyBanksInitial) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<MyBanksCubit>().update();
              },
              child: ListView.builder(
             padding: const EdgeInsets.only(bottom: 100),
                itemCount: state.banks.length,
                itemBuilder: (context, index) => BankTileWidget(
                  bank: state.banks[index],
                  onPick: () async {
                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => BankDetailsView(
                          bank: state.banks[index],
                        ),
                      ),
                    );

                    if (mounted) {
                      context.read<MyBanksCubit>().update();
                    }
                  },
                ),
              ),
            );
          } else if (state is MyBanksError) {
            return const Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                  child: Text(
                "data",
                textAlign: TextAlign.center,
              )),
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
