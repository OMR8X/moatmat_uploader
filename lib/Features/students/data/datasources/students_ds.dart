import 'package:dartz/dartz.dart';
import 'package:moatmat_uploader/Core/injection/app_inj.dart';
import 'package:moatmat_uploader/Features/auth/domain/entites/teacher_data.dart';
import 'package:moatmat_uploader/Features/students/data/models/result_m.dart';
import 'package:moatmat_uploader/Features/students/data/models/user_data_m.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../banks/domain/entities/bank.dart';
import '../../../tests/domain/entities/test/test.dart';
import '../../domain/entities/result.dart';
import '../../domain/entities/user_data.dart';

abstract class StudentsDS {
  //
  // get my students
  Future<List<UserData>> getMyStudents({
    required bool update,
  });
  // get my students
  Future<List<UserData>> getRepositoryStudents({
    required Test? test,
    required Bank? bank,
    required bool update,
  });
  //
  // search in my students
  Future<List<UserData>> searchInMyStudents({
    required String text,
    required bool update,
  });
  //
  // get student results
  Future<List<Result>> getStudentResults({
    required String id,
    required bool update,
  });
  //
  // get test results
  Future<List<Result>> getRepositoryResults({
    required Test? test,
    required Bank? bank,
    required bool update,
  });
  // delete test results
  Future<Unit> deleteRepositoryResults({
    required List<int>? results,
    int? testId,
    int? bankId,
  });
  //
  Future<double> getRepositoryAverage({
    required String? testId,
    required String? bankId,
    required bool update,
  });
  //
}

class StudentsDSimpl implements StudentsDS {
  const StudentsDSimpl();

  @override
  Future<List<UserData>> getRepositoryStudents({
    required Test? test,
    required Bank? bank,
    required bool update,
  }) async {
    //
    final client = Supabase.instance.client;
    // get result using tests ids
    final List<Map> myResultsData;
    //
    if (test != null) {
      myResultsData = await client
          .from("results")
          .select()
          .eq("test_id", test.id)
          .order("id");
    } else {
      myResultsData = await client
          .from("results")
          .select()
          .eq("bank_id", bank!.id)
          .order("id");
    }
    //
    //
    // getting users ids
    final List<Map> myUsers;
    //
    myUsers = await client
        .from("users_data")
        .select()
        .inFilter("uuid", myResultsData.map((e) => e["user_id"]).toList());
    //
    return myUsers.map((e) => UserDataModel.fromJson(e)).toList();
  }

  @override
  Future<List<UserData>> getMyStudents({required bool update}) async {
    //
    // final client = client;
    final client = Supabase.instance.client;
    //
    final teacherData = locator<TeacherData>();
    //
    // get my tests ids
    final List<Map> myTestsIds;
    //
    final List<Map> myBanksIds;
    //
    myTestsIds = await client
        .from("tests")
        .select("id")
        .eq("teacher_email", teacherData.email)
        .order("id");
    //
    myBanksIds = await client
        .from("banks")
        .select("id")
        .eq("teacher_email", teacherData.email)
        .order("id");
    //
    // get result using tests ids
    final List<Map> myResults;
    //
    myResults = await client.from("results").select("user_id").inFilter(
          "test_id",
          myTestsIds.map((e) => e["id"]).toList() +
              myBanksIds.map((e) => e["id"]).toList(),
        );
    //
    // getting users ids
    final List<Map> myUsers;
    //
    myUsers = await client
        .from("users_data")
        .select()
        .inFilter("uuid", myResults.map((e) => e["user_id"]).toList());
    //
    List<UserData> users = myUsers.map((e) {
      return UserDataModel.fromJson(e);
    }).toList();
    //
    return users;
  }

  @override
  Future<List<Result>> getStudentResults({
    required String id,
    required bool update,
  }) async {
    //
    final client = Supabase.instance.client;
    //
    final List<Map> res;
    //
    res = await client.from("results").select().eq("user_id", id).order("id");
    //
    if (res.isNotEmpty) {
      //
      List<Result> results = res.map((e) => ResultModel.fromJson(e)).toList();
      //
      results = results.where((e) => e.userId == id).toList();
      //
      return res.map((e) => ResultModel.fromJson(e)).toList();
    }
    //
    return [];
  }

  @override
  Future<List<Result>> getRepositoryResults({
    required Test? test,
    required Bank? bank,
    required bool update,
  }) async {
    //
    final client = Supabase.instance.client;
    //
    final List<Map> res;
    //
    if (test != null) {
      res = await client
          .from("results")
          .select()
          .eq("test_id", test.id)
          .order("id");
    } else {
      res = await client
          .from("results")
          .select()
          .eq("bank_id", bank!.id)
          .order("id");
    }
    //
    if (res.isNotEmpty) {
      var list = res.map((e) => ResultModel.fromJson(e)).toList();
      //
      return list;
    }
    //
    return [];
  }

  @override
  Future<List<UserData>> searchInMyStudents({
    required String text,
    required bool update,
  }) async {
    //
    // final client = client;
    final client = Supabase.instance.client;
    //
    final teacherData = locator<TeacherData>();
    //
    // get my tests ids
    final List<Map> myTestsIds;
    //
    myTestsIds = await client
        .from("tests")
        .select()
        .eq("teacher_email", teacherData.email);
    //
    // get result using tests ids
    final List<Map> myResults;
    //
    myResults = await client
        .from("results")
        .select()
        .inFilter("test_id", myTestsIds.map((e) => e["id"]).toList());
    //
    // getting users ids
    final List<Map> myUsers;
    //
    myUsers = await client
        .from("users_data")
        .select()
        .or("email.contains.$text")
        .inFilter("uuid", myResults.map((e) => e["user_id"]).toList())
        .order("name");
    //
    return myUsers.map((e) => UserDataModel.fromJson(e)).toList();
  }

  @override
  Future<double> getRepositoryAverage({
    required String? testId,
    required String? bankId,
    required bool update,
  }) async {
    final client = Supabase.instance.client;
    //
    final List<Map> res;
    //
    res = await client
        .from("results")
        .select("mark")
        .gte("mark", 0.3)
        .eq("test_id", id);
    //
    if (res.isNotEmpty) {
      try {
        double sum = res.fold(0.0, (acc, map) => acc + (map['mark']));
        double average = sum / res.length;
        return average;
      } on Exception {
        return 0.0;
      }
    }
    //
    return 0.0;
  }

  @override
  Future<Unit> deleteRepositoryResults({
    required List<int>? results,
    int? testId,
    int? bankId,
  }) async {
    //
    final client = Supabase.instance.client;
    //
    if (results != null) {
      await client.from("results").delete().inFilter("id", results);
    }
    //
    if (testId != null) {
      await client.from("results").delete().eq("test_id", testId);
    }
    //
    return unit;
  }
}
