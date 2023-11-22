import 'package:bloc_tdd_clean_arch/features/articles/presentation/bloc/article_bloc.dart';
import 'package:bloc_tdd_clean_arch/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddUserDialog extends StatelessWidget {
  final TextEditingController title;
  final TextEditingController desc;

  const AddUserDialog({super.key, required this.title, required this.desc});

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
                decoration: const InputDecoration(labelText: "Title"),
                controller: title,
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(labelText: "Description"),
                controller: desc,
              ),
              ElevatedButton(
                  onPressed: () {
                    context.read<ArticleBloc>().add(
                        UpdateArticleEvent(id:"1",title: title.text, desc: desc.text));
                    Navigator.pop(context);
                  },
                  child: const Text("Create user"))
            ],
          ),
        ),
      ),
    );
  }
}
