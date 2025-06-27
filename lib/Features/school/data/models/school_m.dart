import 'package:moatmat_uploader/Features/school/data/models/school_information_m.dart';
import 'package:moatmat_uploader/Features/school/domain/entities/school.dart';

class SchoolModel extends School {
  SchoolModel({
    required super.id,
    required super.information,
  });
  factory SchoolModel.fromJson(Map json) {
    return SchoolModel(
      id: json["id"],
      information: SchoolInformationModel.fromJson(json["information"]),
    );
  }
  factory SchoolModel.fromClass(School school) {
    return SchoolModel(
      id: school.id,
      information: school.information,
    );
  }
  toJson({bool addId = false}) {
    return {
      if (addId) "id": id,
      "information": SchoolInformationModel.fromClass(information).toJson(),
    };
  }
}
