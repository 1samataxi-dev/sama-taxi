// Usage Examples for Utility Helpers
// This file demonstrates how to use the various utility helpers

import 'package:flutter/material.dart';
import 'package:sama_taxi/core/utils/index.dart';

class UtilityUsageExamples {
  // ============================================================================
  // UI HELPERS EXAMPLES
  // ============================================================================

  static void showSnackBarExamples(BuildContext context) {
    // Success snackbar
    UIHelpers.showSuccessSnackBar(context, 'Operation completed successfully!');

    // Error snackbar
    UIHelpers.showErrorSnackBar(context, 'Something went wrong!');

    // Warning snackbar
    UIHelpers.showWarningSnackBar(context, 'Please check your input');

    // Info snackbar
    UIHelpers.showInfoSnackBar(context, 'New update available');

    // Custom snackbar
    UIHelpers.showCustomSnackBar(
      context,
      message: 'Custom message',
      backgroundColor: Colors.purple,
      icon: Icons.star,
      duration: const Duration(seconds: 5),
    );
  }

  static Future<void> showDialogExamples(BuildContext context) async {
    // Confirmation dialog
    final confirmed = await UIHelpers.showConfirmationDialog(
      context,
      title: 'Delete Item',
      message: 'Are you sure you want to delete this item?',
      confirmText: 'Delete',
      icon: Icons.delete,
    );

    if (confirmed ?? false) {
      UIHelpers.showSuccessSnackBar(context, 'Item deleted');
    }

    // Alert dialog
    await UIHelpers.showAlertDialog(
      context,
      title: 'Information',
      message: 'This is an informational message',
      icon: Icons.info,
    );

    // Loading dialog
    UIHelpers.showLoadingDialog(context, message: 'Processing...');

    // Simulate work
    await Future.delayed(const Duration(seconds: 2));

    // Hide loading dialog
    UIHelpers.hideLoadingDialog(context);
  }

  static void utilityExamples(BuildContext context) {
    // Haptic feedback
    UIHelpers.hapticFeedback(type: HapticFeedbackType.medium);

    // Copy to clipboard
    UIHelpers.copyToClipboard(context, 'Hello World!');

    // Hide keyboard
    UIHelpers.hideKeyboard();

    // Unfocus
    UIHelpers.unfocus(context);
  }

  // ============================================================================
  // VALIDATION HELPERS EXAMPLES
  // ============================================================================

  static void validationExamples() {
    // Email validation
    final emailError = ValidationHelpers.validateEmail('test@example.com');
    print('Email validation: $emailError'); // null (valid)

    // Password validation
    final passwordError = ValidationHelpers.validatePassword(
      'MyPassword123!',
    );
    print('Password validation: $passwordError'); // null (valid)

    // Password strength
    final strength = ValidationHelpers.getPasswordStrength('MyPassword123!');
    final strengthText = ValidationHelpers.getPasswordStrengthText(
      'MyPassword123!',
    );
    print('Password strength: $strength ($strengthText)');

    // Name validation
    final nameError = ValidationHelpers.validateName('John Doe');
    print('Name validation: $nameError'); // null (valid)

    // Phone validation
    final phoneError = ValidationHelpers.validatePhoneNumber('+1234567890');
    print('Phone validation: $phoneError'); // null (valid)

    // Number validation
    final numberError = ValidationHelpers.validateNumber(
      '123.45',
      min: 0,
      max: 1000,
    );
    print('Number validation: $numberError'); // null (valid)

    // Combine validators
    final combinedValidator = ValidationHelpers.combineValidators([
      ValidationHelpers.validateRequired,
      (value) => ValidationHelpers.validateLength(value, minLength: 5),
    ]);

    final combinedError = combinedValidator('test');
    print('Combined validation: $combinedError'); // Error (too short)
  }

  // ============================================================================
  // DIALOG HELPERS EXAMPLES
  // ============================================================================

  static Future<void> dialogExamples(BuildContext context) async {
    // Delete confirmation
    final deleteConfirmed = await DialogHelpers.showDeleteConfirmation(
      context,
      itemName: 'My Document',
    );

    if (deleteConfirmed ?? false) {
      UIHelpers.showSuccessSnackBar(context, 'Document deleted');
    }

    // Logout confirmation
    final logoutConfirmed = await DialogHelpers.showLogoutConfirmation(context);

    if (logoutConfirmed ?? false) {
      // Handle logout
    }

    // Single selection dialog
    final selectedItem = await DialogHelpers.showSingleSelectionDialog<String>(
      context,
      title: 'Select Option',
      items: [
        const SelectionItem(
          value: 'option1',
          label: 'Option 1',
          icon: Icons.star,
        ),
        const SelectionItem(
          value: 'option2',
          label: 'Option 2',
          icon: Icons.favorite,
        ),
        const SelectionItem(
          value: 'option3',
          label: 'Option 3',
          icon: Icons.thumb_up,
        ),
      ],
      showSearch: true,
    );

    if (selectedItem != null) {
      UIHelpers.showInfoSnackBar(context, 'Selected: $selectedItem');
    }

    // Multi selection dialog
    final selectedItems = await DialogHelpers.showMultiSelectionDialog<String>(
      context,
      title: 'Select Multiple',
      items: [
        const SelectionItem(value: 'item1', label: 'Item 1'),
        const SelectionItem(value: 'item2', label: 'Item 2'),
        const SelectionItem(value: 'item3', label: 'Item 3'),
      ],
      selectedValues: ['item1'],
    );

    if (selectedItems != null) {
      UIHelpers.showInfoSnackBar(
        context,
        'Selected: ${selectedItems.join(', ')}',
      );
    }

    // Text input dialog
    final inputText = await DialogHelpers.showTextInputDialog(
      context,
      title: 'Enter Name',
      hintText: 'Your name',
      validator: ValidationHelpers.validateRequired,
    );

    if (inputText != null) {
      UIHelpers.showSuccessSnackBar(context, 'Hello, $inputText!');
    }
  }

