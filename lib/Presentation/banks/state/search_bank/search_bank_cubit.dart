import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';


import '../../../../Core/injection/app_inj.dart';
import '../../../../Features/banks/domain/entities/bank.dart';
import '../../../../Features/banks/domain/usecases/search_bank_uc.dart';

part 'search_bank_state.dart';

class SearchBankCubit extends Cubit<SearchBankState> {
  SearchBankCubit() : super(SearchBankLoading());

  search(String keyword) async {
    //
    emit(SearchBankLoading());
    //
    var res = await locator<SearchBankUC>().call(keyword: keyword);
    //
    res.fold(
      (l) {
        emit(SearchBankError(error: l.toString()));
      },
      (r) {
        emit(SearchBankInitial(banks: r));
      },
    );
  }
}
