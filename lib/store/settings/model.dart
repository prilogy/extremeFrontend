import 'package:extreme/models/main.dart';
import 'package:extreme/services/localstorage.dart';

class Settings {
  Culture? culture;
  Currency? currency;


  Settings({this.culture, this.currency});
  
  Settings.fromJson(Map<String, dynamic> json) {
    this.culture = json['culture'] != null
        ? new Culture.fromJson(json['culture'])
        : null;

    this.currency = json['currency'] != null
        ? new Currency.fromJson(json['currency'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    if (this.culture != null) {
      data['culture'] = this.culture?.toJson();
    }
    if (this.currency != null) {
      data['currency'] = this.currency?.toJson();
    }

    return data;
  }

  static const String localStorageKey = 'settings';
  static Settings fromLocalStorage() {
    try {
      var json = localStorage.getItem(localStorageKey);
      return json == null ? Settings(culture: null, currency: null) : Settings.fromJson(json);
    } catch(ex) {
      return Settings(culture: null, currency: null);
    }
  }

  static void saveToLocalStorage(Settings settings) {
    localStorage.setItem(localStorageKey, settings.toJson() );
  }
}