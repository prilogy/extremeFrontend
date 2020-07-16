import 'package:extreme/styles/intents.dart';
import 'package:flutter/material.dart';

class ScreenBaseWidget extends StatelessWidget {

  final List<Widget> children;
  final EdgeInsetsGeometry padding;

  final Widget topBar;


  ScreenBaseWidget({this.padding = const EdgeInsets.all(Indents.md), this.children, this.topBar});

  @override
  Widget build(BuildContext context) {
    return ListView(
        padding: padding,
        children: children,

    );
  }
}