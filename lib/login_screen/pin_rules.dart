import 'dart:math';

class PinRule {}

// workshop #3
class PinRules {
  final List<PinRule> _rules = [];

  bool _isSequential(String numberStr) {
    // Check if the string is empty or has only one character
    if (numberStr.length <= 1) return true;

    // Convert the string into a list of integers
    List<int> digits = numberStr.split('').map(int.parse).toList();

    // Check if each consecutive number differs by 1
    for (int i = 1; i < digits.length; i++) {
      if (digits[i] != digits[i - 1] + 1) {
        return false;
      }
    }

    return true;
  }

  bool _isRepeatNumber(String pin) {
    return pin.length != pin.split('').toSet().length;
  }

  bool _isSum15(String pin) {
    return 15 ==
        pin
            .split('') // Split the string into individual characters
            .map(int.parse) // Convert each character to an integer
            .reduce((a, b) => a + b);
  }

  String? getErrorMessage(String pin) {
    if (_isSequential(pin)) {
      return "this pin is invalid";
    } else if (_isRepeatNumber(pin)) {
      return "this pin is invalid";
    } else if (_isSum15(pin)) {
      return "this pin is invalid";
    }
    return null;
  }
}
