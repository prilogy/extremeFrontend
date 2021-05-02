import 'package:flutter/material.dart';

mixin AspectRatioMixin {
  double? get aspectRatio;

  Widget withAspectRatio({Widget? child}) {
    if(aspectRatio == null)
      return child!;

    return AspectRatio(
      aspectRatio: aspectRatio ?? 16/9,
      child: child,
    );
  }
}