import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../state/search_test/search_test_cubit.dart';
import '../widgets/test_tile_w.dart';
import 'test_details_v.dart';

class TestsSearchResultView extends StatefulWidget {
  const TestsSearchResultView({super.key, required this.keyword});
  final String keyword;

  @override
  State<TestsSearchResultView> createState() => _TestsSearchResultViewState();
}

class _TestsSearchResultViewState extends State<TestsSearchResultView> {
  @override
  void initState() {
    context.read<SearchTestCubit>().search(widget.keyword);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<SearchTestCubit, SearchTestState>(
        builder: (context, state) {
          if (state is SearchTestInitial) {
            return ListView.builder(
              itemCount: state.tests.length,
              itemBuilder: (context, index) {
                return TestTileWidget(
                  test: state.tests[index],
                  onPick: () async {
                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => TestDetailsView(
                          testId: state.tests[index].id,
                        ),
                      ),
                    );
                    if (mounted) {
                      context.read<SearchTestCubit>().refresh();
                    }
                  },
                );
              },
            );
          } else if (state is SearchTestError) {
            return Center(
              child: Text(state.error),
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
