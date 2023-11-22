import 'package:bloc_tdd_clean_arch/core/usecase/usecase.dart';
import 'package:bloc_tdd_clean_arch/core/utils/typedef.dart';
import 'package:bloc_tdd_clean_arch/features/articles/domain/entities/articles.dart';
import 'package:bloc_tdd_clean_arch/features/articles/domain/repositories/articles_repo.dart';

class AddArticle extends UseCaseWithParams<void, Articles> {
  final ArticlesRepo _repo;

  AddArticle(this._repo);

  @override
  ResultFuture call(params) => _repo.addArticle(title: params.title, desc: params.desc);
}
