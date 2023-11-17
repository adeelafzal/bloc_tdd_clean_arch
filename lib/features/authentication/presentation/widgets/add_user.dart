import 'package:bloc_tdd_clean_arch/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddUserDialog extends StatelessWidget {
  final TextEditingController name;

  const AddUserDialog({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.all(20),
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: "Name"),
                controller: name,
              ),
              ElevatedButton(
                  onPressed: () {
                    context.read<AuthCubit>().createUsersEvent(
                        createdAt: DateTime.now().toString(),
                        name: name.text,
                        avatar:
                            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/171.jpg");
                    Navigator.pop(context);
                  },
                  child: Text("Create user"))
            ],
          ),
        ),
      ),
    );
  }
}
