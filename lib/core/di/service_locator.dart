import 'package:get_it/get_it.dart';
import '../config/app_config.dart';
import '../network/dio_client.dart';
import '../../features/articles/data/datasources/articles_remote_data_source.dart';
import '../../features/articles/data/datasources/articles_local_data_source.dart';
import '../../features/articles/data/repositories/article_repository_impl.dart';
import '../../features/articles/data/repositories/article_mock_repository.dart';
import '../../features/articles/domain/repositories/article_repository.dart';
import '../../features/articles/domain/usecases/get_top_headlines.dart';
import '../../features/articles/presentation/bloc/articles_bloc.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerFactory(() => ArticlesBloc(getTopHeadlines: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetTopHeadlines(sl()));

  // Repository - Choose based on configuration
  if (AppConfig.useMockData) {
    // print('🔧 ServiceLocator: Using Mock Repository for development');
    sl.registerLazySingleton<ArticleRepository>(() => ArticleMockRepository());
  } else {
    // print('🔧 ServiceLocator: Using Real Repository with API');
    sl.registerLazySingleton<ArticleRepository>(
      () =>
          ArticleRepositoryImpl(remoteDataSource: sl(), localDataSource: sl()),
    );
  }

  // Data sources
  sl.registerLazySingleton<ArticlesRemoteDataSource>(
    () => ArticlesRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<ArticlesLocalDataSource>(
    () => ArticlesLocalDataSourceImpl(),
  );

  // Core
  sl.registerLazySingleton(() => DioClient());
}
