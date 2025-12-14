import 'package:flutter/material.dart';
import 'package:sama_taxi/core/widgets/enhanced_empty_widget.dart';
import 'package:sama_taxi/core/widgets/enhanced_error_widget.dart';
import 'package:sama_taxi/core/widgets/enhanced_loading_widget.dart';

enum ViewState { loading, success, error, empty }

class StateWrapperWidget extends StatelessWidget {

  const StateWrapperWidget({
    super.key,
    required this.state,
    required this.child,
    this.loadingMessage,
    this.errorType,
    this.errorTitle,
    this.errorMessage,
    this.onRetry,
    this.emptyType,
    this.emptyTitle,
    this.emptyMessage,
    this.onEmptyAction,
    this.emptyActionText,
  });

  // Factory constructors for common scenarios
  factory StateWrapperWidget.loading({String? message}) => StateWrapperWidget(
      state: ViewState.loading,
      loadingMessage: message,
      child: const SizedBox.shrink(),
    );

  factory StateWrapperWidget.error({
    ErrorType? errorType,
    String? title,
    String? message,
    VoidCallback? onRetry,
  }) => StateWrapperWidget(
      state: ViewState.error,
      errorType: errorType,
      errorTitle: title,
      errorMessage: message,
      onRetry: onRetry,
      child: const SizedBox.shrink(),
    );

  factory StateWrapperWidget.empty({
    EmptyStateType? emptyType,
    String? title,
    String? message,
    VoidCallback? onAction,
    String? actionText,
  }) => StateWrapperWidget(
      state: ViewState.empty,
      emptyType: emptyType,
      emptyTitle: title,
      emptyMessage: message,
      onEmptyAction: onAction,
      emptyActionText: actionText,
      child: const SizedBox.shrink(),
    );

  factory StateWrapperWidget.success({required Widget child}) => StateWrapperWidget(state: ViewState.success, child: child);
  final ViewState state;
  final Widget child;
  final String? loadingMessage;
  final ErrorType? errorType;
  final String? errorTitle;
  final String? errorMessage;
  final VoidCallback? onRetry;
  final EmptyStateType? emptyType;
  final String? emptyTitle;
  final String? emptyMessage;
  final VoidCallback? onEmptyAction;
  final String? emptyActionText;

  @override
  Widget build(BuildContext context) {
    switch (state) {
      case ViewState.loading:
        return EnhancedLoadingWidget(message: loadingMessage);

      case ViewState.error:
        return EnhancedErrorWidget(
          errorType: errorType ?? ErrorType.general,
          title: errorTitle,
          message: errorMessage,
          onRetry: onRetry,
        );

      case ViewState.empty:
        return EnhancedEmptyWidget(
          emptyType: emptyType ?? EmptyStateType.general,
          title: emptyTitle,
          message: emptyMessage,
          onAction: onEmptyAction,
          actionButtonText: emptyActionText,
        );

      case ViewState.success:
        return child;
    }
  }
}

// Helper extension for easy state management
extension StateWrapperExtension on Widget {
  Widget wrapWithState(ViewState state) => StateWrapperWidget(state: state, child: this);

  Widget wrapWithLoading({String? message}) => StateWrapperWidget.loading(message: message);

  Widget wrapWithError({
    ErrorType? errorType,
    String? title,
    String? message,
    VoidCallback? onRetry,
  }) => StateWrapperWidget.error(
      errorType: errorType,
      title: title,
      message: message,
      onRetry: onRetry,
    );

  Widget wrapWithEmpty({
    EmptyStateType? emptyType,
    String? title,
    String? message,
    VoidCallback? onAction,
    String? actionText,
  }) => StateWrapperWidget.empty(
      emptyType: emptyType,
      title: title,
      message: message,
      onAction: onAction,
      actionText: actionText,
    );
}
