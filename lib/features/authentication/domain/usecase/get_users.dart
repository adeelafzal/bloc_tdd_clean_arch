import 'package:bloc_tdd_clean_arch/core/usecase/usecase.dart';
import 'package:bloc_tdd_clean_arch/core/utils/typedef.dart';
import 'package:bloc_tdd_clean_arch/features/authentication/domain/entities/user.dart';
import 'package:bloc_tdd_clean_arch/features/authentication/domain/repositories/auth_repo.dart';

class GetUsers extends UseCaseWithOutParams<List<User>> {
  final AuthenticationRepo _repo;

  GetUsers(this._repo);

  @override
  ResultFuture<List<User>> call() async => _repo.getUsers();
}
