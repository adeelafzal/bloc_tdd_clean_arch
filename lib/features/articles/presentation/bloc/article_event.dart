part of 'article_bloc.dart';

abstract class ArticleEvent extends Equatable {
  const ArticleEvent();

  @override
  List<Object> get props => [];
}

class CreateArticleEvent extends ArticleEvent {
  final String title, desc;

  const CreateArticleEvent({
    required this.title,
    required this.desc,
  });

  @override
  List<Object> get props => [title, desc];
}

class UpdateArticleEvent extends ArticleEvent {
  final String id, title, desc;

  const UpdateArticleEvent({
    required this.id,
    required this.title,
    required this.desc,
  });

  @override
  List<Object> get props => [title, desc, id];
}

class GetArticleEvent extends ArticleEvent {}
