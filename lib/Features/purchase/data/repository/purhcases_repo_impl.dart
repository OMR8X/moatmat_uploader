import 'package:dartz/dartz.dart';
import 'package:moatmat_uploader/Features/banks/domain/entities/bank.dart';
import 'package:moatmat_uploader/Features/purchase/data/datasources/purchased_items_ds.dart';
import 'package:moatmat_uploader/Features/purchase/domain/entities/purchase_item.dart';
import 'package:moatmat_uploader/Features/purchase/domain/repository/purchases_rep.dart';
import 'package:moatmat_uploader/Features/tests/domain/entities/test/test.dart';

class PurchasesRepositoryImpl implements PurchasesRepository {
  final PurchasedItemsDS dataSource;

  PurchasesRepositoryImpl({required this.dataSource});
  @override
  Future<Either<Exception, List<PurchaseItem>>> bankPurchases({
    required Bank bank,
  }) async {
    try {
      var res = await dataSource.bankPurchases(bank: bank);
      return right(res);
    } on Exception catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<Exception, List<PurchaseItem>>> testPurchases({
    required Test test,
  }) async {
    try {
      var res = await dataSource.testPurchases(test: test);
      return right(res);
    } on Exception catch (e) {
      return left(e);
    }
  }
}
