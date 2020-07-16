import 'package:flutter/material.dart';

mixin AspectRatioMixin {
  double aspectRatio;

  Widget withAspectRatio({Widget child}) {
    if(aspectRatio == null)
      return child;

    return AspectRatio(
      aspectRatio: aspectRatio,
      child: child,
    );
  }
}