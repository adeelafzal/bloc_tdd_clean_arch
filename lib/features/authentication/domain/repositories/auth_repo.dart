import 'package:bloc_tdd_clean_arch/core/utils/typedef.dart';
import 'package:bloc_tdd_clean_arch/features/authentication/domain/entities/user.dart';

abstract class AuthenticationRepo {
  const AuthenticationRepo();

  ResultVoid createUser({
    required String createdAt,
    required String name,
    required String avatar,
  });

  ResultFuture<List<User>> getUsers();
}
