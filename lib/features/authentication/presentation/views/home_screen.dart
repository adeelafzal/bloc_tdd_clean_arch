import 'package:bloc_tdd_clean_arch/features/articles/presentation/bloc/article_bloc.dart';
import 'package:bloc_tdd_clean_arch/features/authentication/presentation/widgets/add_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final title = TextEditingController();
  final desc = TextEditingController();

  @override
  void initState() {
    getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ArticleBloc, ArticleState>(
      listener: (BuildContext context, ArticleState state) {
        if (state is ErrorArticleState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        } else if (state is LoadAgainState) {
          getUsers();
        }
      },
      builder: (BuildContext context, ArticleState state) {
        return Scaffold(
          body: state is EmptyArticleState
              ? const Center(child: Text("Data Not Found"))
              : state is LoadingArticleState
                  ? const Center(child: CircularProgressIndicator())
                  : state is LoadedArticleState
                      ? ListView.separated(
                          itemCount: state.articles.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              onTap: () async {
                                await showDialog(
                                    context: context,
                                    builder: (context) => AddUserDialog(
                                        title: TextEditingController(
                                            text: state.articles[index].title),
                                        desc: TextEditingController(
                                            text: state.articles[index].desc)));
                              },
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: FadeInImage(
                                  placeholder: NetworkImage(
                                      state.articles[index].avatar!),
                                  image: NetworkImage(
                                      state.articles[index].avatar!),
                                ),
                              ),
                              title: Text(
                                state.articles[index].title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              subtitle: Text(
                                state.articles[index].desc,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            );
                          },
                          separatorBuilder: (_, int index) => Divider(),
                        )
                      : const Text(""),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () async {
              await showDialog(
                  context: context,
                  builder: (context) =>
                      AddUserDialog(title: title, desc: desc));
            },
            label: const Text("Add User"),
            icon: const Icon(Icons.add),
          ),
        );
      },
    );
  }

  void getUsers() {
    context.read<ArticleBloc>().add(GetArticleEvent());
  }
}
