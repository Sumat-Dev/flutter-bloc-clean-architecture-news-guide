import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/article.dart';
import '../../domain/usecases/get_top_headlines.dart';

part 'articles_event.dart';
part 'articles_state.dart';

class ArticlesBloc extends Bloc<ArticlesEvent, ArticlesState> {
  final GetTopHeadlines getTopHeadlines;

  ArticlesBloc({required this.getTopHeadlines}) : super(ArticlesInitial()) {
    on<LoadTopHeadlines>(_onLoadTopHeadlines);
    on<RefreshTopHeadlines>(_onRefreshTopHeadlines);
  }

  Future<void> _onLoadTopHeadlines(
    LoadTopHeadlines event,
    Emitter<ArticlesState> emit,
  ) async {
    // print('🔄 ArticlesBloc: Loading top headlines...');
    emit(ArticlesLoading());

    try {
      final result = await getTopHeadlines(
        GetTopHeadlinesParams(
          country: event.country,
          category: event.category,
          pageSize: event.pageSize,
          page: event.page,
        ),
      );

      result.fold(
        (failure) {
          // print('❌ ArticlesBloc: Error loading headlines - ${failure.message}');
          emit(ArticlesError(failure.message));
        },
        (articles) {
          // print('✅ ArticlesBloc: Successfully loaded ${articles.length} articles');
          emit(ArticlesLoaded(articles));
        },
      );
    } catch (e) {
      // print('💥 ArticlesBloc: Exception occurred - $e');
      emit(ArticlesError('Unexpected error: $e'));
    }
  }

  Future<void> _onRefreshTopHeadlines(
    RefreshTopHeadlines event,
    Emitter<ArticlesState> emit,
  ) async {
    // print('🔄 ArticlesBloc: Refreshing top headlines...');
    emit(ArticlesLoading());

    try {
      final result = await getTopHeadlines(
        GetTopHeadlinesParams(
          country: event.country,
          category: event.category,
          pageSize: event.pageSize,
          page: 1, // Reset to first page on refresh
        ),
      );

      result.fold(
        (failure) {
          // print('❌ ArticlesBloc: Error refreshing headlines - ${failure.message}');
          emit(ArticlesError(failure.message));
        },
        (articles) {
          // print('✅ ArticlesBloc: Successfully refreshed ${articles.length} articles');
          emit(ArticlesLoaded(articles));
        },
      );
    } catch (e) {
      // print('💥 ArticlesBloc: Exception occurred during refresh - $e');
      emit(ArticlesError('Unexpected error: $e'));
    }
  }
}
