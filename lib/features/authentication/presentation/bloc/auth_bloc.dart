import 'dart:async';

import 'package:bloc_tdd_clean_arch/features/authentication/domain/entities/user.dart';
import 'package:bloc_tdd_clean_arch/features/authentication/domain/usecase/create_user.dart';
import 'package:bloc_tdd_clean_arch/features/authentication/domain/usecase/get_users.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final CreateUser _createUser;
  final GetUsers _getUsers;

  AuthBloc({
    required CreateUser createUser,
    required GetUsers getUsers,
  })  : _createUser = createUser,
        _getUsers = getUsers,
        super(AuthInitialState()) {
    on<CreateUserEvent>(_onCreateUserEvent);
    on<GetUsersEvent>(_onGetUsersEvent);
  }

  Future<void> _onCreateUserEvent(
      CreateUserEvent event, Emitter<AuthState> emit) async {
    emit(CreatingUserState());
    final result = await _createUser(CreateUserParams(
      createdAt: event.createdAt,
      name: event.name,
      avatar: event.avatar,
    ));
    result.fold(
      (failure) => emit(AuthErrorState(failure.errorMessage)),
      (_) => emit(UserCreatedState()),
    );
  }

  Future<void> _onGetUsersEvent(
      GetUsersEvent event, Emitter<AuthState> emit) async {
    emit(GettingUserState());
    final result = await _getUsers();
    result.fold(
      (failure) => emit(AuthErrorState(failure.errorMessage)),
      (users) => emit(UserLoadedState(users)),
    );
  }
}
