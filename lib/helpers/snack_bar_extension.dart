import 'package:extreme/main.dart';
import 'package:extreme/styles/extreme_colors.dart';
import 'package:flutter/material.dart';

const _defaultDuration = Duration(seconds: 1, milliseconds: 500);

extension SnackBarExtension on SnackBar {
  static void show(SnackBar snackBar) {
    rootScaffold.currentState?.hideCurrentSnackBar();
    rootScaffold.currentState?.showSnackBar(snackBar);
  }

  static SnackBar error(String text, [Duration duration = _defaultDuration]) {
    return SnackBar(
      content: Text(text, style: TextStyle(color: ExtremeColors.base[100]),),
      backgroundColor: ExtremeColors.error,
      duration: duration,
    );
  }

  static SnackBar success(String text, [Duration duration = _defaultDuration]) {
    return SnackBar(
      content: Text(text, style: TextStyle(color: ExtremeColors.base[100]),),
      backgroundColor: ExtremeColors.success,
      duration: duration,
    );
  }

  static SnackBar warning(String text,  [Duration duration = _defaultDuration]) {
    return SnackBar(
      content: Text(text, style: TextStyle(color: ExtremeColors.base[100]),),
      backgroundColor: ExtremeColors.warning,
      duration: duration,
    );
  }

  static SnackBar info(String text,  [Duration duration = _defaultDuration]) {
    return SnackBar(
      content: Text(text, style: TextStyle(color: ExtremeColors.base[100]),),
      backgroundColor: ExtremeColors.primary,
      duration: duration,
    );
  }
}
