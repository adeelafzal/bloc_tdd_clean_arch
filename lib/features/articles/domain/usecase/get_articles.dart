import 'package:bloc_tdd_clean_arch/core/usecase/usecase.dart';
import 'package:bloc_tdd_clean_arch/core/utils/typedef.dart';
import 'package:bloc_tdd_clean_arch/features/articles/domain/entities/articles.dart';
import 'package:bloc_tdd_clean_arch/features/articles/domain/repositories/articles_repo.dart';

class GetArticles extends UseCaseWithOutParams<List<Articles>> {
  final ArticlesRepo _repo;

  GetArticles(this._repo);

  @override
  ResultFuture<List<Articles>> call() => _repo.fetchArticles();
}
