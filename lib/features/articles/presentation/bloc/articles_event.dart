part of 'articles_bloc.dart';

abstract class ArticlesEvent extends Equatable {
  const ArticlesEvent();

  @override
  List<Object?> get props => [];
}

class LoadTopHeadlines extends ArticlesEvent {
  final String? country;
  final String? category;
  final int? pageSize;
  final int? page;

  const LoadTopHeadlines({
    this.country,
    this.category,
    this.pageSize,
    this.page,
  });

  @override
  List<Object?> get props => [country, category, pageSize, page];
}

class RefreshTopHeadlines extends ArticlesEvent {
  final String? country;
  final String? category;
  final int? pageSize;

  const RefreshTopHeadlines({
    this.country,
    this.category,
    this.pageSize,
  });

  @override
  List<Object?> get props => [country, category, pageSize];
}
