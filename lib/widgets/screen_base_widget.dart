import 'package:extreme/helpers/indents_mixin.dart';
import 'package:extreme/styles/intents.dart';
import 'package:extreme/widgets/nav_bar.dart';
import 'package:flutter/material.dart';

class ScreenBaseWidget extends StatelessWidget with IndentsMixin {
  final List<Widget> children;
  final EdgeInsetsGeometry padding;

  final Widget appBar;

  static const double screenBottomIndent = NavBar.height + Indents.md + Indents.sm;

  static const EdgeInsetsGeometry _defaultPadding = EdgeInsets.only(top: Indents.md, bottom: screenBottomIndent);

  ScreenBaseWidget(
      {this.padding = _defaultPadding, this.children, this.appBar});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: padding,
      children: children,
    );
  }
}
