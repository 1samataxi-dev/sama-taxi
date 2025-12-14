import 'package:flutter/foundation.dart';

/// Base class for all application errors
@immutable
abstract class AppError implements Exception {
  const AppError({required this.message, this.code, this.details});

  final String message;
  final String? code;
  final Map<String, dynamic>? details;

  @override
  String toString() =>
      'AppError: $message${code != null ? ' (Code: $code)' : ''}';
}

/// Network related errors
class NetworkError extends AppError {
  const NetworkError({
    required super.message,
    super.code,
    super.details,
    this.statusCode,
  });

  factory NetworkError.noConnection() => const NetworkError(
    message: 'No internet connection available',
    code: 'NO_CONNECTION',
  );

  factory NetworkError.timeout() =>
      const NetworkError(message: 'Request timeout', code: 'TIMEOUT');

  factory NetworkError.serverError(int statusCode) => NetworkError(
    message: 'Server error occurred',
    code: 'SERVER_ERROR',
    statusCode: statusCode,
  );

  factory NetworkError.unauthorized() => const NetworkError(
    message: 'Unauthorized access',
    code: 'UNAUTHORIZED',
    statusCode: 401,
  );

  factory NetworkError.forbidden() => const NetworkError(
    message: 'Access forbidden',
    code: 'FORBIDDEN',
    statusCode: 403,
  );

  factory NetworkError.notFound() => const NetworkError(
    message: 'Resource not found',
    code: 'NOT_FOUND',
    statusCode: 404,
  );

  final int? statusCode;
}

/// Authentication related errors
class AuthError extends AppError {
  const AuthError({required super.message, super.code, super.details});

  factory AuthError.invalidCredentials() => const AuthError(
    message: 'Invalid email or password',
    code: 'INVALID_CREDENTIALS',
  );

  factory AuthError.userNotFound() =>
      const AuthError(message: 'User not found', code: 'USER_NOT_FOUND');

  factory AuthError.emailAlreadyExists() =>
      const AuthError(message: 'Email already exists', code: 'EMAIL_EXISTS');

  factory AuthError.weakPassword() =>
      const AuthError(message: 'Password is too weak', code: 'WEAK_PASSWORD');

  factory AuthError.sessionExpired() =>
      const AuthError(message: 'Session has expired', code: 'SESSION_EXPIRED');
}

/// Validation related errors
class ValidationError extends AppError {
  const ValidationError({
    required super.message,
    super.code,
    super.details,
    this.field,
  });

  factory ValidationError.required(String field) => ValidationError(
    message: '$field is required',
    code: 'REQUIRED_FIELD',
    field: field,
  );

  factory ValidationError.invalidFormat(String field) => ValidationError(
    message: '$field has invalid format',
    code: 'INVALID_FORMAT',
    field: field,
  );

  factory ValidationError.tooShort(String field, int minLength) =>
      ValidationError(
        message: '$field must be at least $minLength characters',
        code: 'TOO_SHORT',
        field: field,
        details: {'minLength': minLength},
      );

  factory ValidationError.tooLong(String field, int maxLength) =>
      ValidationError(
        message: '$field must be no more than $maxLength characters',
        code: 'TOO_LONG',
        field: field,
        details: {'maxLength': maxLength},
      );

  final String? field;
}

/// Business logic related errors
class BusinessError extends AppError {
  const BusinessError({required super.message, super.code, super.details});

  factory BusinessError.insufficientSeats() => const BusinessError(
    message: 'Not enough seats available',
    code: 'INSUFFICIENT_SEATS',
  );

  factory BusinessError.bookingClosed() => const BusinessError(
    message: 'Booking is closed for this visit',
    code: 'BOOKING_CLOSED',
  );

  factory BusinessError.paymentFailed() => const BusinessError(
    message: 'Payment processing failed',
    code: 'PAYMENT_FAILED',
  );
}

/// Storage related errors
class StorageError extends AppError {
  const StorageError({required super.message, super.code, super.details});

  factory StorageError.readFailed() => const StorageError(
    message: 'Failed to read from storage',
    code: 'READ_FAILED',
  );

  factory StorageError.writeFailed() => const StorageError(
    message: 'Failed to write to storage',
    code: 'WRITE_FAILED',
  );

  factory StorageError.notFound() => const StorageError(
    message: 'Data not found in storage',
    code: 'NOT_FOUND',
  );
}

/// Unknown or unexpected errors
class UnknownError extends AppError {
  const UnknownError({
    required super.message,
    super.code,
    super.details,
    this.originalError,
  });

  factory UnknownError.fromException(Object error) => UnknownError(
    message: 'An unexpected error occurred',
    code: 'UNKNOWN',
    originalError: error,
    details: {'originalError': error.toString()},
  );

  final Object? originalError;
}
