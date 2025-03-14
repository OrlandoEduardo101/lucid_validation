part of 'validations.dart';

/// Extension on [LucidValidationBuilder] for [DateTime] properties to add a greater than validation.
///
/// This extension adds a `greaterThanOrEqualTo` method that can be used to ensure that
/// a date is greater than or equal to a specified date.
extension GreaterThanOrEqualToDateTimeValidation
    on SimpleValidationBuilder<DateTime> {
  /// Adds a validation rule that checks if the [DateTime] is greater than [comparison].
  ///
  /// [comparison] is the date and time value must be greater than or equal.
  /// [message] is the error message returned if the validation fails.
  /// [code] is an optional error code for translation purposes.
  ///
  /// Returns the [LucidValidationBuilder] to allow for method chaining.
  ///
  /// Example:
  /// ```dart
  /// ...
  /// .ruleFor((event) => event.start, key: 'start') //
  ///   .greaterThanOrEqualTo(DateTime.now());
  /// ```
  ///
  /// String format args:
  /// - **{PropertyName}**: The name of the property.
  /// - **{ComparisonValue}**: The value to compare against.
  ///
  SimpleValidationBuilder<DateTime> greaterThanOrEqualTo(
    DateTime comparison, {
    String? message,
    String? code,
  }) {
    return use((value, entity) {
      if (value.isAfter(comparison) || value.isAtSameMomentAs(comparison)) {
        return null;
      }

      final currentCode = code ?? Language.code.greaterThanOrEqualToDateTime;
      final currentMessage = LucidValidation.global.languageManager.translate(
        currentCode,
        parameters: {
          'PropertyName': label.isNotEmpty ? label : key,
          'ComparisonValue': comparison.toString(),
        },
        defaultMessage: message,
      );

      return ValidationException(
        message: currentMessage,
        code: currentCode,
        key: key,
      );
    });
  }
}

extension GreaterThanOrEqualToDateTimeNullableValidation
    on SimpleValidationBuilder<DateTime?> {
  /// Adds a validation rule that checks if the [DateTime?] is greater than [comparison].
  ///
  /// [comparison] is the date and time value must be greater than or equal.
  /// [message] is the error message returned if the validation fails.
  /// [code] is an optional error code for translation purposes.
  ///
  /// Returns the [LucidValidationBuilder] to allow for method chaining.
  ///
  /// Example:
  /// ```dart
  /// ...
  /// .ruleFor((event) => event.start, key: 'start') // event.start is nullable
  ///   .greaterThanOrEqualTo(DateTime.now());
  /// ```
  ///
  /// String format args:
  /// - **{PropertyName}**: The name of the property.
  /// - **{ComparisonValue}**: The value to compare against.
  ///
  SimpleValidationBuilder<DateTime?> greaterThanOrEqualTo(
    DateTime comparison, {
    String? message,
    String? code,
  }) {
    return use((value, entity) {
      if (value != null &&
          (value.isAfter(comparison) || value.isAtSameMomentAs(comparison))) {
        return null;
      }

      final currentCode = code ?? Language.code.greaterThanOrEqualToDateTime;
      final currentMessage = LucidValidation.global.languageManager.translate(
        currentCode,
        parameters: {
          'PropertyName': label.isNotEmpty ? label : key,
          'ComparisonValue': comparison.toString(),
        },
        defaultMessage: message,
      );

      return ValidationException(
        message: currentMessage,
        code: currentCode,
        key: key,
      );
    });
  }
}

extension GreaterThanOrEqualToDateTimeOrNullableValidation
    on SimpleValidationBuilder<DateTime?> {
  /// Adds a validation rule that checks if the [DateTime?] is greater than [comparison] or [null].
  ///
  /// [comparison] is the date and time value must be greater than or equal.
  /// [message] is the error message returned if the validation fails.
  /// [code] is an optional error code for translation purposes.
  ///
  /// Returns the [LucidValidationBuilder] to allow for method chaining.
  ///
  /// Example:
  /// ```dart
  /// ...
  /// .ruleFor((event) => event.start, key: 'start') //
  ///   .greaterThanOrEqualToOrNull(DateTime.now());
  /// ```
  ///
  /// String format args:
  /// - **{PropertyName}**: The name of the property.
  /// - **{ComparisonValue}**: The value to compare against.
  ///
  SimpleValidationBuilder<DateTime?> greaterThanOrEqualToOrNull(
    DateTime comparison, {
    String? message,
    String? code,
  }) {
    return use((value, entity) {
      if (value == null ||
          (value.isAfter(comparison) || value.isAtSameMomentAs(comparison))) {
        return null;
      }

      final currentCode = code ?? Language.code.greaterThanOrEqualToDateTime;
      final currentMessage = LucidValidation.global.languageManager.translate(
        currentCode,
        parameters: {
          'PropertyName': label.isNotEmpty ? label : key,
          'ComparisonValue': comparison.toString(),
        },
        defaultMessage: message,
      );

      return ValidationException(
        message: currentMessage,
        code: currentCode,
        key: key,
      );
    });
  }
}
