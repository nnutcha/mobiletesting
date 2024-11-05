import 'package:flutter_test/flutter_test.dart';
import 'package:mobiletesting/login_screen/pin_rules.dart';

void main() {
  group('PinRules', () {
    late PinRules pinrules = PinRules();

    group('isSequential', () {
      test('when pin is sequential then return message error', () {
        // Arrange

        // Act

        // Assert

        expect(pinrules.getErrorMessage("012345"), 'this pin is invalid');
        expect(pinrules.getErrorMessage("123456"), 'this pin is invalid');
        expect(pinrules.getErrorMessage("234567"), 'this pin is invalid');
        expect(pinrules.getErrorMessage("456789"), 'this pin is invalid');
      }, tags: 'unit');

      test('when pin is not sequential then return null', () {
        // Arrange

        // Act

        // Assert
        expect(pinrules.getErrorMessage("135789"), null);
        expect(pinrules.getErrorMessage("000000"), null);
      }, tags: 'unit');
    });
  });
}
