import 'package:extreme/styles/extreme_colors.dart';
import 'package:flutter/material.dart';

class CustomSnackBar{

  static SnackBar error(String text) {
    return SnackBar(
      content: Text(text, style: TextStyle(color: ExtremeColors.base[100]),),
      backgroundColor: ExtremeColors.error,
    );
  }

  static SnackBar success(String text) {
    return SnackBar(
      content: Text(text, style: TextStyle(color: ExtremeColors.base[100]),),
      backgroundColor: ExtremeColors.success,
    );
  }

  static SnackBar warning(String text) {
    return SnackBar(
      content: Text(text, style: TextStyle(color: ExtremeColors.base[100]),),
      backgroundColor: ExtremeColors.warning,
    );
  }

  static SnackBar info(String text) {
    return SnackBar(
      content: Text(text, style: TextStyle(color: ExtremeColors.base[100]),),
      backgroundColor: ExtremeColors.primary,
    );
  }

}