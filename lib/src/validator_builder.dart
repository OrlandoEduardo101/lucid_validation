part of 'lucid_validation.dart';

enum CascadeMode {
  continueExecution,
  stopOnFirstFailure,
}

/// Builder class used to define validation rules for a specific property type [TProp].
///
/// [TProp] represents the type of the property being validated.
typedef RuleFunc<TProp, Entity> = ValidatorResult Function(dynamic value, dynamic entity);

class LucidValidationBuilder<TProp, Entity> {
  final String key;
  final List<RuleFunc<TProp, Entity>> _rules = [];
  var _mode = CascadeMode.continueExecution;

  /// Creates a [LucidValidationBuilder] instance with an optional [key].
  ///
  /// The [key] can be used to identify this specific validation in a larger validation context.
  LucidValidationBuilder({this.key = ''});

  /// Registers a validation rule for the property.
  ///
  /// [validator] is a function that returns `true` if the property is valid and `false` otherwise.
  /// [message] is the error message returned when the validation fails.
  ///
  /// Returns this [LucidValidationBuilder] to allow for method chaining.
  ///
  /// Example:
  /// ```dart
  /// final builder = LucidValidationBuilder<String>(key: 'username');
  /// builder.must((username) => username.isNotEmpty, 'Username cannot be empty');
  /// ```
  LucidValidationBuilder<TProp, Entity> must(bool Function(TProp value) validator, String message, String code) {
    ValidatorResult callback(value, entity) => ValidatorResult(
          isValid: validator(value),
          error: ValidatorError(
            message: message,
            key: key,
            code: code,
          ),
        );

    _rules.add(callback);

    return this;
  }

  /// Adds a validation rule that checks if the [TProp] value satisfies the [validator] condition,
  /// considering the entire [Entity].
  ///
  /// The [mustWith] method allows you to create complex validation rules where the value of a property
  /// is validated in the context of the entire entity. This is useful for scenarios where the validation
  /// of one property depends on the value of another property in the same entity.
  ///
  /// [validator] is a function that takes the current value of the property being validated and the entire entity,
  /// and returns a boolean indicating whether the value is valid.
  /// [message] is the error message that will be returned if the validation fails.
  /// [code] is an optional error code that can be used for translation or error handling purposes.
  ///
  /// Returns the [LucidValidationBuilder] to allow for method chaining.
  ///
  /// Example:
  /// ```dart
  /// ruleFor((user) => user.confirmPassword, key: 'confirmPassword')
  ///     .mustWith((confirmPassword, user) => confirmPassword == user.password,
  ///               'Passwords do not match',
  ///               'password_mismatch');
  /// ```
  LucidValidationBuilder<TProp, Entity> mustWith(
    bool Function(TProp value, Entity entity) validator,
    String message,
    String code,
  ) {
    ValidatorResult callback(value, entity) => ValidatorResult(
          isValid: validator(value, entity),
          error: ValidatorError(
            message: message,
            key: key,
            code: code,
          ),
        );

    _rules.add(callback);

    return this;
  }

  /// Changes the cascade mode for this validation.
  LucidValidationBuilder<TProp, Entity> cascade(CascadeMode mode) {
    _mode = mode;
    return this;
  }
}
