import 'package:bloc_tdd_clean_arch/core/usecase/usecase.dart';
import 'package:bloc_tdd_clean_arch/core/utils/typedef.dart';
import 'package:bloc_tdd_clean_arch/features/authentication/domain/repositories/auth_repo.dart';
import 'package:equatable/equatable.dart';

class CreateUser extends UseCaseWithParams<void, CreateUserParams> {
  final AuthenticationRepo _repo;

  CreateUser(this._repo);

  @override
  ResultVoid call(params) async => _repo.createUser(
      createdAt: params.createdAt, name: params.name, avatar: params.avatar);
}

class CreateUserParams extends Equatable {
  final String createdAt, name, avatar;

  const CreateUserParams({
    required this.createdAt,
    required this.name,
    required this.avatar,
  });

  const CreateUserParams.empty() : this(createdAt: "", name: "", avatar: "");

  @override
  List<Object?> get props => [createdAt, name, avatar];
}
