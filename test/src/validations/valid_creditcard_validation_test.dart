import 'package:lucid_validation/lucid_validation.dart';
import 'package:test/test.dart';

import '../../mocks/mocks.dart';

void main() {
  test('valid creditcard validation ...', () {
    final validator = TestLucidValidator<CreditCardModel>();

    validator
        .ruleFor((e) => e.number, key: 'number') //
        .validCreditCard();

    final creditCard = CreditCardModel()..number = '1';

    final result = validator.validate(creditCard);

    expect(result.isValid, false);

    expect(result.exceptions.length, 1);

    final error = result.exceptions.first;

    expect(error.message, "'number' is not a valid credit card number.");
  });

  test('valid creditcard validation or null ...', () {
    final validator = TestLucidValidator<CreditCardNullableModel>();

    validator
        .ruleFor((e) => e.number, key: 'number') //
        .validCreditCardOrNull();

    final creditCard = CreditCardNullableModel()..number = null;

    final result = validator.validate(creditCard);

    expect(result.isValid, true);
  });
}
