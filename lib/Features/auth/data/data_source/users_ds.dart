import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:moatmat_uploader/Features/students/data/models/user_data_m.dart';
import 'package:moatmat_uploader/Features/students/domain/entities/user_data.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../Core/errors/exceptions.dart';
import '../../domain/entites/teacher_data.dart';
import '../models/teacher_data_m.dart';

abstract class TeachersDataSource {
  // signIn
  Future<TeacherData> signIn({
    required String email,
    required String password,
  });
  // signUp
  Future<TeacherData> signUp({
    required TeacherData teacherData,
    required String password,
  });
  //
  // update User Data
  Future<Unit> updateTeacherData({
    required TeacherData teacherData,
  });
  //
  // get teacher Data
  Future<TeacherData> getTeacherData({String? email});
  // get User Data
  Future<UserData> getUserDataData({required String id});
  //
  Future<Unit> resetPassword({
    required String email,
    required String password,
    required String token,
  });
  //
  Future<List<TeacherData>> getALlTeachers();
}

class TeachersDataSourceImpl implements TeachersDataSource {
  final SupabaseClient client;

  TeachersDataSourceImpl({required this.client});
  @override
  Future<TeacherData> getTeacherData({String? email}) async {
    //
    var query = client.from("teachers_data").select().eq("email", email ?? client.auth.currentUser!.email!.toLowerCase());
    //
    List res = await query;
    if (res.isNotEmpty) {
      final teacherData = TeacherDataModel.fromJson(res.first);
      return teacherData;
    } else {
      throw Exception();
    }
  }

  @override
  Future<TeacherData> signIn({
    required String email,
    required String password,
  }) async {
    email = email.toLowerCase().trim();
    await client.auth.signInWithPassword(
      email: email,
      password: password,
    );
    String? uuid = client.auth.currentUser?.id;
    if (uuid != null) {
      return await getTeacherData();
    } else {
      throw AnonException();
    }
  }

  @override
  Future<TeacherData> signUp({
    required TeacherData teacherData,
    required String password,
  }) async {
    //
    teacherData = teacherData.copyWith(email: teacherData.email.toLowerCase().trim());
    //
    await client.auth.signUp(
      email: teacherData.email,
      password: password,
    );
    //
    String? uuid = client.auth.currentUser?.id;
    if (uuid != null) {
      await updateTeacherData(teacherData: teacherData);
      return teacherData;
    } else {
      throw AnonException();
    }
  }

  @override
  Future<Unit> updateTeacherData({
    required TeacherData teacherData,
  }) async {
    //
    Map json = TeacherDataModel.fromClass(teacherData).toJson();
    //

    var query1 = await client.from("teachers_data").select().eq("email", teacherData.email);
    //
    if (query1.isEmpty) {
      //
      await client.from("teachers_data").insert(json);
      //
      return unit;
      //
    } else {
      //
      await client.from("teachers_data").update(json).eq("email", teacherData.email);
      //
      return unit;
    }
  }

  @override
  Future<Unit> resetPassword({
    required String email,
    required String password,
    required String token,
  }) async {
    var client = Supabase.instance.client;
    await client.auth.verifyOTP(
      email: email,
      token: token,
      type: OtpType.recovery,
    );
    await client.auth.updateUser(
      UserAttributes(password: password),
    );
    return unit;
  }

  @override
  Future<UserData> getUserDataData({required String id}) async {
    //
    var query = client.from("users_data").select().eq("uuid", id);
    //
    List res = await query;
    if (res.isNotEmpty) {
      final userData = UserDataModel.fromJson(res.first);
      return userData;
    } else {
      throw Exception();
    }
  }

  @override
  Future<List<TeacherData>> getALlTeachers() async {
    //
    final client = Supabase.instance.client;
    //
    var res = await client.from("teachers_data").select();
    //
    if (res.isEmpty) return [];
    //
    List<TeacherData> teachers = [];
    //
    teachers = res.map((e) => TeacherDataModel.fromJson(e)).toList();
    //
    return teachers;
  }
}
