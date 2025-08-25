import 'package:json_annotation/json_annotation.dart';
import '../../../../core/utils/typdefs.dart';
import '../../domain/entities/article.dart';

part 'article_model.g.dart';

@JsonSerializable()
class ArticleModel extends Article {
  const ArticleModel({
    required super.id,
    required super.title,
    required super.description,
    required super.url,
    super.urlToImage,
    required super.publishedAt,
    required super.sourceName,
  });

  factory ArticleModel.fromJson(DataMap json) => _$ArticleModelFromJson(json);

  DataMap toJson() => _$ArticleModelToJson(this);

  factory ArticleModel.fromEntity(Article article) {
    return ArticleModel(
      id: article.id,
      title: article.title,
      description: article.description,
      url: article.url,
      urlToImage: article.urlToImage,
      publishedAt: article.publishedAt,
      sourceName: article.sourceName,
    );
  }
}
