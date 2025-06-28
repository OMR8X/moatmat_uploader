import 'package:get_it/get_it.dart';
import 'package:moatmat_uploader/Core/injection/banks_inj.dart';
import 'package:moatmat_uploader/Core/injection/buckets_inj.dart';
import 'package:moatmat_uploader/Core/injection/groups_inj.dart';
import 'package:moatmat_uploader/Core/injection/notifications_inj.dart';
import 'package:moatmat_uploader/Core/injection/purchases_inj.dart';
import 'package:moatmat_uploader/Core/injection/reports_inj.dart';
import 'package:moatmat_uploader/Core/injection/tests_inj.dart';
import 'package:moatmat_uploader/Core/injection/update_inj.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth_inj.dart';
import 'notifications2_inj.dart';
import 'requests_inj.dart';
import 'students_inj.dart';

var locator = GetIt.instance;
initGetIt() async {
  //
  var sp = await SharedPreferences.getInstance();
  locator.registerSingleton(sp);
  //

  injectAuth();
  //
  injectNotifications();
  //
  injectTests();
  //
  injectBanks();
  //
  injectBuckets();
  //
  injectReports();
  //
  purchasesInjector();
  //
  injectRequests();
  //
  injectStudents();
  //
  injectGroups();
  //
  injectNotifications2();
  //
  injectUpdate();
}
