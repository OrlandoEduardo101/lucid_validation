part of 'validations.dart';

/// Extension on [LucidValidationBuilder] for [num] properties to add a minimum value validation.
///
/// This extension adds a `min` method that can be used to ensure that a numerical value
/// meets or exceeds a specified minimum.
extension MinValidation on SimpleValidationBuilder<num> {
  /// Adds a validation rule that checks if a [num] value is greater than or equal to [num].
  ///
  /// [num] is the minimum allowed value.
  /// [message] is the error message returned if the validation fails. Defaults to "Must be greater than or equal to $num".
  /// [code] is an optional error code for translation purposes.
  ///
  /// Returns the [LucidValidationBuilder] to allow for method chaining.
  ///
  /// Example:
  /// ```dart
  /// ...
  /// ruleFor((user) => user.age, key: 'age')
  ///   .maxLength(18);
  /// ```
  ///
  /// String format args:
  /// - **{PropertyName}**: The name of the property.
  /// - **{MinValue}**: The minimum value.
  /// - **{PropertyValue}**: value entered.
  ///
  SimpleValidationBuilder<num> min(num num, {String? message, String? code}) {
    return use(
      (value, entity) {
        if (value >= num) return null;

        final currentCode = code ?? Language.code.min;
        final currentMessage = LucidValidation.global.languageManager.translate(
          currentCode,
          parameters: {
            'PropertyName': label.isNotEmpty ? label : key,
            'MinValue': '$num',
            'PropertyValue': '$value',
          },
          defaultMessage: message,
        );

        return ValidationException(
          message: currentMessage,
          code: currentCode,
          key: key,
        );
      },
    );
  }
}

extension MinNullableValidation on SimpleValidationBuilder<num?> {
  /// Adds a validation rule that checks if a [num?] value is greater than or equal to [num].
  ///
  /// [num] is the minimum allowed value.
  /// [message] is the error message returned if the validation fails. Defaults to "Must be greater than or equal to $num".
  /// [code] is an optional error code for translation purposes.
  ///
  /// Returns the [LucidValidationBuilder] to allow for method chaining.
  ///
  /// Example:
  /// ```dart
  /// ...
  /// ruleFor((user) => user.age, key: 'age')
  ///   .maxLength(18);
  /// ```
  ///
  /// String format args:
  /// - **{PropertyName}**: The name of the property.
  /// - **{MinValue}**: The minimum value.
  /// - **{PropertyValue}**: value entered.
  ///
  SimpleValidationBuilder<num?> min(num num, {String? message, String? code}) {
    return use(
      (value, entity) {
        if (value != null && value >= num) return null;

        final currentCode = code ?? Language.code.min;
        final currentMessage = LucidValidation.global.languageManager.translate(
          currentCode,
          parameters: {
            'PropertyName': label.isNotEmpty ? label : key,
            'MinValue': '$num',
            'PropertyValue': '$value',
          },
          defaultMessage: message,
        );

        return ValidationException(
          message: currentMessage,
          code: currentCode,
          key: key,
        );
      },
    );
  }
}

extension MinOrNullableValidation on SimpleValidationBuilder<num?> {
  /// Adds a validation rule that checks if a [num?] value is greater than or equal to [num] or [null].
  ///
  /// [num] is the minimum allowed value.
  /// [message] is the error message returned if the validation fails. Defaults to "Must be greater than or equal to $num".
  /// [code] is an optional error code for translation purposes.
  ///
  /// Returns the [LucidValidationBuilder] to allow for method chaining.
  ///
  /// Example:
  /// ```dart
  /// ...
  /// ruleFor((user) => user.age, key: 'age')
  ///   .minOrNull(18);
  /// ```
  ///
  /// String format args:
  /// - **{PropertyName}**: The name of the property.
  /// - **{MinValue}**: The minimum value.
  /// - **{PropertyValue}**: value entered.
  ///
  SimpleValidationBuilder<num?> minOrNull(num num,
      {String? message, String? code}) {
    return use(
      (value, entity) {
        if (value == null || value >= num) return null;

        final currentCode = code ?? Language.code.min;
        final currentMessage = LucidValidation.global.languageManager.translate(
          currentCode,
          parameters: {
            'PropertyName': label.isNotEmpty ? label : key,
            'MinValue': '$num',
            'PropertyValue': '$value',
          },
          defaultMessage: message,
        );

        return ValidationException(
          message: currentMessage,
          code: currentCode,
          key: key,
        );
      },
    );
  }
}
