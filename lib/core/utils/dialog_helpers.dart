import 'package:flutter/material.dart';
import 'package:sama_taxi/core/widgets/index.dart';

/// Specialized dialog helper functions for common use cases
///
/// This class provides pre-built dialogs for common scenarios like
/// confirmations, selections, forms, and custom content with consistent styling.
class DialogHelpers {
  DialogHelpers._(); // Private constructor to prevent instantiation

  // ============================================================================
  // CONFIRMATION DIALOGS
  // ============================================================================

  /// Shows a delete confirmation dialog
  static Future<bool?> showDeleteConfirmation(
    BuildContext context, {
    required String itemName,
    String? customMessage,
    String confirmText = 'Delete',
    String cancelText = 'Cancel',
  }) => showDialog<bool>(
      context: context,
      builder: (context) => ScaleAnimation(
          begin: 0.8,
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: const Row(
              children: [
                Icon(Icons.delete_forever, color: Colors.red, size: 28),
                SizedBox(width: 12),
                Text(
                  'Delete Item',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            content: Text(
              customMessage ??
                  'Are you sure you want to delete "$itemName"? This action cannot be undone.',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(
                  cancelText,
                  style: TextStyle(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  confirmText,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
    );

  /// Shows a logout confirmation dialog
  static Future<bool?> showLogoutConfirmation(
    BuildContext context, {
    String? customMessage,
    String confirmText = 'Logout',
    String cancelText = 'Cancel',
  }) => showDialog<bool>(
      context: context,
      builder: (context) => ScaleAnimation(
          begin: 0.8,
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Row(
              children: [
                Icon(
                  Icons.logout,
                  color: Theme.of(context).primaryColor,
                  size: 28,
                ),
                const SizedBox(width: 12),
                const Text(
                  'Logout',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            content: Text(
              customMessage ?? 'Are you sure you want to logout?',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(
                  cancelText,
                  style: TextStyle(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  confirmText,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
    );

  // ============================================================================
  // SELECTION DIALOGS
  // ============================================================================

  /// Shows a single selection dialog
  static Future<T?> showSingleSelectionDialog<T>(
    BuildContext context, {
    required String title,
    required List<SelectionItem<T>> items,
    T? selectedValue,
    String? searchHint,
    bool showSearch = false,
  }) => showDialog<T>(
      context: context,
      builder: (context) => _SingleSelectionDialog<T>(
          title: title,
          items: items,
          selectedValue: selectedValue,
          searchHint: searchHint,
          showSearch: showSearch,
        ),
    );

  /// Shows a multi-selection dialog
  static Future<List<T>?> showMultiSelectionDialog<T>(
    BuildContext context, {
    required String title,
    required List<SelectionItem<T>> items,
    List<T>? selectedValues,
    String? searchHint,
    bool showSearch = false,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
  }) => showDialog<List<T>>(
      context: context,
      builder: (context) => _MultiSelectionDialog<T>(
          title: title,
          items: items,
          selectedValues: selectedValues ?? [],
          searchHint: searchHint,
          showSearch: showSearch,
          confirmText: confirmText,
          cancelText: cancelText,
        ),
    );

  // ============================================================================
  // INPUT DIALOGS
  // ============================================================================

  /// Shows a text input dialog
  static Future<String?> showTextInputDialog(
    BuildContext context, {
    required String title,
    String? message,
    String? hintText,
    String? initialValue,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
    TextInputType keyboardType = TextInputType.text,
    int? maxLength,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) => showDialog<String>(
      context: context,
      builder: (context) => _TextInputDialog(
          title: title,
          message: message,
          hintText: hintText,
          initialValue: initialValue,
          confirmText: confirmText,
          cancelText: cancelText,
          keyboardType: keyboardType,
          maxLength: maxLength,
          maxLines: maxLines,
          validator: validator,
        ),
    );

  // ============================================================================
  // CUSTOM DIALOGS
  // ============================================================================

  /// Shows a custom content dialog with animation
  static Future<T?> showAnimatedDialog<T>(
    BuildContext context, {
    required Widget content,
    String? title,
    List<Widget>? actions,
    bool barrierDismissible = true,
    Color? backgroundColor,
    EdgeInsetsGeometry? contentPadding,
    Duration animationDuration = const Duration(milliseconds: 300),
  }) => showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => ScaleAnimation(
          begin: 0.8,
          duration: animationDuration,
          child: AlertDialog(
            backgroundColor: backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: title != null
                ? Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  )
                : null,
            content: content,
            contentPadding: contentPadding ?? const EdgeInsets.all(24),
            actions: actions,
          ),
        ),
    );

  /// Shows a full-screen dialog
  static Future<T?> showFullScreenDialog<T>(
    BuildContext context, {
    required Widget content,
    String? title,
    List<Widget>? actions,
    bool showCloseButton = true,
  }) => Navigator.of(context).push<T>(
      PageRouteBuilder<T>(
        pageBuilder: (context, animation, secondaryAnimation) => FadeTransition(
            opacity: animation,
            child: Scaffold(
              appBar: AppBar(
                title: title != null ? Text(title) : null,
                leading: showCloseButton
                    ? IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.of(context).pop(),
                      )
                    : null,
                actions: actions,
              ),
              body: content,
            ),
          ),
      ),
    );
}

// ============================================================================
// HELPER CLASSES
// ============================================================================

/// Selection item for dialogs
class SelectionItem<T> {
  const SelectionItem({
    required this.value,
    required this.label,
    this.subtitle,
    this.icon,
    this.enabled = true,
  });

  final T value;
  final String label;
  final String? subtitle;
  final IconData? icon;
  final bool enabled;
}

// ============================================================================
// PRIVATE DIALOG WIDGETS
// ============================================================================

class _SingleSelectionDialog<T> extends StatefulWidget {
  const _SingleSelectionDialog({
    required this.title,
    required this.items,
    this.selectedValue,
    this.searchHint,
    this.showSearch = false,
  });

  final String title;
  final List<SelectionItem<T>> items;
  final T? selectedValue;
  final String? searchHint;
  final bool showSearch;

  @override
  State<_SingleSelectionDialog<T>> createState() =>
      _SingleSelectionDialogState<T>();
}

class _SingleSelectionDialogState<T> extends State<_SingleSelectionDialog<T>> {
  late List<SelectionItem<T>> filteredItems;
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredItems = widget.items;
    searchController.addListener(_filterItems);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _filterItems() {
    final query = searchController.text.toLowerCase();
    setState(() {
      filteredItems = widget.items
          .where((item) => item.label.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) => ScaleAnimation(
      begin: 0.8,
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          widget.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.showSearch) ...[
                TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: widget.searchHint ?? 'Search...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: filteredItems.length,
                  itemBuilder: (context, index) {
                    final item = filteredItems[index];
                    final isSelected = item.value == widget.selectedValue;

                    return ListTile(
                      leading: item.icon != null
                          ? Icon(item.icon)
                          : (isSelected
                                ? const Icon(Icons.check_circle)
                                : null),
                      title: Text(item.label),
                      subtitle: item.subtitle != null
                          ? Text(item.subtitle!)
                          : null,
                      enabled: item.enabled,
                      selected: isSelected,
                      onTap: item.enabled
                          ? () => Navigator.of(context).pop(item.value)
                          : null,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
}

class _MultiSelectionDialog<T> extends StatefulWidget {
  const _MultiSelectionDialog({
    required this.title,
    required this.items,
    required this.selectedValues,
    this.searchHint,
    this.showSearch = false,
    required this.confirmText,
    required this.cancelText,
  });

  final String title;
  final List<SelectionItem<T>> items;
  final List<T> selectedValues;
  final String? searchHint;
  final bool showSearch;
  final String confirmText;
  final String cancelText;

  @override
  State<_MultiSelectionDialog<T>> createState() =>
      _MultiSelectionDialogState<T>();
}

class _MultiSelectionDialogState<T> extends State<_MultiSelectionDialog<T>> {
  late List<SelectionItem<T>> filteredItems;
  late List<T> selectedValues;
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredItems = widget.items;
    selectedValues = List.from(widget.selectedValues);
    searchController.addListener(_filterItems);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _filterItems() {
    final query = searchController.text.toLowerCase();
    setState(() {
      filteredItems = widget.items
          .where((item) => item.label.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) => ScaleAnimation(
      begin: 0.8,
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          widget.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.showSearch) ...[
                TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: widget.searchHint ?? 'Search...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: filteredItems.length,
                  itemBuilder: (context, index) {
                    final item = filteredItems[index];
                    final isSelected = selectedValues.contains(item.value);

                    return CheckboxListTile(
                      secondary: item.icon != null ? Icon(item.icon) : null,
                      title: Text(item.label),
                      subtitle: item.subtitle != null
                          ? Text(item.subtitle!)
                          : null,
                      value: isSelected,
                      enabled: item.enabled,
                      onChanged: item.enabled
                          ? (value) {
                              setState(() {
                                if (value ?? false) {
                                  selectedValues.add(item.value);
                                } else {
                                  selectedValues.remove(item.value);
                                }
                              });
                            }
                          : null,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              widget.cancelText,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(selectedValues),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              widget.confirmText,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
}

class _TextInputDialog extends StatefulWidget {
  const _TextInputDialog({
    required this.title,
    this.message,
    this.hintText,
    this.initialValue,
    required this.confirmText,
    required this.cancelText,
    required this.keyboardType,
    this.maxLength,
    required this.maxLines,
    this.validator,
  });

  final String title;
  final String? message;
  final String? hintText;
  final String? initialValue;
  final String confirmText;
  final String cancelText;
  final TextInputType keyboardType;
  final int? maxLength;
  final int maxLines;
  final String? Function(String?)? validator;

  @override
  State<_TextInputDialog> createState() => _TextInputDialogState();
}

class _TextInputDialogState extends State<_TextInputDialog> {
  late TextEditingController controller;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ScaleAnimation(
      begin: 0.8,
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          widget.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.message != null) ...[
                Text(
                  widget.message!,
                  style: TextStyle(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withOpacity(0.8),
                  ),
                ),
                const SizedBox(height: 16),
              ],
              TextFormField(
                controller: controller,
                keyboardType: widget.keyboardType,
                maxLength: widget.maxLength,
                maxLines: widget.maxLines,
                validator: widget.validator,
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                autofocus: true,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              widget.cancelText,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                Navigator.of(context).pop(controller.text);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              widget.confirmText,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
}
