import 'dart:math';

class PinRule {}

// workshop #3
class PinRules {
  final List<PinRule> _rules = [];

  bool isSequential(String numberStr) {
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

  String? getErrorMessage(String pin) {
    return isSequential(pin) ? "this pin is invalid" : null;
  }
}
