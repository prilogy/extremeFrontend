import 'package:flutter/material.dart';

class ContainerCenteredWithMaxWidth extends StatelessWidget {
  static const double constMaxWidth = 600;
  final double? maxWidth;
  final Widget child;

  ContainerCenteredWithMaxWidth(
      {required this.child, this.maxWidth = constMaxWidth});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      constraints:
          maxWidth == null ? null : BoxConstraints(maxWidth: maxWidth!),
      child: child,
    ));
  }
}
