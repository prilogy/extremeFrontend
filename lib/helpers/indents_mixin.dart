import 'package:flutter/material.dart';

mixin IndentsMixin {
  EdgeInsetsGeometry padding;
  EdgeInsetsGeometry margin;

  Widget withIndents({Widget child}) {
    return Container(
      padding: padding,
      margin: margin,
      child: child,
    );
  }
}