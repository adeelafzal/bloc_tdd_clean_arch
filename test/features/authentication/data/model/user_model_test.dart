import 'dart:convert';
import 'dart:io';

import 'package:bloc_tdd_clean_arch/core/utils/typedef.dart';
import 'package:bloc_tdd_clean_arch/features/authentication/data/model/user_model.dart';
import 'package:bloc_tdd_clean_arch/features/authentication/domain/entities/user.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

main() {
  const tModel = UserModel.empty();
  final tJson = fixture("user.json");
  final tMap = jsonDecode(tJson) as DataMap;

  test("should be subclass of [User]", () {
    expect(tModel, isA<User>());
  });

  group("fromMap", () {
    test("should return a [UserModel] data", () {
      final result = UserModel.fromMap(tMap);
      expect(result, equals(tModel));
    });
  });

  group("fromJson", () {
    test("should return a [UserModel] data", () {
      final result = UserModel.fromJson(tJson);
      expect(result, equals(tModel));
    });
  });

  group("toMap", () {
    test("should return a [Map] data", () {
      final result = tModel.toMap();
      expect(result, equals(tMap));
    });
  });

  group("toJson", () {
    test("should return a [Json] data", () {
      final result = tModel.toJson();
      final tJson =
          jsonEncode({"id": "1", "createdAt": "", "name": "", "avatar": ""});
      expect(result, tJson);
    });
  });

  group("copyWith", () {
    test("should return a [UserModel] with different data", () {
      final result = tModel.copyWith(name: "Adeel");
      expect(result.name, equals("Adeel"));
    });
  });
}
