import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/utils/typdefs.dart';
import '../../domain/entities/article.dart';
import '../../domain/repositories/article_repository.dart';
import '../datasources/articles_remote_data_source.dart';
import '../datasources/articles_local_data_source.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final ArticlesRemoteDataSource remoteDataSource;
  final ArticlesLocalDataSource localDataSource;

  ArticleRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  ResultFuture<List<Article>> getTopHeadlines({
    String? country,
    String? category,
    int? pageSize,
    int? page,
  }) async {
    try {
      final articles = await remoteDataSource.getTopHeadlines(
        country: country,
        category: category,
        pageSize: pageSize,
        page: page,
      );

      // Cache the articles
      await localDataSource.cacheArticles(articles);

      return Right(articles);
    } on ServerException catch (e) {
      // Try to get cached articles if remote fails
      try {
        final cachedArticles = await localDataSource.getCachedArticles();
        if (cachedArticles.isNotEmpty) {
          return Right(cachedArticles);
        }
      } catch (cacheError) {
        return const Left(CacheFailure('Failed to get cached articles'));
      }

      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      // Try to get cached articles if network fails
      try {
        final cachedArticles = await localDataSource.getCachedArticles();
        if (cachedArticles.isNotEmpty) {
          return Right(cachedArticles);
        }
      } catch (cacheError) {
        return const Left(CacheFailure('Failed to get cached articles'));
      }

      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }

  @override
  ResultFuture<List<Article>> searchArticles({
    required String query,
    String? sortBy,
    int? pageSize,
    int? page,
  }) async {
    try {
      final articles = await remoteDataSource.searchArticles(
        query: query,
        sortBy: sortBy,
        pageSize: pageSize,
        page: page,
      );

      return Right(articles);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }
}
