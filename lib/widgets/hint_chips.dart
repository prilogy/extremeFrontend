import 'package:extreme/helpers/indents_mixin.dart';
import 'package:extreme/lang/app_localizations.dart';
import 'package:extreme/styles/extreme_colors.dart';
import 'package:flutter/material.dart';

class HintChip extends StatelessWidget with IndentsMixin {
  final String localizationKey;
  final Color backgroundColor;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  
  HintChip(
      {this.localizationKey,
      this.backgroundColor,
      this.margin,
      this.padding});

  @override
  Widget build(BuildContext context) {
    var text = AppLocalizations.of(context).translate(localizationKey);

    return withIndents(
      child: Chip(
        label: Text(text),
        backgroundColor: backgroundColor ?? ExtremeColors.error.withOpacity(0.6),
      ),
    );
  }

  static Widget noLocalization({EdgeInsetsGeometry margin}) {
    return HintChip(localizationKey: 'chips.no_localization', margin: margin);
  }
}

