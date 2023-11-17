import 'dart:convert';

import 'package:bloc_tdd_clean_arch/core/errors/exception.dart';
import 'package:bloc_tdd_clean_arch/core/utils/constants.dart';
import 'package:bloc_tdd_clean_arch/features/authentication/data/datasource/remote/auth_data_source.dart';
import 'package:bloc_tdd_clean_arch/features/authentication/data/model/user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockClient extends Mock implements http.Client {}

main() {
  late http.Client client;
  late AuthDataSource authDataSource;

  setUp(() {
    client = MockClient();
    authDataSource = AuthDataSourceImpl(client);
    registerFallbackValue(Uri());
  });

  group("createUser", () {
    test("should complete success when the status 200 or 201", () async {
      when(() => client.post(any(), body: any(named: "body"))).thenAnswer(
          (_) async => http.Response("User created successfully", 201));
      final methodCall = authDataSource.createUser;
      expect(methodCall(createdAt: "", name: "", avatar: ""), completes);
      verify(() => client.post(Uri.parse("$kBaseUrl$kUsers"),
          body: jsonEncode({
            "createdAt": "",
            "name": "",
            "avatar": "",
          }))).called(1);
      verifyNoMoreInteractions(client);
    });

    test("call APIException", () async {
      when(() => client.post(any(), body: any(named: "body")))
          .thenAnswer((_) async => http.Response("Invalid email address", 400));

      final methodCall = authDataSource.createUser;

      expect(
          () async => methodCall(createdAt: "", name: "", avatar: ""),
          throwsA(
              const ApiException(message: "Invalid email", statusCode: 400)));

      verify(() => client.post(Uri.parse("$kBaseUrl$kUsers"),
          body: jsonEncode({
            "createdAt": "",
            "name": "",
            "avatar": "",
          }))).called(1);
      verifyNoMoreInteractions(client);
    });
  });

  group("getUsers", () {
    final tUser = [const UserModel.empty()];
    test("should return users list", () async {
      when(() => client.get(any())).thenAnswer(
          (_) async => http.Response(jsonEncode([tUser.first.toMap()]), 200));
      final result = await authDataSource.getUsers();
      expect(result, equals(tUser));
      verify(() => client.get(Uri.parse("$kBaseUrl$kUsers"))).called(1);
      verifyNoMoreInteractions(client);
    });

    test("call APIException", () async {
      when(() => client.get(any()))
          .thenAnswer((_) async => http.Response("Server down", 500));

      final methodCall = authDataSource.getUsers;

      expect(
          () => methodCall(),
          throwsA(
              const ApiException(message: "Server down", statusCode: 500)));

      verify(() => client.get(Uri.parse("$kBaseUrl$kUsers"))).called(1);
      verifyNoMoreInteractions(client);
    });
  });
}
