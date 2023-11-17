import 'package:bloc_tdd_clean_arch/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:bloc_tdd_clean_arch/features/authentication/presentation/cubit/auth_state.dart';
import 'package:bloc_tdd_clean_arch/features/authentication/presentation/widgets/add_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final name = TextEditingController();

  @override
  void initState() {
    getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (BuildContext context, AuthState state) {
        if (state is AuthErrorState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        } else if (state is UserCreatedState) {
          getUsers();
        }
      },
      builder: (BuildContext context, AuthState state) {
        return Scaffold(
          body: state is GettingUserState
              ? const Center(child: CircularProgressIndicator())
              : state is CreatingUserState
                  ? const Center(child: CircularProgressIndicator())
                  : state is UserLoadedState
                      ? ListView.builder(
                          itemCount: state.users.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Text(state.users[index].name);
                          },
                        )
                      : const Text(""),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () async {
              await showDialog(
                  context: context,
                  builder: (context) => AddUserDialog(name: name));
            },
            label: const Text("Add User"),
            icon: const Icon(Icons.add),
          ),
        );
      },
    );
  }

  void getUsers() {
    context.read<AuthCubit>().getUsersEvent();
  }
}
