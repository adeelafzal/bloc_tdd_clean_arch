import 'package:bloc_tdd_clean_arch/features/authentication/domain/repositories/auth_repo.dart';
import 'package:bloc_tdd_clean_arch/features/authentication/domain/usecase/create_user.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'auth_repo.mock.dart';

main() {
  late CreateUser useCase;
  late AuthenticationRepo repo;
  const params = CreateUserParams.empty();

  setUpAll(() {
    repo = MockAuthRepo();
    useCase = CreateUser(repo);
    //For Custom Object or model class
    // registerFallbackValue(const User(id: 1, createdAt: "createdAt", name: "name", avatar: "avatar"));
  });

  test("Create user", () async {
    //Arrange
    when(
      () => repo.createUser(
        createdAt: any(named: "createdAt"),
        name: any(named: "name"),
        avatar: any(named: "avatar"),
      ),
    ).thenAnswer((_) async => const Right(null));
    //Act
    final result = await useCase(params);
    //Assert
    expect(result, equals(const Right(null)));
    verify(() => repo.createUser(
        createdAt: params.createdAt,
        name: params.name,
        avatar: params.avatar)).called(1);
    verifyNoMoreInteractions(repo);
  });
}
