import 'dart:convert';
import 'package:bloc_tdd_clean_arch/features/articles/domain/entities/articles.dart';

List<ArticleModel> articleModelFromJson(String str) => List<ArticleModel>.from(
    jsonDecode(str).map((x) => ArticleModel.fromJson(x)));

class ArticleModel extends Articles {
  ArticleModel(
      {required super.id,
      required super.createdAt,
      required super.title,
      required super.avatar,
      required super.desc});

  factory ArticleModel.fromJson(Map<String, dynamic> json) => ArticleModel(
        createdAt: json["createdAt"],
        title: json["title"],
        avatar: json["avatar"],
        desc: json["desc"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt,
        "title": title,
        "avatar": avatar,
        "desc": desc,
        "id": id,
      };
}
