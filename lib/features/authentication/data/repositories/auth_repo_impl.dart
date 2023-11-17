import 'package:bloc_tdd_clean_arch/core/errors/exception.dart';
import 'package:bloc_tdd_clean_arch/core/errors/failure.dart';
import 'package:bloc_tdd_clean_arch/core/utils/typedef.dart';
import 'package:bloc_tdd_clean_arch/features/authentication/data/datasource/remote/auth_data_source.dart';
import 'package:bloc_tdd_clean_arch/features/authentication/domain/entities/user.dart';
import 'package:bloc_tdd_clean_arch/features/authentication/domain/repositories/auth_repo.dart';
import 'package:dartz/dartz.dart';

class AuthRepoImpl implements AuthenticationRepo {
  final AuthDataSource _authDataSource;

  AuthRepoImpl(this._authDataSource);

  @override
  ResultVoid createUser({
    required String createdAt,
    required String name,
    required String avatar,
  }) async {
    try {
      await _authDataSource.createUser(
          createdAt: createdAt, name: name, avatar: avatar);
      return const Right(null);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<User>> getUsers() async{
    try {
      final result = await _authDataSource.getUsers();
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }
}
