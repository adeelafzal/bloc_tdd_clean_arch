import 'package:bloc_tdd_clean_arch/features/authentication/domain/entities/user.dart';
import 'package:bloc_tdd_clean_arch/features/authentication/domain/repositories/auth_repo.dart';
import 'package:bloc_tdd_clean_arch/features/authentication/domain/usecase/get_users.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'auth_repo.mock.dart';

main() {
  late GetUsers useCase;
  late AuthenticationRepo repo;
  const tResponse = [User.empty()];

  setUp(() {
    repo = MockAuthRepo();
    useCase = GetUsers(repo);
  });

  test("List of users", () async {
    //Arrange
    when(
      () => repo.getUsers(),
    ).thenAnswer((_) async => const Right(tResponse));
    //Act
    final result = await useCase();
    //Assert
    expect(result, equals(const Right(tResponse)));
    verify(() => repo.getUsers()).called(1);
    verifyNoMoreInteractions(repo);
  });
}
