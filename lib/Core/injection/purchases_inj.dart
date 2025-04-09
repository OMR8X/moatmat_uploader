import 'package:moatmat_uploader/Features/purchase/data/datasources/purchased_items_ds.dart';
import 'package:moatmat_uploader/Features/purchase/data/repository/purhcases_repo_impl.dart';
import 'package:moatmat_uploader/Features/purchase/domain/usecases/bank_purchases_uc.dart';

import '../../Features/purchase/domain/repository/purchases_rep.dart';
import '../../Features/purchase/domain/usecases/test_purchases_uc.dart';
import 'app_inj.dart';

purchasesInjector() {
  injectDS();
  injectRepo();
  injectUC();
}

void injectUC() {
  locator.registerFactory<TestPurchasesUC>(
    () => TestPurchasesUC(
      repository: locator(),
    ),
  );
  locator.registerFactory<BankPurchasesUC>(
    () => BankPurchasesUC(
      repository: locator(),
    ),
  );
}

void injectRepo() {
  locator.registerFactory<PurchasesRepository>(
    () => PurchasesRepositoryImpl(
      dataSource: locator(),
    ),
  );
}

void injectDS() {
  locator.registerFactory<PurchasedItemsDS>(
    () => PurchasedItemsDSImpl(),
  );
}
