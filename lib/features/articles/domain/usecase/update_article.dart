import 'package:bloc_tdd_clean_arch/core/usecase/usecase.dart';
import 'package:bloc_tdd_clean_arch/core/utils/typedef.dart';
import 'package:bloc_tdd_clean_arch/features/articles/domain/entities/articles.dart';
import 'package:bloc_tdd_clean_arch/features/articles/domain/repositories/articles_repo.dart';

class UpdateArticle extends UseCaseWithParams<void, Articles> {
  final ArticlesRepo _repo;

  UpdateArticle(this._repo);

  @override
  ResultFuture<void> call(Articles params) => _repo.updateArticle(
      id: params.id!, title: params.title, desc: params.desc);
}
