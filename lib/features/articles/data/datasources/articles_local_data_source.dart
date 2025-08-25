import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/error/exceptions.dart';
import '../models/article_model.dart';

abstract class ArticlesLocalDataSource {
  Future<List<ArticleModel>> getCachedArticles();
  Future<void> cacheArticles(List<ArticleModel> articles);
  Future<void> clearCache();
}

class ArticlesLocalDataSourceImpl implements ArticlesLocalDataSource {
  static const String _cacheKey = 'cached_articles';
  static const String _cacheTimestampKey = 'cache_timestamp';
  static const Duration _cacheExpiration = Duration(hours: 1);

  @override
  Future<List<ArticleModel>> getCachedArticles() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final timestamp = prefs.getInt(_cacheTimestampKey);

      if (timestamp == null) {
        return [];
      }

      final now = DateTime.now().millisecondsSinceEpoch;
      if (now - timestamp > _cacheExpiration.inMilliseconds) {
        await clearCache();
        return [];
      }

      final articlesJson = prefs.getStringList(_cacheKey) ?? [];
      return articlesJson
          .map((json) => ArticleModel.fromJson(jsonDecode(json)))
          .toList();
    } catch (e) {
      throw CacheException('Failed to get cached articles: $e');
    }
  }

  @override
  Future<void> cacheArticles(List<ArticleModel> articles) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final articlesJson = articles
          .map((article) => jsonEncode(article.toJson()))
          .toList();

      await prefs.setStringList(_cacheKey, articlesJson);
      await prefs.setInt(_cacheTimestampKey, DateTime.now().millisecondsSinceEpoch);
    } catch (e) {
      throw CacheException('Failed to cache articles: $e');
    }
  }

  @override
  Future<void> clearCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_cacheKey);
      await prefs.remove(_cacheTimestampKey);
    } catch (e) {
      throw CacheException('Failed to clear cache: $e');
    }
  }
}
