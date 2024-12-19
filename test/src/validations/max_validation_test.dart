import 'package:lucid_validation/src/validations/validations.dart';
import 'package:test/test.dart';

import '../../mocks/mocks.dart';

void main() {
  test('max validation...', () {
    final validator = TestLucidValidator<UserModel>();
    validator
        .ruleFor((user) => user.age, key: 'age') //
        .max(18);

    final user = UserModel()..age = 20;

    final result = validator.validate(user);

    expect(result.isValid, false);
    expect(result.exceptions.length, 1);
    expect(result.exceptions.first.message,
        "'age' must be less than or equal to 18. You entered 20.");
  });

  test('max validation or null...', () {
    final validator = TestLucidValidator<UserNullableModel>();
    validator
        .ruleFor((user) => user.age, key: 'age') //
        .maxOrNull(18);

    final user = UserNullableModel()..age = null;

    final result = validator.validate(user);

    expect(result.isValid, true);
  });
}
