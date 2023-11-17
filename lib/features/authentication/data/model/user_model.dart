import 'dart:convert';
import 'package:bloc_tdd_clean_arch/core/utils/typedef.dart';
import 'package:bloc_tdd_clean_arch/features/authentication/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.createdAt,
    required super.name,
    required super.avatar,
  });

  const UserModel.empty() : this(id: "1", createdAt: "", name: "", avatar: "");

  UserModel copyWith({
    String? id,
    String? createdAt,
    String? name,
    String? avatar,
  }) {
    return UserModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.id,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
    );
  }

  UserModel.fromMap(DataMap json)
      : this(
          id: json["id"],
          createdAt: json["createdAt"],
          name: json["name"],
          avatar: json["avatar"],
        );

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(jsonDecode(source) as DataMap);

  DataMap toMap() => {
        "id": id,
        "createdAt": createdAt,
        "name": name,
        "avatar": avatar,
      };

  String toJson() => jsonEncode(toMap());
}
