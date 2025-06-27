import '../../domain/entities/test/test_information.dart';
import 'mini_test_m.dart';

class TestInformationModel extends TestInformation {
  TestInformationModel({
    required super.title,
    required super.classs,
    required super.material,
    required super.teacher,
    required super.schoolId,
    required super.price,
    required super.password,
    required super.period,
    required super.video,
    required super.images,
    required super.files,
    required super.previous,
  });

  factory TestInformationModel.fromJson(Map json) {
    return TestInformationModel(
      title: json["title"],
      classs: json["classs"],
      material: json["material"],
      teacher: json["teacher"],
      schoolId: json["school_id"],
      price: json["price"],
      password: json["password"],
      period: json["period"],
      images: (json["images"] ?? []).cast<String>(),
      video: stringToList(json["video"]),
      files: List.generate(
        (json["files"] as List? ?? []).length,
        (i) => json["files"][i],
      ),
      previous: json["previous"] != null ? MiniTestModel.fromJson(json["previous"]) : null,
    );
  }

  static List<String> stringToList(String? value) {
    try {
      if (value == null || value == '') {
        return [];
      } else {
        return value.split(',');
      }
    } on Exception {
      return [];
    }
  }

  factory TestInformationModel.fromClass(TestInformation information) {
    return TestInformationModel(
      title: information.title,
      classs: information.classs,
      material: information.material,
      teacher: information.teacher,
      schoolId: information.schoolId,
      price: information.price,
      password: information.password,
      period: information.period,
      images: information.images,
      video: information.video,
      files: information.files,
      previous: information.previous,
    );
  }

  toJson() {
    return {
      "title": title,
      "classs": classs,
      "material": material,
      "teacher": teacher,
      "school_id": schoolId,
      "price": price,
      "password": password,
      "video": (video?.isNotEmpty ?? false) ? video!.join(",") : null,
      "images": images,
      "period": period,
      "files": files ?? <String>[],
      "previous": previous == null ? previous : MiniTestModel.fromClass(previous!).toJson()
    };
  }
}
