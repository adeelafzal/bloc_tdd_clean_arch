part of 'article_bloc.dart';

abstract class ArticleState extends Equatable {
  const ArticleState();

  @override
  List<Object> get props => [];
}

class LoadingArticleState extends ArticleState {}

class LoadAgainState extends ArticleState {}

class EmptyArticleState extends ArticleState {}

class ErrorArticleState extends ArticleState {
  final String message;

  const ErrorArticleState(this.message);

  @override
  List<Object> get props => [message];
}

class LoadedArticleState extends ArticleState {
  final List<Articles> articles;

  const LoadedArticleState(this.articles);

  @override
  List<Object> get props => articles.map((e) => e.id!).toList();
}
