import '../lucid_validation.dart';

/// Abstract class for creating validation logic for a specific entity type [E].
///
/// [E] represents the type of the entity being validated.
abstract class LucidValidator<E> {
  final List<LucidValidationBuilder<dynamic, E>> _builders = [];

  addBuilder(LucidValidationBuilder<dynamic, E> builder) {
    this._builders.add(builder);
  }

  /// Registers a validation rule for a specific property of the entity.
  ///
  /// [func] is a function that selects the property from the entity [E].
  /// [key] is an optional string that can be used to identify the property for validation purposes.
  ///
  /// Returns a [LucidValidationBuilder] that allows you to chain additional validation rules.
  ///
  /// Example:
  /// ```dart
  /// final validator = UserValidation();
  /// validator.ruleFor((user) => user.email).validEmail();
  /// ```
  LucidValidationBuilder<TProp, E> ruleFor<TProp>(
      TProp Function(E entity) selector,
      {required String key,
      String label = ''}) {
    final builder =
        _LucidValidationBuilder<TProp, E>(key, label, selector, this);
    _builders.add(builder);

    return builder;
  }

  /// Returns a validation function for a specific field identified by [key].
  ///
  /// The function returned can be used to validate a single field, typically in forms.
  ///
  /// Example:
  /// ```dart
  ///
  /// final validator = UserValidation();
  /// final emailValidator = validator.byField(user, 'email');
  /// String? validationResult = emailValidator('user@example.com');
  /// ```
  ///
  /// or
  /// ```dart
  ///
  /// void callback (errors) {}
  ///
  /// final validator = UserValidation();
  /// final emailValidator = validator.byField(user, 'email', overrideCallback: callback);
  /// emailValidator('user@example.com'); // return null when overrideCallback is not null
  /// ```
  String? Function([String?]) byField(
    E entity,
    String key, {
    Function(List<ValidationException>)? overrideCallback,
  }) {
    if (key.contains('.')) {
      final keys = key.split('.');

      final firstKey = keys.removeAt(0);
      final builder = _getBuilderByKey(firstKey);
      if (builder == null) {
        if (overrideCallback != null) {
          overrideCallback.call([]);
          return ([_]) => null;
        }

        return ([_]) => null;
      }

      return builder.nestedByField(entity, keys.join('.'));
    } else {
      final builder = _getBuilderByKey(key);

      if (builder == null) {
        if (overrideCallback != null) {
          overrideCallback.call([]);
          return ([_]) => null;
        }

        return ([_]) => null;
      }

      return ([_]) {
        final errors = builder.executeRules(entity);
        if (errors.isNotEmpty) {
          if (overrideCallback != null) {
            overrideCallback.call(errors);
          }
          return errors.first.message;
        }
        if (overrideCallback != null) {
          overrideCallback.call([]);
        }
        return null;
      };
    }
  }

  LucidValidationBuilder? _getBuilderByKey(String key) {
    return _builders
        .where(
          (builder) => builder.key == key,
        )
        .firstOrNull;
  }

  /// Validates the entire entity [E] and returns a list of [ValidationException]s if any rules fail.
  ///
  /// This method iterates through all registered rules and checks if the entity meets all of them.
  ///
  /// Example:
  /// ```dart
  /// final validator = UserValidation();
  /// final errors = validator.validate(user);
  /// if (errors.isEmpty) {
  ///   print('All validations passed');
  /// } else {
  ///   print('Validation failed: ${errors.map((e) => e.message).join(', ')}');
  /// }
  /// ```
  ValidationResult validate(E entity) {
    final List<ValidationException> exceptions = [];

    for (var builder in _builders) {
      exceptions.addAll(builder.executeRules(entity));
      if (builder.getMode() == CascadeMode.stopOnFirstFailure &&
          exceptions.isNotEmpty) {
        break;
      }
    }

    return ValidationResult(
      isValid: exceptions.isEmpty,
      exceptions: exceptions,
    );
  }

  /// **getExceptions**
  ///
  /// This function fetches and returns all validation exceptions associated with an entity.
  ///
  /// **Parameters:**
  ///   * `entity`: The entity to be validated.
  ///
  /// **Return:**
  ///   * A list of validation exceptions encountered.
  ///
  /// **Description:**
  ///  The function iterates over all registered validation builders and executes the validation rules for each builder.
  ///  Exceptions encountered are added to a list and returned at the end.
  ///  If the cascade mode is set to 'stopOnFirstFailure', the function stops checking the remaining rules after the first exception.
  ///
  List<ValidationException> getExceptions(E entity) {
    final List<ValidationException> exceptions = [];

    for (var builder in _builders) {
      exceptions.addAll(builder.executeRules(entity));
      if (builder.getMode() == CascadeMode.stopOnFirstFailure &&
          exceptions.isNotEmpty) {
        break;
      }
    }

    return exceptions;
  }

  /// **getExceptions**
  ///
  /// This function fetches and returns all validation exceptions associated with an entity by key.
  ///
  /// **Parameters:**
  ///   * `entity`: The entity to be validated.
  ///   * `key`: key associated with validations.
  ///
  /// **Return:**
  ///   * A list of validation exceptions encountered by key.
  ///
  /// **Description:**
  ///  The function iterates over all registered validation builders and executes the validation rules for each builder.
  ///  Exceptions encountered are added to a list and returned at the end.
  ///  If the cascade mode is set to 'stopOnFirstFailure', the function stops checking the remaining rules after the first exception.
  ///
  List<ValidationException> getExceptionsByKey(E entity, String key) {
    final builder = _getBuilderByKey(key);

    if (builder == null) return [];

    final exceptions = builder.executeRules(entity);

    return exceptions.isNotEmpty ? exceptions : [];
  }
}

class _LucidValidationBuilder<TProp, Entity>
    extends LucidValidationBuilder<TProp, Entity> {
  _LucidValidationBuilder(super.key, super.label, super.selector, super.lucid);
}
