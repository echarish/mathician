import 'package:flutter/material.dart';
import 'dart:math';

class AppUtils {
  AppUtils._();
  factory AppUtils() => _instance;
  static final AppUtils _instance = AppUtils._();

  static final instance = _instance;

  static Color getContrastColor(Color backgroundColor) {
    var foregroundColor = backgroundColor.computeLuminance() > 0.5 ? Colors.black : Colors.white;
    return foregroundColor;
  }

  static int twoDigitRandomNumber() {
    var random = Random();
    return random.nextInt(20) + 10;
  }
}
