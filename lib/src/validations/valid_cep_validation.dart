part of 'validations.dart';

extension ValidCEPValidation on SimpleValidationBuilder<String> {
  /// Adds a validation rule that checks if the [String] is a valid CEP (Brazilian postal code).
  ///
  /// This method verifies that the CEP is in the correct format (#####-###) and consists
  /// of only numbers.
  ///
  /// [message] is the error message returned if the validation fails. Defaults to "Invalid CEP".
  /// [code] is an optional error code for translation purposes.
  ///
  /// Returns the [LucidValidationBuilder] to allow for method chaining.
  ///
  /// Example:
  /// ```dart
  /// ...
  /// ruleFor((user) => user.cep, key: 'cep')
  ///  .validCEP();
  /// ```
  ///
  /// String format args:
  /// - **{PropertyName}**: The name of the property.
  ///
  SimpleValidationBuilder<String> validCEP({String? message, String? code}) {
    return use((value, entity) {
      if (RegExp(r'^\d{5}-?\d{3}$').hasMatch(value)) return null;

      final currentCode = code ?? Language.code.validCEP;
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
    });
  }
}

extension ValidCEPNullableValidation on SimpleValidationBuilder<String?> {
  /// Adds a validation rule that checks if the [String?] is a valid CEP (Brazilian postal code).
  ///
  /// This method verifies that the CEP is in the correct format (#####-###) and consists
  /// of only numbers.
  ///
  /// [message] is the error message returned if the validation fails. Defaults to "Invalid CEP".
  /// [code] is an optional error code for translation purposes.
  ///
  /// Returns the [LucidValidationBuilder] to allow for method chaining.
  ///
  /// Example:
  /// ```dart
  /// ...
  /// ruleFor((user) => user.cep, key: 'cep') // user.cep is nullable
  ///  .validCEP();
  /// ```
  ///
  /// String format args:
  /// - **{PropertyName}**: The name of the property.
  ///
  SimpleValidationBuilder<String?> validCEP({String? message, String? code}) {
    return use((value, entity) {
      if (value != null && RegExp(r'^\d{5}-?\d{3}$').hasMatch(value)) {
        return null;
      }

      final currentCode = code ?? Language.code.validCEP;
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
    });
  }
}

extension ValidCEPOrNullableValidation on SimpleValidationBuilder<String?> {
  /// Adds a validation rule that checks if the [String?] is a valid CEP (Brazilian postal code) or [null].
  ///
  /// This method verifies that the CEP is in the correct format (#####-###) and consists
  /// of only numbers.
  ///
  /// [message] is the error message returned if the validation fails. Defaults to "Invalid CEP".
  /// [code] is an optional error code for translation purposes.
  ///
  /// Returns the [LucidValidationBuilder] to allow for method chaining.
  ///
  /// Example:
  /// ```dart
  /// ...
  /// ruleFor((user) => user.cep, key: 'cep')
  ///  .validCEPOrNull();
  /// ```
  ///
  /// String format args:
  /// - **{PropertyName}**: The name of the property.
  ///
  SimpleValidationBuilder<String?> validCEPOrNull(
      {String? message, String? code}) {
    return use((value, entity) {
      if (value == null) return null;
      if (RegExp(r'^\d{5}-?\d{3}$').hasMatch(value)) return null;

      final currentCode = code ?? Language.code.validCEP;
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
    });
  }
}
