import 'package:moatmat_uploader/Features/banks/domain/entities/bank.dart';
import 'package:moatmat_uploader/Features/purchase/data/models/purchase_item_m.dart';
import 'package:moatmat_uploader/Features/purchase/domain/entities/purchase_item.dart';
import 'package:moatmat_uploader/Features/tests/domain/entities/test/test.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class PurchasedItemsDS {
  //
  Future<List<PurchaseItem>> testPurchases({required Test test});
  //
  Future<List<PurchaseItem>> bankPurchases({required Bank bank});
}

class PurchasedItemsDSImpl implements PurchasedItemsDS {
  @override
  Future<List<PurchaseItem>> bankPurchases({required Bank bank}) async {
    //
    var client = Supabase.instance.client;
    //
    var res = await client.from("purchases").select().eq("item_type", "bank").eq("item_id", "${bank.id}").order("id");
    //
    var list = res.map((e) => PurchaseItemModel.fromJson(e)).toList();
    //
    return list;
  }

  @override
  Future<List<PurchaseItem>> testPurchases({required Test test}) async {
    //
    var client = Supabase.instance.client;
    //
    var res = await client.from("purchases").select().eq("item_type", "test").eq("item_id", "${test.id}").order("id");
    //
    var list = res.map((e) => PurchaseItemModel.fromJson(e)).toList();
    //
    return list;
  }
}
