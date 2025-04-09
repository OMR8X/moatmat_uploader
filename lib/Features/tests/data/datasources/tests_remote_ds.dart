import 'package:dartz/dartz.dart';
import 'package:moatmat_uploader/Core/injection/app_inj.dart';
import 'package:moatmat_uploader/Features/auth/domain/entites/teacher_data.dart';
import 'package:moatmat_uploader/Features/buckets/domain/usecases/delete_test_files_uc.dart';
import 'package:moatmat_uploader/Features/buckets/domain/usecases/upload_file_uc.dart';
import 'package:moatmat_uploader/Features/tests/data/models/test_m.dart';
import 'package:moatmat_uploader/Features/tests/domain/entities/test/test.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/question_m.dart';

abstract class TestsRemoteDS {
  //
  Stream<String> uploadTest({
    required Test test,
  });

  //
  Stream<String> updateTest({
    required Test test,
  });
  //
  Future<Unit> deleteTest({
    required int testId,
  });
  //
  Future<Test?> getTestById({
    required int testId,
    required bool update,
  });
  Future<List<Test>> getTestsByIds({
    required List<int> ids,
    required bool update,
  });
  //
  Future<List<Test>> getMyTests({required String material});
  Future<List<Test>> searchTest({
    required String keyword,
  });
}

class TestsRemoteDSImpl implements TestsRemoteDS {
  @override
  Stream<String> uploadTest({required Test test}) async* {
    //
    bool visible = test.properties.visible ?? false;
    //
    final client = Supabase.instance.client;
    //
    final json = TestModel.fromClass(test).toJson();
    //--------------------------------------------------------------------
    // set up test id
    var res = await client.from("tests").insert(json).select();
    //
    test = test.copyWith(
      id: res[0]["id"],
      properties: test.properties.copyWith(visible: false),
    );
    //--------------------------------------------------------------------
    //

    late Map model;
    await for (var newTest in uploadTestFile(test: test)) {
      if (newTest is String) {
        yield newTest;
      }
      if (newTest is Test) {
        //
        final properties = newTest.properties.copyWith(visible: visible);
        //
        model = TestModel.fromClass(
          newTest.copyWith(properties: properties),
        ).toJson();
        //
      }
    }
    //--------------------------------------------------------------------
    // update bank
    await client.from("tests").update(model).eq("id", test.id);
    //
    yield "unit";
  }

  Stream<dynamic> uploadTestFile({required Test test}) async* { 
    //
    int length = test.questions.length;
    int filesLength = test.information.files?.length ?? 0;
    //
    var newTest = test;
    //

    // upload test videos
    for (int i = 0; i < (newTest.information.video ?? []).length; i++) {
      //
      yield "رفع ملف المقطع رقم (${i + 1}/$filesLength)";
      //
      var res = await locator<UploadFileUC>().call(
        bucket: "tests",
        material: newTest.information.material,
        id: newTest.id.toString(),
        path: newTest.information.video![i],
      );
      res.fold(
        (l) {},
        (r) {
          //
          List<String> newVideos = newTest.information.video ?? [];
          //
          int index = newVideos.indexOf(newTest.information.video![i]);
          //
          newVideos[index] = r;
          //
          // replace links
          newTest = newTest.copyWith(
            information: newTest.information.copyWith(
              video: newVideos,
            ),
          );
        },
      );
      //
    }
    // upload test images
    for (int i = 0; i < (newTest.information.images ?? []).length; i++) {
      //
      yield "رفع ملف الصورة رقم (${i + 1}/$filesLength)";
      //
      var res = await locator<UploadFileUC>().call(
        bucket: "tests",
        material: newTest.information.material,
        id: newTest.id.toString(),
        path: newTest.information.images![i],
      );
      res.fold(
        (l) {},
        (r) {
          //
          List<String> newImages = newTest.information.images ?? [];
          //
          int index = newImages.indexOf(newTest.information.images![i]);
          //
          newImages[index] = r;
          //
          // replace links
          newTest = newTest.copyWith(
            information: newTest.information.copyWith(
              images: newImages,
            ),
          );
        },
      );
      //
    }
    //
    // upload test files
    for (int i = 0; i < filesLength; i++) {
      //
      yield "رفع ملف pdf رقم (${i + 1}/$filesLength)";
      //
      // files
      bool con = newTest.information.files?[i] != null;
      if (con) {
        var res = await locator<UploadFileUC>().call(
          id: newTest.id.toString(),
          bucket: "tests",
          material: newTest.information.material,
          path: newTest.information.files![i],
        );
        res.fold(
          (l) {},
          (r) {
            //
            List<String> newFiles = newTest.information.files ?? [];
            //
            int index = newFiles.indexOf(newTest.information.files![i]);
            //
            newFiles[index] = r;
            //
            // replace links
            newTest = newTest.copyWith(
              information: newTest.information.copyWith(
                files: newFiles,
              ),
            );
          },
        );
      }
      //
    }

    // questions files
    for (int i = 0; i < newTest.questions.length; i++) {
      //
      yield "رفع ملفات السؤال رقم (${i + 1}/$length)";
      //
      var q = newTest.questions[i];

      // video
      if (q.video != null) {
        var res = await locator<UploadFileUC>().call(
          bucket: "tests",
          material: newTest.information.material,
          id: newTest.id.toString(),
          path: q.video!,
        );
        res.fold(
          (l) => null,
          (r) {
            q = q.copyWith(video: r);
          },
        );
      }
      // Explain image
      if (q.explainImage != null) {
        var res = await locator<UploadFileUC>().call(
          bucket: "tests",
          material: newTest.information.material,
          id: newTest.id.toString(),
          path: q.explainImage!,
        );
        res.fold(
          (l) => null,
          (r) {
            q = q.copyWith(explainImage: r);
          },
        );
      }
      // image
      if (q.image != null) {
        var res = await locator<UploadFileUC>().call(
          bucket: "tests",
          material: newTest.information.material,
          id: newTest.id.toString(),
          path: q.image!,
        );
        res.fold(
          (l) => null,
          (r) {
            q = q.copyWith(image: r);
          },
        );
      }

      // answers
      for (int j = 0; j < q.answers.length; j++) {
        //
        var a = q.answers[j];
        //
        // image
        if (a.image != null) {
          var res = await locator<UploadFileUC>().call(
            bucket: "tests",
            material: newTest.information.material,
            id: newTest.id.toString(),
            path: a.image!,
          );
          res.fold(
            (l) => null,
            (r) {
              a = a.copyWith(image: r);
            },
          );
        }
        q.answers[j] = a;
      }
      newTest.questions[i] = QuestionModel.fromClass(q);
    }

    yield newTest;
  }