  // ============================================================================
  // DATE HELPERS EXAMPLES
  // ============================================================================

  static void dateExamples() {
    final now = DateTime.now();
    final birthDate = DateTime(1990, 5, 15);

    // Formatting
    final formattedDate = DateHelpers.formatDate(now);
    print('Formatted date: $formattedDate');

    final relativeTime = DateHelpers.formatRelativeTime(birthDate);
    print('Relative time: $relativeTime');

    // Calculations
    final futureDate = DateHelpers.addDays(now, 30);
    print('30 days from now: $futureDate');

    final daysBetween = DateHelpers.daysBetween(birthDate, now);
    print('Days since birth: $daysBetween');

    // Age calculation
    final age = DateHelpers.calculateAge(birthDate);
    final detailedAge = DateHelpers.calculateDetailedAge(birthDate);
    print('Age: $age years');
    print('Detailed age: $detailedAge');

    // Utilities
    final isToday = DateHelpers.isToday(now);
    final isWeekend = DateHelpers.isWeekend(now);
    final isLeapYear = DateHelpers.isLeapYear(now.year);

    print('Is today: $isToday');
    print('Is weekend: $isWeekend');
    print('Is leap year: $isLeapYear');

    // Business days
    final businessDate = DateHelpers.addBusinessDays(now, 5);
    final businessDays = DateHelpers.businessDaysBetween(now, businessDate);
    print('5 business days from now: $businessDate');
    print('Business days between: $businessDays');
  }

  // ============================================================================
  // FORMAT HELPERS EXAMPLES
  // ============================================================================

  static void formatExamples() {
    // Number formatting
    final formattedNumber = FormatHelpers.formatNumber(1234567.89);
    print('Formatted number: $formattedNumber'); // 1,234,567.89

    final percentage = FormatHelpers.formatPercentage(0.1234);
    print('Percentage: $percentage'); // 12.3%

    final compactNumber = FormatHelpers.formatCompactNumber(1234567);
    print('Compact number: $compactNumber'); // 1.2M

    final ordinal = FormatHelpers.formatOrdinal(21);
    print('Ordinal: $ordinal'); // 21st

    // Currency formatting
    final currency = FormatHelpers.formatCurrency(1234.56);
    print('Currency: $currency'); // $1,234.56

    final compactCurrency = FormatHelpers.formatCompactCurrency(1234567.89);
    print('Compact currency: $compactCurrency'); // $1.2M

    // File size formatting
    final fileSize = FormatHelpers.formatFileSize(1024 * 1024 * 5);
    print('File size: $fileSize'); // 5.0 MB

    // Duration formatting
    const duration = Duration(hours: 2, minutes: 30, seconds: 45);
    final formattedDuration = FormatHelpers.formatDuration(duration);
    final timeFormat = FormatHelpers.formatDurationAsTime(duration);
    print('Duration: $formattedDuration'); // 2 hours, 30 minutes, 45 seconds
    print('Time format: $timeFormat'); // 02:30:45

    // Text formatting
    final titleCase = FormatHelpers.toTitleCase('hello world');
    final camelCase = FormatHelpers.toCamelCase('hello world');
    final snakeCase = FormatHelpers.toSnakeCase('Hello World');
    final truncated = FormatHelpers.truncate('This is a long text', 10);

    print('Title case: $titleCase'); // Hello World
    print('Camel case: $camelCase'); // helloWorld
    print('Snake case: $snakeCase'); // hello_world
    print('Truncated: $truncated'); // This is...

    // Phone formatting
    final phone = FormatHelpers.formatPhoneNumber('1234567890');
    print('Formatted phone: $phone'); // (123) 456-7890

    // Credit card formatting
    final creditCard = FormatHelpers.formatCreditCard('1234567890123456');
    final maskedCard = FormatHelpers.maskCreditCard('1234567890123456');
    print('Credit card: $creditCard'); // 1234 5678 9012 3456
    print('Masked card: $maskedCard'); // **** **** **** 3456

    // List formatting
    final items = <String>['Apple', 'Banana', 'Cherry'];
    final listWithAnd = FormatHelpers.formatListWithAnd(items);
    final listWithOr = FormatHelpers.formatListWithOr(items);
    print('List with and: $listWithAnd'); // Apple, Banana and Cherry
    print('List with or: $listWithOr'); // Apple, Banana or Cherry
  }

  // ============================================================================
  // COMPLETE FORM EXAMPLE
  // ============================================================================

  static Widget buildExampleForm() => Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Email field with validation
          TextFormField(
            decoration: const InputDecoration(labelText: 'Email'),
            validator: ValidationHelpers.validateEmail,
            keyboardType: TextInputType.emailAddress,
          ),

          const SizedBox(height: 16),

          // Password field with validation
          TextFormField(
            decoration: const InputDecoration(labelText: 'Password'),
            validator: ValidationHelpers.validatePassword,
            obscureText: true,
          ),

          const SizedBox(height: 16),

          // Name field with validation
          TextFormField(
            decoration: const InputDecoration(labelText: 'Full Name'),
            validator: ValidationHelpers.validateName,
          ),

          const SizedBox(height: 16),

          // Phone field with validation
          TextFormField(
            decoration: const InputDecoration(labelText: 'Phone Number'),
            validator: ValidationHelpers.validatePhoneNumber,
            keyboardType: TextInputType.phone,
          ),

          const SizedBox(height: 24),

          // Submit button
          ElevatedButton(
            onPressed: () {
              // Form submission logic here
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
}
