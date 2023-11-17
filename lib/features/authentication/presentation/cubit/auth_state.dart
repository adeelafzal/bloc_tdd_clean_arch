import 'package:bloc_tdd_clean_arch/features/authentication/domain/entities/user.dart';
import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitialState extends AuthState {}

class CreatingUserState extends AuthState {}

class GettingUserState extends AuthState {}

class UserCreatedState extends AuthState {}

class UserLoadedState extends AuthState {
  final List<User> users;

  const UserLoadedState(this.users);

  @override
  List<Object> get props => users.map((e) => e.id).toList();
}

class AuthErrorState extends AuthState {
  final String message;

  const AuthErrorState(this.message);

  @override
  List<Object> get props => [message];
}
