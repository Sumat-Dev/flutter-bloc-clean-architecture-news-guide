import 'package:dartz/dartz.dart';
import '../../../../core/utils/typdefs.dart';
import '../../domain/entities/article.dart';
import '../../domain/repositories/article_repository.dart';
import '../datasources/articles_mock_data_source.dart';

class ArticleMockRepository implements ArticleRepository {
  @override
  ResultFuture<List<Article>> getTopHeadlines({
    String? country,
    String? category,
    int? pageSize,
    int? page,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));

    // Return mock data
    final mockArticles = ArticlesMockDataSource.getMockArticles();
    return Right(mockArticles);
  }

  @override
  ResultFuture<List<Article>> searchArticles({
    required String query,
    String? sortBy,
    int? pageSize,
    int? page,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 600));

    // Filter mock data based on query
    final allArticles = ArticlesMockDataSource.getMockArticles();
    final filteredArticles = allArticles.where((article) {
      final searchQuery = query.toLowerCase();
      return article.title.toLowerCase().contains(searchQuery) ||
          article.description.toLowerCase().contains(searchQuery) ||
          article.sourceName.toLowerCase().contains(searchQuery);
    }).toList();

    return Right(filteredArticles);
  }
}
