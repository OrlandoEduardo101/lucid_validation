import 'package:lucid_validation/src/validations/validations.dart';
import 'package:test/test.dart';

import '../../mocks/mocks.dart';

void main() {
  test('less than validation...', () {
    final validator = TestLucidValidator<UserModel>();
    validator
        .ruleFor((user) => user.age, key: 'age') //
        .lessThan(17);

    final user = UserModel()..age = 20;

    final result = validator.validate(user);

    expect(result.isValid, false);
    expect(result.exceptions.length, 1);
    expect(result.exceptions.first.message, "'age' must be less than '17'.");
  });

  test('less than validation or null...', () {
    final validator = TestLucidValidator<UserNullableModel>();
    validator
        .ruleFor((user) => user.age, key: 'age') //
        .lessThanOrNull(17);

    final user = UserNullableModel()..age = null;

    final result = validator.validate(user);

    expect(result.isValid, true);
  });
}
