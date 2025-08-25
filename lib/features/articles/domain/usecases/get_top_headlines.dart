import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/typdefs.dart';
import '../entities/article.dart';
import '../repositories/article_repository.dart';

class GetTopHeadlines
    implements UsecaseWithParams<List<Article>, GetTopHeadlinesParams> {
  final ArticleRepository repository;

  const GetTopHeadlines(this.repository);

  @override
  ResultFuture<List<Article>> call(GetTopHeadlinesParams params) async {
    return await repository.getTopHeadlines(
      country: params.country,
      category: params.category,
      pageSize: params.pageSize,
      page: params.page,
    );
  }
}

class GetTopHeadlinesParams {
  final String? country;
  final String? category;
  final int? pageSize;
  final int? page;

  GetTopHeadlinesParams({
    this.country,
    this.category,
    this.pageSize,
    this.page,
  });
}
