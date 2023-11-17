import 'package:bloc_tdd_clean_arch/core/errors/exception.dart';
import 'package:bloc_tdd_clean_arch/core/errors/failure.dart';
import 'package:bloc_tdd_clean_arch/features/authentication/data/datasource/remote/auth_data_source.dart';
import 'package:bloc_tdd_clean_arch/features/authentication/data/repositories/auth_repo_impl.dart';
import 'package:bloc_tdd_clean_arch/features/authentication/domain/entities/user.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthDataSource extends Mock implements AuthDataSource {}

main() {
  late AuthDataSource authDataSource;
  late AuthRepoImpl authRepoImpl;
  const tException =
      ApiException(message: "Unknown Error Occurred", statusCode: 500);
  setUp(() {
    authDataSource = MockAuthDataSource();
    authRepoImpl = AuthRepoImpl(authDataSource);
  });

  group("create new user", () {
    test("Call [AuthDataSource.createUser]", () async {
      when(
        () => authDataSource.createUser(
          createdAt: any(named: "createdAt"),
          name: any(named: "name"),
          avatar: any(named: "avatar"),
        ),
      ).thenAnswer((_) async => Future.value());

      final result = await authRepoImpl.createUser(
          createdAt: "createdAt", name: "name", avatar: "avatar");
      //Assert
      expect(result, equals(const Right(null)));
      verify(() => authDataSource.createUser(
          createdAt: "createdAt", name: "name", avatar: "avatar")).called(1);
      verifyNoMoreInteractions(authDataSource);
    });

    test("call ServerFailure", () async {
      when(() => authDataSource.createUser(
            createdAt: any(named: "createdAt"),
            name: any(named: "name"),
            avatar: any(named: "avatar"),
          )).thenThrow(tException);

      final result = await authRepoImpl.createUser(
          createdAt: "createdAt", name: "name", avatar: "avatar");

      expect(
          result,
          equals(Left(ApiFailure(
            message: tException.message,
            statusCode: tException.statusCode,
          ))));

      verify(() => authDataSource.createUser(
          createdAt: "createdAt", name: "name", avatar: "avatar")).called(1);
      verifyNoMoreInteractions(authDataSource);
    });
  });

  group("get users", () {
    test("Call [AuthDataSource.getUsers]", () async {
      when(
        () => authDataSource.getUsers(),
      ).thenAnswer((_) async => []);

      final result = await authRepoImpl.getUsers();
      //Assert
      expect(result, isA<Right<dynamic, List<User>>>());
      verify(() => authDataSource.getUsers()).called(1);
      verifyNoMoreInteractions(authDataSource);
    });

    test("call ServerFailure", () async {
      when(() => authDataSource.getUsers()).thenThrow(tException);

      final result = await authRepoImpl.getUsers();

      expect(
          result,
          equals(Left(ApiFailure(
            message: tException.message,
            statusCode: tException.statusCode,
          ))));

      verify(() => authDataSource.getUsers()).called(1);
      verifyNoMoreInteractions(authDataSource);
    });
  });
}
