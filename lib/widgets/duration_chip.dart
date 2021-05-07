import 'package:extreme/styles/intents.dart';
import 'package:flutter/material.dart';

class DurationChip extends StatelessWidget {
  final String content;

  DurationChip({required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Indents.sm / 1.5),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.7),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Text(
        content.replaceFirst("00:", ""),
        style: Theme.of(context).textTheme.overline,
      ),
    );
  }
}