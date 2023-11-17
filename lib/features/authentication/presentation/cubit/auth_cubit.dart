import 'package:bloc_tdd_clean_arch/features/authentication/domain/usecase/create_user.dart';
import 'package:bloc_tdd_clean_arch/features/authentication/domain/usecase/get_users.dart';
import 'package:bloc_tdd_clean_arch/features/authentication/presentation/cubit/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  final CreateUser _createUser;
  final GetUsers _getUsers;

  AuthCubit({
    required CreateUser createUser,
    required GetUsers getUsers,
  })  : _createUser = createUser,
        _getUsers = getUsers,
        super(AuthInitialState());

  Future<void> createUsersEvent({
    required String createdAt,
    required String name,
    required String avatar,
  }) async {
    emit(CreatingUserState());
    final result = await _createUser(CreateUserParams(
      createdAt: createdAt,
      name: name,
      avatar: avatar,
    ));
    result.fold(
      (failure) => emit(AuthErrorState(failure.errorMessage)),
      (_) => emit(UserCreatedState()),
    );
  }

  Future<void> getUsersEvent() async {
    emit(GettingUserState());
    final result = await _getUsers();
    result.fold(
      (failure) => emit(AuthErrorState(failure.errorMessage)),
      (users) => emit(UserLoadedState(users)),
    );
  }
}
