import 'package:extreme/lang/app_localizations.dart';
import 'package:flutter/cupertino.dart';

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

String dateTimeToStringInAgoFormat(DateTime date, BuildContext context) {
  final loc = AppLocalizations.of(context).withBaseKey('date_ago');

  DateTime localDate = date.toLocal();
  Duration difference = DateTime.now().toLocal().difference(localDate);
  int days = difference.inDays;
  int years = days ~/ 365;
  String result;
  if (years > 0) {
    if (years == 1) {
      result = loc.translate('year.one');
    } else if (years > 1 && years < 5 ||
        (years > 20 && years % 10 > 1 && years % 10 < 5)) {
      result = loc.translate('year.two_four', [years.toString()]);
    } else {
      result = loc.translate('year.more', [years.toString()]);
    }
  } else {
    int months = days ~/ 30;
    if (months > 0) {
      if (months == 1) {
        result = loc.translate('month.one');
      } else if (months >= 2 && months <= 4) {
        result = loc.translate('month.two_four', [months.toString()]);
      } else
        result = loc.translate('month.more', [months.toString()]);
    } else {
      int weeks = days ~/ 7;
      if (weeks > 0) {
        if (weeks == 1) {
          result = loc.translate('week.one');
        } else if (weeks >= 2 && weeks <= 4) {
          result = loc.translate('week.two_four', [weeks.toString()]);
        }
      } else if (days > 0) {
        if (days == 1) {
          result = loc.translate('day.one');
        } else if (days >= 2 && days <= 4) {
          result = loc.translate('day.two_four', [days.toString()]);
        } else {
          result = loc.translate('day.more', [days.toString()]);
        }
      } else {
        int hours = difference.inHours;
        if (hours > 0) {
          if (hours == 1) {
            result = loc.translate('hour.one');
          } else if (hours >= 2 && hours <= 4) {
            result = loc.translate('hour.two_four', [hours.toString()]);
          } else {
            result = loc.translate('hour.more', [hours.toString()]);
          }
        } else {
          int minutes = difference.inMinutes;
          if (minutes > 0) {
            if (minutes == 1) {
              result = loc.translate('minute.one');
            } else if (minutes >= 2 && minutes <= 4 ||
                (minutes > 20 && minutes % 10 >= 2 && minutes % 10 <= 4)) {
              result = loc.translate('minute.two_four', [minutes.toString()]);
            } else {
              result = loc.translate('minute.more', [minutes.toString()]);
            }
          } else {
            result = loc.translate('minute.less_than_one');
          }
        }
      }
    }
  }

  return result;
}
