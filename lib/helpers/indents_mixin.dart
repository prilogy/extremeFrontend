import 'package:flutter/material.dart';

mixin IndentsMixin {
  EdgeInsetsGeometry get padding;
  EdgeInsetsGeometry get margin;

  Widget withIndents({Widget child}) {
    return Container(
      padding: padding,
      margin: margin,
      child: child,
    );
  }
}