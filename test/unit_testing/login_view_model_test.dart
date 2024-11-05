import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobiletesting/login_screen/login_view_model.dart';
import 'package:mobiletesting/login_screen/pin_rules.dart';
import 'package:mobiletesting/login_screen/sort_order.dart';
import 'package:mobiletesting/login_screen/login_service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_view_model_test.mocks.dart';

@GenerateMocks([BuildContext, LoginService, PinRules])
void main() {
  group('LoginViewModel', () {
    late LoginViewModel loginViewModel;
    late MockLoginService mockLoginService;
    late MockPinRules mockPinRules;

    setUp(() {
      mockLoginService = MockLoginService();
      mockPinRules = MockPinRules();
      loginViewModel =
          LoginViewModel(mockLoginService, SortOrder.ascending, mockPinRules);

      when(mockPinRules.getErrorMessage('123456'))
          .thenReturn('this pin is invalid');

      when(mockPinRules.getErrorMessage('123458')).thenReturn(null);
    });

    group('onDigitPressed', () {
      test(
          'given inputted pin is empty when digit is pressed then inputted pin should be added',
          () {
        // Arrange

        // Act
        loginViewModel.onDigitPressed(0, MockBuildContext());

        // Assert
        expect(loginViewModel.inputtedPin, "0");
      }, tags: 'unit');

      test(
          'given inputted pin is 5 digits when digit is pressed then inputted pin should not be added',
          () {
        // Arrange
        loginViewModel.onDigitPressed(1, MockBuildContext());
        loginViewModel.onDigitPressed(2, MockBuildContext());
        loginViewModel.onDigitPressed(3, MockBuildContext());
        loginViewModel.onDigitPressed(4, MockBuildContext());
        loginViewModel.onDigitPressed(5, MockBuildContext());

        // Act
        loginViewModel.onDigitPressed(6, MockBuildContext());

        // Assert
        expect(loginViewModel.inputtedPin, "123456");
      }, tags: 'unit');

      test(
          'given inputted pin is 6 digits when digit is pressed then inputted pin should not be displayed',
          () {
        // Arrange
        loginViewModel.onDigitPressed(1, MockBuildContext());
        loginViewModel.onDigitPressed(2, MockBuildContext());
        loginViewModel.onDigitPressed(3, MockBuildContext());
        loginViewModel.onDigitPressed(4, MockBuildContext());
        loginViewModel.onDigitPressed(5, MockBuildContext());
        loginViewModel.onDigitPressed(6, MockBuildContext());

        // Act
        loginViewModel.onDigitPressed(7, MockBuildContext());

        // Assert
        expect(loginViewModel.inputtedPin, "123456");
      }, tags: 'unit');
      group('FE pin validation', () {
        test('when inputted 6 digits then got error', () {
          // Arrange
          // Act
          loginViewModel.onDigitPressed(1, MockBuildContext());
          loginViewModel.onDigitPressed(2, MockBuildContext());
          loginViewModel.onDigitPressed(3, MockBuildContext());
          loginViewModel.onDigitPressed(4, MockBuildContext());
          loginViewModel.onDigitPressed(5, MockBuildContext());
          loginViewModel.onDigitPressed(6, MockBuildContext());
          // Assert
          expect(loginViewModel.dialogMessage, 'this pin is invalid');
        });

        test('when inputted 6 digits return success', () {
          // Arrange
          // Act
          loginViewModel.onDigitPressed(1, MockBuildContext());
          loginViewModel.onDigitPressed(2, MockBuildContext());
          loginViewModel.onDigitPressed(3, MockBuildContext());
          loginViewModel.onDigitPressed(4, MockBuildContext());
          loginViewModel.onDigitPressed(5, MockBuildContext());
          loginViewModel.onDigitPressed(8, MockBuildContext());
          // Assert
          expect(loginViewModel.dialogMessage, 'success');
        });
      });
      group('handle network call', () {});

      test('dot filled', () {
        // Arrange
        loginViewModel.onDigitPressed(1, MockBuildContext());
        loginViewModel.onDigitPressed(2, MockBuildContext());
        loginViewModel.onDigitPressed(3, MockBuildContext());
        loginViewModel.onDigitPressed(4, MockBuildContext());

        // Act

        // Assert
      }, tags: 'unit');
    });
    group('onDeleteButtonPressed', () {
      test(
          'given inputted pin is not empty when delete button is click then last digit from inputtedPin will be removed',
          () {
        // Arrange
        loginViewModel.onDigitPressed(1, MockBuildContext());
        loginViewModel.onDigitPressed(2, MockBuildContext());

        // Act
        loginViewModel.onDeleteButtonPressed();

        // Assert
        expect(loginViewModel.inputtedPin, "1");
      }, tags: 'unit');

      test(
          'given inputted pin is empty when delete button is click then nothing happend',
          () {
        // Arrange

        // Act
        loginViewModel.onDeleteButtonPressed();

        // Assert
        expect(loginViewModel.inputtedPin, '');
      }, tags: 'unit');
    });
    group('navigation', () {});
  });
}
