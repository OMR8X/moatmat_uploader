import 'package:moatmat_uploader/Features/groups/domain/entities/group_item.dart';
import 'package:moatmat_uploader/Features/students/data/models/user_data_m.dart';

class GroupItemModel extends GroupItem {
  GroupItemModel({
    required super.id,
    required super.customClass,
    required super.userData,
  });

  factory GroupItemModel.fromJson(Map json) {
    return GroupItemModel(
      id: json["id"],
      customClass: json["custom_class"],
      userData: UserDataModel.fromJson(json["user_data"]),
    );
  }
  factory GroupItemModel.fromClass(GroupItem item) {
    return GroupItemModel(
      id: item.id,
      customClass: item.customClass,
      userData: item.userData,
    );
  }
  Map toJson() {
    return {
      "id": id,
      "custom_class": customClass,
      "user_data": UserDataModel.fromClass(userData).toJson(),
    };
  }
}
