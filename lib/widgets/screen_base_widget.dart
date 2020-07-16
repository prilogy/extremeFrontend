import 'package:extreme/helpers/indents_mixin.dart';
import 'package:extreme/styles/intents.dart';
import 'package:flutter/material.dart';

class ScreenBaseWidget extends StatelessWidget with IndentsMixin {

  final List<Widget> children;
  final EdgeInsetsGeometry padding;

  final Widget appBar;


  ScreenBaseWidget({this.padding = const EdgeInsets.all(Indents.md), this.children, this.appBar});

  @override
  Widget build(BuildContext context) {
    return ListView(
        padding: padding,
        children: children,
    );
  }
}