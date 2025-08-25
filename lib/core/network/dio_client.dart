import 'package:dio/dio.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../config/app_config.dart';
import '../error/exceptions.dart';
import '../utils/typdefs.dart';

class DioClient {
  late Dio _dio;

  DioClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppConfig.baseUrl,
        connectTimeout: AppConfig.connectionTimeout,
        receiveTimeout: AppConfig.receiveTimeout,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    _setupInterceptors();
  }

  void _setupInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Add API key to query parameters
          if (options.queryParameters['apiKey'] == null) {
            options.queryParameters['apiKey'] = AppConfig.apiKey;
          }
          handler.next(options);
        },
        onResponse: (response, handler) {
          handler.next(response);
        },
        onError: (error, handler) async {
          if (error.type == DioExceptionType.connectionTimeout ||
              error.type == DioExceptionType.receiveTimeout) {
            handler.reject(
              DioException(
                requestOptions: error.requestOptions,
                error: NetworkException('Connection timeout'),
              ),
            );
            return;
          }

          if (error.type == DioExceptionType.connectionError) {
            final hasInternet = await InternetConnectionChecker().hasConnection;
            if (!hasInternet) {
              handler.reject(
                DioException(
                  requestOptions: error.requestOptions,
                  error: NetworkException('No internet connection'),
                ),
              );
              return;
            }
          }

          handler.next(error);
        },
      ),
    );
  }

  Dio get dio => _dio;

  Future<Response> get(
    String path, {
    DataMap? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        throw ServerException(
          e.response?.data?['message'] ?? 'Server error',
          e.response?.statusCode,
        );
      }
      throw NetworkException(e.message ?? 'Network error');
    }
  }

  Future<Response> post(
    String path, {
    dynamic data,
    DataMap? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        throw ServerException(
          e.response?.data?['message'] ?? 'Server error',
          e.response?.statusCode,
        );
      }
      throw NetworkException(e.message ?? 'Network error');
    }
  }
}