  @override
  Future<List<Test>> getMyTests({required String material}) async {
    //
    final client = Supabase.instance.client;
    //
    List<Test> tests = [];
    //
    final res = await client.from("tests").select().eq("information->>material", material);
    //
    tests = res.map((e) => TestModel.fromJson(e)).toList();
    //
    return tests;
  }

  @override
  Future<Test?> getTestById({required int testId, required bool update}) async {
    //
    final client = Supabase.instance.client;
    //
    final res = await client.from("tests").select().eq("id", testId);
    //
    if (res.isNotEmpty) {
      final test = TestModel.fromJson(res.first);
      return test;
    }
    //
    throw Exception("لم يتم العثور على بيانات الاختبار");
  }

  @override
  Future<Unit> deleteTest({required int testId}) async {
    //
    final client = Supabase.instance.client;
    //
    var res = await client.from("tests").delete().eq("id", testId);
    //
    return unit;
  }

  @override
  Stream<String> updateTest({
    required Test test,
  }) async* {
    //
    //
    final client = Supabase.instance.client;
    //
    yield "جلب بيانات البنك القديم";
    //
    var oldTest = await getTestById(testId: test.id, update: true);
    //
    if (oldTest != null) {
      //
      yield "حذف ملفات الاختبار القديم";
      // delete old test files
      locator<DeleteTestFilesUC>().call(oldTest: oldTest, newTest: test);
    }
    //
    late Map model;
    //
    await for (var newTest in uploadTestFile(test: test)) {
      if (newTest is String) {
        yield newTest;
      }
      if (newTest is Test) {
        model = TestModel.fromClass(newTest).toJson();
      }
    }
    //
    await client.from("tests").update(model).eq("id", test.id);
    //
    yield "تم الرفع";
  }

  @override
  Future<List<Test>> getTestsByIds({
    required List<int> ids,
    required bool update,
  }) async {
    //
    final client = Supabase.instance.client;
    //
    final res = await client.from("tests").select().inFilter("id", ids);
    //
    if (res.isNotEmpty) {
      final test = res.map((e) => TestModel.fromJson(e)).toList();
      return test;
    }
    //
    return [];
  }

  @override
  Future<List<Test>> searchTest({required String keyword}) async {
    //
    final client = Supabase.instance.client;
    //
    final res = await client.from("tests").select().like("information->>title", "%$keyword%");
    //
    if (res.isNotEmpty) {
      //
      final tests = res.map((e) => TestModel.fromJson(e)).toList();
      //
      return tests;
    }
    //
    return [];
  }
}
