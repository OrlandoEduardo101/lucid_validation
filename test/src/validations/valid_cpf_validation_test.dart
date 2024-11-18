import 'package:lucid_validation/lucid_validation.dart';
import 'package:test/test.dart';

import '../../mocks/mocks.dart';

void main() {
  test('valid cpf validation ...', () {
    final validator = TestLucidValidator<UserModel>();

    validator
        .ruleFor((e) => e.cpf, key: 'cpf') //
        .isNotNull()
        .notEmpty()
        .validCPF();

    final user = UserModel()..cpf =  null;

    final result = validator.validate(user);

    expect(result.isValid, false);

    expect(result.exceptions.length, 1);

    final error = result.exceptions.first;

    expect(error.message, "'cpf' must not be null.");
  });
}
