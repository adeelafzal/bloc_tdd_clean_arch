import 'package:bloc_tdd_clean_arch/core/errors/exception.dart';
import 'package:bloc_tdd_clean_arch/core/errors/failure.dart';
import 'package:bloc_tdd_clean_arch/core/utils/typedef.dart';
import 'package:bloc_tdd_clean_arch/features/articles/data/datasource/article_data_source.dart';
import 'package:bloc_tdd_clean_arch/features/articles/domain/entities/articles.dart';
import 'package:bloc_tdd_clean_arch/features/articles/domain/repositories/articles_repo.dart';
import 'package:dartz/dartz.dart';

class ArticleRepoImpl implements ArticlesRepo {
  final ArticleDataSource _dataSource;

  ArticleRepoImpl(this._dataSource);

  @override
  ResultVoid addArticle({required String title, required String desc}) async {
    try {
      await _dataSource.addArticle(title: title, desc: desc);
      return const Right(null);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<Articles>> fetchArticles() async {
    try {
      final articles = await _dataSource.fetchArticles();
      return Right(articles);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }

  @override
  ResultVoid updateArticle(
      {required String id, required String title, required String desc}) async {
    try {
      await _dataSource.updateArticle(id: id, title: title, desc: desc);
      return const Right(null);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }
}
