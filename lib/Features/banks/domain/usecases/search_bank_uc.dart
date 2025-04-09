import 'package:dartz/dartz.dart';

import '../entities/bank.dart';
import '../repository/banks_repository.dart';

class SearchBankUC {
  final BanksRepository repository;

  SearchBankUC({required this.repository});

  Future<Either<Exception, List<Bank>>> call({
    required String keyword,
  }) async {
    return await repository.searchBank(keyword: keyword);
  }
}
