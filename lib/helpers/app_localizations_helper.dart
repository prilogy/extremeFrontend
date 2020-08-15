import 'package:extreme/lang/app_localizations.dart';

class AppLocalizationsHelper {
  final AppLocalizations localizations;
  final String baseKey;

  AppLocalizationsHelper({this.localizations, this.baseKey});

  String translate(String key, [List<String> args]) {
    var _key = (baseKey ?? '') + key;
    return localizations.translate(_key, args);
  }
}

extension AppLocalizationExtension on AppLocalizations {
  AppLocalizationsHelper withBaseKey(String key) {
    if (key[key.length - 1] != '.') key += '.';
    return AppLocalizationsHelper(localizations: this, baseKey: key);
  }
}
