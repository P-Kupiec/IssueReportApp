import 'package:flutter/material.dart';

import '../constants/ui_values.dart';

ButtonStyle setButtonStyle() {
  return ElevatedButton.styleFrom(
    textStyle: const TextStyle(fontSize: 18),
    foregroundColor: Colors.white,
    backgroundColor: const Color(UiValues.wuwerBlue),
    shadowColor: const Color(UiValues.wuwerYellow),
    elevation: 3,
  );
}