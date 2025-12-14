import 'package:easy_localization/easy_localization.dart';
import 'package:sama_taxi/core/localization/app_strings.dart';

/// Comprehensive validation helper functions
///
/// This class provides static methods for common validation scenarios
/// with localized error messages and customizable validation rules.
class ValidationHelpers {
  ValidationHelpers._(); // Private constructor to prevent instantiation

  // ============================================================================
  // EMAIL VALIDATION
  // ============================================================================

  /// Validates email format
  static String? validateEmail(String? value, {String? customErrorMessage}) {
    if (value == null || value.isEmpty) {
      return customErrorMessage ?? AppStrings.emailRequired.tr();
    }

    // Comprehensive email regex pattern
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9.!#$%&*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$',
    );

    if (!emailRegex.hasMatch(value.trim())) {
      return customErrorMessage ?? AppStrings.emailInvalid.tr();
    }

    return null;
  }

  /// Validates email with additional domain checks
  static String? validateEmailWithDomain(
    String? value, {
    List<String>? allowedDomains,
    List<String>? blockedDomains,
    String? customErrorMessage,
  }) {
    final basicValidation = validateEmail(
      value,
      customErrorMessage: customErrorMessage,
    );
    if (basicValidation != null) return basicValidation;

    final email = value!.trim().toLowerCase();
    final domain = email.split('@').last;

    if (allowedDomains != null && !allowedDomains.contains(domain)) {
      return 'Email domain not allowed';
    }

    if (blockedDomains != null && blockedDomains.contains(domain)) {
      return 'Email domain is blocked';
    }

    return null;
  }

  // ============================================================================
  // PASSWORD VALIDATION
  // ============================================================================

  /// Validates password with customizable requirements
  static String? validatePassword(
    String? value, {
    int minLength = 8,
    int maxLength = 128,
    bool requireUppercase = true,
    bool requireLowercase = true,
    bool requireNumbers = true,
    bool requireSpecialChars = true,
    String? customErrorMessage,
  }) {
    if (value == null || value.isEmpty) {
      return customErrorMessage ?? AppStrings.passwordRequired.tr();
    }

    if (value.length < minLength) {
      return customErrorMessage ??
          'Password must be at least $minLength characters';
    }

    if (value.length > maxLength) {
      return customErrorMessage ??
          'Password must be less than $maxLength characters';
    }

    if (requireUppercase && !value.contains(RegExp('[A-Z]'))) {
      return customErrorMessage ??
          'Password must contain at least one uppercase letter';
    }

    if (requireLowercase && !value.contains(RegExp('[a-z]'))) {
      return customErrorMessage ??
          'Password must contain at least one lowercase letter';
    }

    if (requireNumbers && !value.contains(RegExp('[0-9]'))) {
      return customErrorMessage ?? 'Password must contain at least one number';
    }

    if (requireSpecialChars &&
        !value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return customErrorMessage ??
          'Password must contain at least one special character';
    }

    return null;
  }

  /// Validates password confirmation
  static String? validatePasswordConfirmation(
    String? value,
    String? originalPassword, {
    String? customErrorMessage,
  }) {
    if (value == null || value.isEmpty) {
      return customErrorMessage ?? 'Please confirm your password';
    }

    if (value != originalPassword) {
      return customErrorMessage ?? 'Passwords do not match';
    }

    return null;
  }

  /// Gets password strength score (0-4)
  static int getPasswordStrength(String password) {
    var score = 0;

    if (password.length >= 8) score++;
    if (password.contains(RegExp('[A-Z]'))) score++;
    if (password.contains(RegExp('[a-z]'))) score++;
    if (password.contains(RegExp('[0-9]'))) score++;
    if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) score++;

    return score > 4 ? 4 : score;
  }

  /// Gets password strength description
  static String getPasswordStrengthText(String password) {
    final strength = getPasswordStrength(password);
    switch (strength) {
      case 0:
      case 1:
        return 'Very Weak';
      case 2:
        return 'Weak';
      case 3:
        return 'Medium';
      case 4:
        return 'Strong';
      default:
        return 'Very Strong';
    }
  }

  // ============================================================================
  // NAME VALIDATION
  // ============================================================================

  /// Validates full name
  static String? validateName(
    String? value, {
    int minLength = 2,
    int maxLength = 50,
    bool allowNumbers = false,
    bool allowSpecialChars = false,
    String? customErrorMessage,
  }) {
    if (value == null || value.isEmpty) {
      return customErrorMessage ?? 'Name is required';
    }

    final trimmedValue = value.trim();

    if (trimmedValue.length < minLength) {
      return customErrorMessage ??
          'Name must be at least $minLength characters';
    }

    if (trimmedValue.length > maxLength) {
      return customErrorMessage ??
          'Name must be less than $maxLength characters';
    }

    if (!allowNumbers && trimmedValue.contains(RegExp('[0-9]'))) {
      return customErrorMessage ?? 'Name cannot contain numbers';
    }

    if (!allowSpecialChars &&
        trimmedValue.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return customErrorMessage ?? 'Name cannot contain special characters';
    }

    // Check for valid name pattern (letters, spaces, hyphens, apostrophes)
    if (!RegExp(r"^[a-zA-Z\s\-']+$").hasMatch(trimmedValue)) {
      return customErrorMessage ?? 'Please enter a valid name';
    }

    return null;
  }

  /// Validates first name
  static String? validateFirstName(
    String? value, {
    String? customErrorMessage,
  }) => validateName(
      value,
      maxLength: 30,
      customErrorMessage:
          customErrorMessage ?? 'Please enter a valid first name',
    );

  /// Validates last name
  static String? validateLastName(String? value, {String? customErrorMessage}) => validateName(
      value,
      maxLength: 30,
      customErrorMessage:
          customErrorMessage ?? 'Please enter a valid last name',
    );

  // ============================================================================
  // PHONE VALIDATION
  // ============================================================================

  /// Validates phone number
  static String? validatePhoneNumber(
    String? value, {
    String? countryCode,
    bool requireCountryCode = false,
    String? customErrorMessage,
  }) {
    if (value == null || value.isEmpty) {
      return customErrorMessage ?? 'Phone number is required';
    }

    // Remove all non-digit characters except +
    final cleanedValue = value.replaceAll(RegExp(r'[^\d+]'), '');

    if (requireCountryCode && !cleanedValue.startsWith('+')) {
      return customErrorMessage ?? 'Phone number must include country code';
    }

    // Basic phone number validation (7-15 digits)
    final phoneRegex = RegExp(r'^\+?[1-9]\d{6,14}$');
    if (!phoneRegex.hasMatch(cleanedValue)) {
      return customErrorMessage ?? 'Please enter a valid phone number';
    }

    return null;
  }

  // ============================================================================
  // NUMERIC VALIDATION
  // ============================================================================

  /// Validates numeric input
  static String? validateNumber(
    String? value, {
    double? min,
    double? max,
    bool allowDecimals = true,
    bool allowNegative = true,
    String? customErrorMessage,
  }) {
    if (value == null || value.isEmpty) {
      return customErrorMessage ?? 'This field is required';
    }

    final numericValue = double.tryParse(value);
    if (numericValue == null) {
      return customErrorMessage ?? 'Please enter a valid number';
    }

    if (!allowDecimals && numericValue != numericValue.roundToDouble()) {
      return customErrorMessage ?? 'Decimal numbers are not allowed';
    }

    if (!allowNegative && numericValue < 0) {
      return customErrorMessage ?? 'Negative numbers are not allowed';
    }

    if (min != null && numericValue < min) {
      return customErrorMessage ?? 'Value must be at least $min';
    }

    if (max != null && numericValue > max) {
      return customErrorMessage ?? 'Value must be at most $max';
    }

    return null;
  }

  /// Validates integer input
  static String? validateInteger(
    String? value, {
    int? min,
    int? max,
    bool allowNegative = true,
    String? customErrorMessage,
  }) {
    if (value == null || value.isEmpty) {
      return customErrorMessage ?? 'This field is required';
    }

    final intValue = int.tryParse(value);
    if (intValue == null) {
      return customErrorMessage ?? 'Please enter a valid integer';
    }

    if (!allowNegative && intValue < 0) {
      return customErrorMessage ?? 'Negative numbers are not allowed';
    }

    if (min != null && intValue < min) {
      return customErrorMessage ?? 'Value must be at least $min';
    }

    if (max != null && intValue > max) {
      return customErrorMessage ?? 'Value must be at most $max';
    }

    return null;
  }

  // ============================================================================
  // TEXT VALIDATION
  // ============================================================================

  /// Validates required text field
  static String? validateRequired(String? value, {String? customErrorMessage}) {
    if (value == null || value.trim().isEmpty) {
      return customErrorMessage ?? 'This field is required';
    }
    return null;
  }

  /// Validates text length
  static String? validateLength(
    String? value, {
    int? minLength,
    int? maxLength,
    String? customErrorMessage,
  }) {
    if (value == null) return null;

    final trimmedValue = value.trim();

    if (minLength != null && trimmedValue.length < minLength) {
      return customErrorMessage ?? 'Must be at least $minLength characters';
    }

    if (maxLength != null && trimmedValue.length > maxLength) {
      return customErrorMessage ?? 'Must be less than $maxLength characters';
    }

    return null;
  }

  /// Validates URL format
  static String? validateUrl(String? value, {String? customErrorMessage}) {
    if (value == null || value.isEmpty) {
      return customErrorMessage ?? 'URL is required';
    }

    final urlRegex = RegExp(
      r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$',
    );

    if (!urlRegex.hasMatch(value.trim())) {
      return customErrorMessage ?? 'Please enter a valid URL';
    }

    return null;
  }

  // ============================================================================
  // DATE VALIDATION
  // ============================================================================

  /// Validates date format and range
  static String? validateDate(
    String? value, {
    DateTime? minDate,
    DateTime? maxDate,
    String dateFormat = 'yyyy-MM-dd',
    String? customErrorMessage,
  }) {
    if (value == null || value.isEmpty) {
      return customErrorMessage ?? 'Date is required';
    }

    try {
      final date = DateFormat(dateFormat).parse(value);

      if (minDate != null && date.isBefore(minDate)) {
        return customErrorMessage ??
            'Date must be after ${DateFormat(dateFormat).format(minDate)}';
      }

      if (maxDate != null && date.isAfter(maxDate)) {
        return customErrorMessage ??
            'Date must be before ${DateFormat(dateFormat).format(maxDate)}';
      }

      return null;
    } catch (e) {
      return customErrorMessage ?? 'Please enter a valid date';
    }
  }

  /// Validates age based on birth date
  static String? validateAge(
    DateTime? birthDate, {
    int? minAge,
    int? maxAge,
    String? customErrorMessage,
  }) {
    if (birthDate == null) {
      return customErrorMessage ?? 'Birth date is required';
    }

    final now = DateTime.now();
    final age = now.year - birthDate.year;
    final hasHadBirthdayThisYear =
        now.month > birthDate.month ||
        (now.month == birthDate.month && now.day >= birthDate.day);

    final actualAge = hasHadBirthdayThisYear ? age : age - 1;

    if (minAge != null && actualAge < minAge) {
      return customErrorMessage ?? 'Must be at least $minAge years old';
    }

    if (maxAge != null && actualAge > maxAge) {
      return customErrorMessage ?? 'Must be less than $maxAge years old';
    }

    return null;
  }

  // ============================================================================
  // COMPOSITE VALIDATORS
  // ============================================================================

  /// Combines multiple validators
  static String? Function(String?) combineValidators(
    List<String? Function(String?)> validators,
  ) => (value) {
      for (final validator in validators) {
        final result = validator(value);
        if (result != null) return result;
      }
      return null;
    };

  /// Creates a conditional validator
  static String? Function(String?) conditionalValidator(
    bool Function() condition,
    String? Function(String?) validator,
  ) => (value) {
      if (condition()) {
        return validator(value);
      }
      return null;
    };
}
