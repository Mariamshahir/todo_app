import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider extends ChangeNotifier {
  String currentLocale = "en";
  SharedPreferences? sharedPreferences;

  Future<void> setItems() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (getLang() == null) {
      currentLocale = "en";
    } else {
      currentLocale = getLang()!;
    }
  }

  void setCurrentLocale(String newLocale) {
    currentLocale = newLocale;
    saveLang(newLocale);
    notifyListeners();
  }

  Future<void> saveLang(String language) async {
    await sharedPreferences!.setString('language', language);
  }

  String? getLang() {
    return sharedPreferences!.getString('language');
  }
}
