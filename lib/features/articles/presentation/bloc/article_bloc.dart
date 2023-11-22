import 'dart:async';
import 'package:bloc_tdd_clean_arch/features/articles/domain/entities/articles.dart';
import 'package:bloc_tdd_clean_arch/features/articles/domain/usecase/add_article.dart';
import 'package:bloc_tdd_clean_arch/features/articles/domain/usecase/get_articles.dart';
import 'package:bloc_tdd_clean_arch/features/articles/domain/usecase/update_article.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'article_event.dart';

part 'article_state.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final AddArticle addArticle;
  final GetArticles getArticles;
  final UpdateArticle updateArticle;

  ArticleBloc({
    required this.addArticle,
    required this.getArticles,
    required this.updateArticle,
  }) : super(LoadingArticleState()) {
    on<GetArticleEvent>(onGetArticles);
    on<CreateArticleEvent>(onCreateArticle);
    on<UpdateArticleEvent>(onUpdateArticle);
  }

  Future<void> onGetArticles(
      GetArticleEvent event, Emitter<ArticleState> emit) async {
    emit(LoadingArticleState());
    final articles = await getArticles();
    articles.fold((l) => emit(ErrorArticleState(l.errorMessage)), (r) {
      if (r.isNotEmpty) {
        return emit(LoadedArticleState(r));
      } else {
        return emit(EmptyArticleState());
      }
    });
  }

  Future<FutureOr<void>> onCreateArticle(
      CreateArticleEvent event, Emitter<ArticleState> emit) async {
    emit(LoadingArticleState());
    final articles = await addArticle(Articles.add(title: event.title, desc: event.desc));
    articles.fold((l) => emit(ErrorArticleState(l.errorMessage)), (r) {
      return emit(LoadAgainState());
    });
  }

  Future<FutureOr<void>> onUpdateArticle(
      UpdateArticleEvent event, Emitter<ArticleState> emit) async {
    emit(LoadingArticleState());
    final articles = await updateArticle(Articles.update(id:"1",title: event.title, desc: event.desc));
    articles.fold((l) => emit(ErrorArticleState(l.errorMessage)), (r) {
      return emit(LoadAgainState());
    });
  }
}
