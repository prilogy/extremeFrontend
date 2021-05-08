import 'package:flutter/material.dart';

class LoaderOrContent extends StatelessWidget {
  final bool isLoad;
  final Widget child;

  LoaderOrContent(this.isLoad, {required this.child});

  @override
  Widget build(BuildContext context) {
    return isLoad
        ? Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : child;
  }
}
