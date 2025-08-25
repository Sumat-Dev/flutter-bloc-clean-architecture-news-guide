import 'package:equatable/equatable.dart';

class ServerException extends Equatable implements Exception {
  final String message;
  final int? statusCode;

  const ServerException(this.message, [this.statusCode]);

  @override
  String toString() => 'ServerException: $message (Status: $statusCode)';

  @override
  List<Object?> get props => [message, statusCode];
}

class CacheException extends Equatable implements Exception {
  final String message;

  const CacheException(this.message);

  @override
  String toString() => 'CacheException: $message';

  @override
  List<Object?> get props => [message];
}

class NetworkException extends Equatable implements Exception {
  final String message;

  const NetworkException(this.message);

  @override
  String toString() => 'NetworkException: $message';

  @override
  List<Object?> get props => [message];
}

class InvalidInputException extends Equatable implements Exception {
  final String message;

  const InvalidInputException(this.message);

  @override
  String toString() => 'InvalidInputException: $message';

  @override
  List<Object?> get props => [message];
}
