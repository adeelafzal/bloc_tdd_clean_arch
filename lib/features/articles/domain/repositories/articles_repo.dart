import 'package:bloc_tdd_clean_arch/core/utils/typedef.dart';
import 'package:bloc_tdd_clean_arch/features/articles/domain/entities/articles.dart';

abstract class ArticlesRepo {
  ResultFuture<List<Articles>> fetchArticles();

  ResultVoid addArticle({
    required String title,
    required String desc,
  });

  ResultVoid updateArticle({
    required String id,
    required String title,
    required String desc,
  });
}
