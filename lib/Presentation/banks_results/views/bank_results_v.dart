import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Core/functions/math/mark_to_latter_f.dart';
import '../../../Core/widgets/toucheable_tile_widget.dart';
import '../../../Core/widgets/view/search_in_results_v.dart';
import '../../../Features/banks/domain/entities/bank.dart';
import '../../students/views/student_v.dart';
import '../state/cubit/bank_results_cubit.dart';
import 'answers_percentage_v.dart';

class BankResultsView extends StatefulWidget {
  const BankResultsView({super.key, required this.bank});
  final Bank bank;
  @override
  State<BankResultsView> createState() => _BankResultsViewState();
}

class _BankResultsViewState extends State<BankResultsView> {
  @override
  void initState() {
    context.read<BankResultsCubit>().init(widget.bank);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<BankResultsCubit, BankResultsState>(
        builder: (context, state) {
          if (state is BankResultsInitial) {
            return Scaffold(
              appBar: AppBar(
                title: Text("نتائج ${widget.bank.information.title}"),
                actions: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => SearchInResultsView(
                            results: state.details.marks.map((e) {
                              return e.$1;
                            }).toList(),
                            onPick: (r) {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => StudentView(
                                    userId: r.userId,
                                    result: r,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.search),
                  )
                ],
              ),
              body: RefreshIndicator(
                onRefresh: () async {
                  context.read<BankResultsCubit>().update();
                  return;
                },
                child: ListView.builder(
                  itemCount: state.details.marks.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        if (index == 0)
                          TouchableTileWidget(
                            title: "عرض نسب الاختيارات",
                            subTitle: "نسب اختيارات الطلاب للاجوبة",
                            iconData: Icons.arrow_forward_ios,
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => AnswersPercentage(
                                    details: state.details,
                                    bank: widget.bank,
                                  ),
                                ),
                              );
                            },
                          ),
                        TouchableTileWidget(
                          //
                          title: "%${state.details.marks[index].$2 * 100}",
                          //
                          subTitle: markToLatterFunction(
                              state.details.marks[index].$2),
                          //
                          subTitle2: state.details.marks[index].$1.userName,
                          //
                          icon: Text(("%${state.details.average * 100}")),
                          //
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => StudentView(
                                  userId: state.details.marks[index].$1.userId,
                                  result: state.details.marks[index].$1,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
            );
          }
          return Scaffold(
            appBar: AppBar(),
            body: const Center(
              child: CupertinoActivityIndicator(),
            ),
          );
        },
      ),
    );
  }
}
