import 'package:moatmat_uploader/Features/students/domain/entities/user_data.dart';

class GroupItem {
  //
  final int id;
  final String? customClass;
  final UserData userData;
  //
  GroupItem({
    required this.id,
    required this.customClass,
    required this.userData,
  });
  //
  GroupItem copyWith({
    int? id,
    String? customClass,
    UserData? userData,
  }) {
    return GroupItem(
      id: id ?? this.id,
      customClass: customClass ?? this.customClass,
      userData: userData ?? this.userData,
    );
  }
}
