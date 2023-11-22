import 'dart:convert';

import 'package:bloc_tdd_clean_arch/core/errors/exception.dart';
import 'package:bloc_tdd_clean_arch/core/utils/constants.dart';
import 'package:bloc_tdd_clean_arch/features/articles/data/model/article_model.dart';
import 'package:http/http.dart';

abstract class ArticleDataSource {
  Future<List<ArticleModel>> fetchArticles();

  Future addArticle({
    required String title,
    required String desc,
  });

  Future updateArticle({
    required String id,
    required String title,
    required String desc,
  });
}

class ArticleDataSourceImpl implements ArticleDataSource {
  final Client _client;

  ArticleDataSourceImpl(this._client);

  @override
  Future<void> addArticle({required String title, required String desc}) async {
    try {
      final response = await _client.post(Uri.parse("$kBaseUrl$kArticles"),
          body: jsonEncode({"title": title, "desc": desc}),
          headers: {"Content-Type": "application/json"});
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ApiException(
            message: response.body, statusCode: response.statusCode);
      }
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<List<ArticleModel>> fetchArticles() async {
    try {
      final response = await _client.get(Uri.parse("$kBaseUrl$kArticles"));
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ApiException(
            message: response.body, statusCode: response.statusCode);
      }
      return articleModelFromJson(response.body);
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future updateArticle(
      {required String id, required String title, required String desc}) async {
    try {
      final response = await _client.put(Uri.parse("$kBaseUrl$kArticles/:$id"),
          body: jsonEncode({"title": title, "desc": desc}),
          headers: {"Content-Type": "application/json"});
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ApiException(
            message: response.body, statusCode: response.statusCode);
      }
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(message: e.toString(), statusCode: 505);
    }
  }
}
