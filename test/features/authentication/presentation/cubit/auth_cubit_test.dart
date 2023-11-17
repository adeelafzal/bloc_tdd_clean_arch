import 'package:bloc_tdd_clean_arch/features/authentication/domain/usecase/create_user.dart';
import 'package:bloc_tdd_clean_arch/features/authentication/domain/usecase/get_users.dart';
import 'package:bloc_tdd_clean_arch/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:bloc_tdd_clean_arch/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCreateUsers extends Mock implements CreateUser {}

class MockGetUsers extends Mock implements GetUsers {}

main() {
  late GetUsers getUsers;
  late CreateUser createUser;
  late AuthCubit authCubit;
  const tCreateUserParams = CreateUserParams.empty();

  setUp(() {
    getUsers = MockGetUsers();
    createUser = MockCreateUsers();
    authCubit = AuthCubit(createUser: createUser, getUsers: getUsers);
  });

  tearDown(() => authCubit.close());

  test("initial state should be ", () async {
    expect(authCubit.state, const AuthInitialState());
  });


}
