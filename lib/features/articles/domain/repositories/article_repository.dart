import '../../../../core/utils/typdefs.dart';
import '../entities/article.dart';

abstract class ArticleRepository {
  ResultFuture<List<Article>> getTopHeadlines({
    String? country,
    String? category,
    int? pageSize,
    int? page,
  });

  ResultFuture<List<Article>> searchArticles({
    required String query,
    String? sortBy,
    int? pageSize,
    int? page,
  });
}
