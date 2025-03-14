part of 'validations.dart';

/// Extension on [LucidValidationBuilder] for [String] properties to add a not empty validation.
///
/// This extension adds a `notEmpty` method that can be used to ensure that a string
/// is not empty.
extension NotEmptyValidation on SimpleValidationBuilder<String> {
  /// Adds a validation rule that checks if the [String] is not empty.
  ///
  /// [message] is the error message returned if the validation fails. Defaults to "Cannot be empty".
  /// [code] is an optional error code for translation purposes.
  ///
  /// Returns the [LucidValidationBuilder] to allow for method chaining.
  ///
  /// Example:
  /// ```dart
  /// ...
  /// ruleFor((user) => user.username, key: 'username')
  ///   .notEmpty();
  /// ```
  ///
  /// String format args:
  /// - **{PropertyName}**: The name of the property.
  ///
  SimpleValidationBuilder<String> notEmpty({String? message, String? code}) {
    return use(
      (value, entity) {
        if (value.isNotEmpty) return null;

        final currentCode = code ?? Language.code.notEmpty;
        final currentMessage = LucidValidation.global.languageManager.translate(
          currentCode,
          parameters: {
            'PropertyName': label.isNotEmpty ? label : key,
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

extension NotEmptyNullableValidation on SimpleValidationBuilder<String?> {
  /// Adds a validation rule that checks if the [String?] is not empty.
  ///
  /// [message] is the error message returned if the validation fails. Defaults to "Cannot be empty".
  /// [code] is an optional error code for translation purposes.
  ///
  /// Returns the [LucidValidationBuilder] to allow for method chaining.
  ///
  /// Example:
  /// ```dart
  /// ...
  /// ruleFor((user) => user.username, key: 'username') // user.username is nullable
  ///   .notEmpty();
  /// ```
  ///
  /// String format args:
  /// - **{PropertyName}**: The name of the property.
  ///
  SimpleValidationBuilder<String?> notEmpty({String? message, String? code}) {
    return use(
      (value, entity) {
        if (value != null && value.isNotEmpty) return null;

        final currentCode = code ?? Language.code.notEmpty;
        final currentMessage = LucidValidation.global.languageManager.translate(
          currentCode,
          parameters: {
            'PropertyName': label.isNotEmpty ? label : key,
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

extension NotEmptyOrNullableValidation on SimpleValidationBuilder<String?> {
  /// Adds a validation rule that checks if the [String?] is not empty or [null].
  ///
  /// [message] is the error message returned if the validation fails. Defaults to "Cannot be empty".
  /// [code] is an optional error code for translation purposes.
  ///
  /// Returns the [LucidValidationBuilder] to allow for method chaining.
  ///
  /// Example:
  /// ```dart
  /// ...
  /// ruleFor((user) => user.username, key: 'username') /// user.name is nullable
  ///   .notEmptyOrNull();
  /// ```
  ///
  /// String format args:
  /// - **{PropertyName}**: The name of the property.
  ///
  SimpleValidationBuilder<String?> notEmptyOrNull(
      {String? message, String? code}) {
    return use(
      (value, entity) {
        if (value == null || value.isNotEmpty) return null;

        final currentCode = code ?? Language.code.notEmpty;
        final currentMessage = LucidValidation.global.languageManager.translate(
          currentCode,
          parameters: {
            'PropertyName': label.isNotEmpty ? label : key,
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
