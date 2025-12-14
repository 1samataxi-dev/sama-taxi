import 'package:flutter/material.dart';
import 'package:sama_taxi/core/error/app_error.dart';
import 'package:sama_taxi/core/services/logging_service.dart';

/// Global error handler for the application
class ErrorHandler {
  factory ErrorHandler() => _instance;
  ErrorHandler._internal();
  static final ErrorHandler _instance = ErrorHandler._internal();

  /// Handle and display error to user
  void handleError(
    BuildContext context,
    Object error, {
    StackTrace? stackTrace,
    bool showSnackBar = true,
  }) {
    final appError = _convertToAppError(error);

    // Log the error
    logger.error('Error occurred: ${appError.message}', error, stackTrace);

    // Show user-friendly message
    if (showSnackBar && context.mounted) {
      _showErrorSnackBar(context, appError);
    }
  }

  /// Convert any error to AppError
  AppError _convertToAppError(Object error) {
    if (error is AppError) {
      return error;
    }

    // Convert common Flutter/Dart errors
    if (error is FormatException) {
      return ValidationError.invalidFormat('Input');
    }

    if (error is ArgumentError) {
      return ValidationError(
        message: error.message?.toString() ?? 'Invalid argument',
        code: 'INVALID_ARGUMENT',
      );
    }

    // Default to unknown error
    return UnknownError.fromException(error);
  }

  /// Show error snack bar with appropriate styling
  void _showErrorSnackBar(BuildContext context, AppError error) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(_getErrorIcon(error), color: Colors.white, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _getErrorTitle(error),
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    error.message,
                    style: const TextStyle(fontSize: 13, color: Colors.white70),
                  ),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: _getErrorColor(error, colorScheme),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        action: SnackBarAction(
          label: 'Dismiss',
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  /// Get appropriate icon for error type
  IconData _getErrorIcon(AppError error) {
    switch (error.runtimeType) {
      case NetworkError:
        return Icons.wifi_off;
      case AuthError:
        return Icons.lock_outline;
      case ValidationError:
        return Icons.warning_outlined;
      case BusinessError:
        return Icons.business_outlined;
      case StorageError:
        return Icons.storage_outlined;
      default:
        return Icons.error_outline;
    }
  }

  /// Get appropriate title for error type
  String _getErrorTitle(AppError error) {
    switch (error.runtimeType) {
      case NetworkError:
        return 'Connection Error';
      case AuthError:
        return 'Authentication Error';
      case ValidationError:
        return 'Validation Error';
      case BusinessError:
        return 'Business Error';
      case StorageError:
        return 'Storage Error';
      default:
        return 'Error';
    }
  }

  /// Get appropriate color for error type
  Color _getErrorColor(AppError error, ColorScheme colorScheme) {
    switch (error.runtimeType) {
      case NetworkError:
        return Colors.orange;
      case AuthError:
        return Colors.red;
      case ValidationError:
        return Colors.amber;
      case BusinessError:
        return Colors.blue;
      case StorageError:
        return Colors.purple;
      default:
        return colorScheme.error;
    }
  }

  /// Show error dialog for critical errors
  void showErrorDialog(
    BuildContext context,
    AppError error, {
    VoidCallback? onRetry,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: Icon(
          _getErrorIcon(error),
          size: 48,
          color: Theme.of(context).colorScheme.error,
        ),
        title: Text(_getErrorTitle(error)),
        content: Text(error.message),
        actions: [
          if (onRetry != null)
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                onRetry();
              },
              child: const Text('Retry'),
            ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

/// Global error handler instance
final errorHandler = ErrorHandler();

/// Mixin for easy error handling in widgets
mixin ErrorHandlerMixin {
  ErrorHandler get errorHandler => ErrorHandler();

  void handleError(
    BuildContext context,
    Object error, {
    StackTrace? stackTrace,
    bool showSnackBar = true,
  }) {
    errorHandler.handleError(
      context,
      error,
      stackTrace: stackTrace,
      showSnackBar: showSnackBar,
    );
  }
}
