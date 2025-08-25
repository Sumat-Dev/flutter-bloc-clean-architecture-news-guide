import '../../../../core/error/exceptions.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/config/app_config.dart';
import '../models/article_model.dart';

abstract class ArticlesRemoteDataSource {
  Future<List<ArticleModel>> getTopHeadlines({
    String? country,
    String? category,
    int? pageSize,
    int? page,
  });

  Future<List<ArticleModel>> searchArticles({
    required String query,
    String? sortBy,
    int? pageSize,
    int? page,
  });
}

class ArticlesRemoteDataSourceImpl implements ArticlesRemoteDataSource {
  final DioClient dioClient;

  ArticlesRemoteDataSourceImpl(this.dioClient);

  @override
  Future<List<ArticleModel>> getTopHeadlines({
    String? country,
    String? category,
    int? pageSize,
    int? page,
  }) async {
    try {
      final response = await dioClient.get(
        AppConfig.topHeadlinesEndpoint,
        queryParameters: {
          'country': country ?? AppConfig.defaultCountry,
          'category': category ?? AppConfig.defaultCategory,
          'pageSize': pageSize ?? AppConfig.defaultPageSize,
          'page': page ?? 1,
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> articlesJson = response.data['articles'] ?? [];
        return articlesJson
            .map((json) => ArticleModel.fromJson(json))
            .toList();
      } else {
        throw ServerException('Failed to fetch top headlines');
      }
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException('Failed to fetch top headlines: $e');
    }
  }

  @override
  Future<List<ArticleModel>> searchArticles({
    required String query,
    String? sortBy,
    int? pageSize,
    int? page,
  }) async {
    try {
      final response = await dioClient.get(
        AppConfig.everythingEndpoint,
        queryParameters: {
          'q': query,
          'sortBy': sortBy ?? 'publishedAt',
          'pageSize': pageSize ?? AppConfig.defaultPageSize,
          'page': page ?? 1,
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> articlesJson = response.data['articles'] ?? [];
        return articlesJson
            .map((json) => ArticleModel.fromJson(json))
            .toList();
      } else {
        throw ServerException('Failed to search articles');
      }
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException('Failed to search articles: $e');
    }
  }
}
