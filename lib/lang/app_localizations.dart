import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  final Locale? locale;

  AppLocalizations(this.locale);

  // Helper method to keep the code in the widgets concise
  // Localizations are accessed using an InheritedWidget "of" syntax
  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  Map<String, String>? _localizedStrings;

  Future<bool> load([Locale? newLocale]) async {
    var localeName = newLocale == null ? locale!.languageCode : newLocale.languageCode;
    var value =
        await rootBundle.loadString('lang/$localeName.json');
    Map<String, dynamic> jsonMap = jsonDecode(value);
    _localizedStrings = flattenTranslations(jsonMap) as Map<String, String>?;
    return true;
  }

  Map flattenTranslations(Map<String, dynamic> json, [String prefix = '']) {
    final Map<String, String> translations = {};
    json.forEach((String key, dynamic value) {
      if (value is Map) {
        translations.addAll(flattenTranslations(value as dynamic, '$prefix$key.') as dynamic);
      } else {
        translations['$prefix$key'] = value.toString();
      }
    });
    return translations;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  String translate(String key, [List<String>? args]) {
    var str = _localizedStrings![key] ?? key;
    if (args != null)
      for (var i = 0; i < args.length; i++) {
        str = str.replaceFirst('{$i}', args[i] ?? '');
      }
    return str;
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'ru'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = new AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
