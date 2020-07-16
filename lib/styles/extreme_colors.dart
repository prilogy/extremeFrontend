import 'package:flutter/material.dart';

class ExtremeColors {
  static const MaterialColor base = MaterialColor(0xFF15162B, {
    500: Color(0xFF15162B),
    400: Color(0xFF2F2C47),
    300: Color(0xFF716E80),
    200: Color(0xFFB6B5BD),
    100: Color(0xFFFFFFFF) //white actually
  });

  static final Color stm = base.withOpacity(0.6);

  static final MaterialColor base70 = MaterialColor(base.withOpacity(0.7).value, {
    500: Color(0xFF15162B).withOpacity(0.7),
    400: Color(0xFF2F2C47).withOpacity(0.7),
    300: Color(0xFF716E80).withOpacity(0.7),
    200: Color(0xFFB6B5BD).withOpacity(0.7),
    100: Color(0xFFFFFFFF).withOpacity(0.7)
  });

  static const MaterialColor primary = MaterialColor(0xFF22A3D2, {
    500: Color(0xFF22A3D2),
    600: Color(0xFF1B8AB2)
  });

  static const Color success = Color(0xFF27AE60);
  static const Color warning = Color(0xFFF2994A);
  static const Color error = Color(0xFFEB5757);
}