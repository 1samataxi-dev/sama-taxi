import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  final int? statusCode;
  final dynamic data;

  const Failure(this.message, {this.statusCode, this.data});

  @override
  List<Object?> get props => [message, statusCode, data];
}

class ServerFailure extends Failure {
  const ServerFailure(String message, {int? statusCode, dynamic data})
      : super(message, statusCode: statusCode, data: data);
}

class CacheFailure extends Failure {
  const CacheFailure(String message) : super(message);
}

class NetworkFailure extends Failure {
  const NetworkFailure(String message) : super(message);
}

class ValidationFailure extends Failure {
  const ValidationFailure(String message) : super(message);
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure(String message) : super(message);
}
