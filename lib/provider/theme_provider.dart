import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/utils/app_assets.dart';
import 'package:todo/utils/app_colors.dart';

class ThemeProvider extends ChangeNotifier{
  ThemeMode currentTheme = ThemeMode.light;

  void changeTheme(ThemeMode selectedThemeMode){
    currentTheme = selectedThemeMode;
    notifyListeners();
  }

  String get splash => currentTheme == ThemeMode.light ? AppAssets.splash: AppAssets.darkSplash;

  Color get background => currentTheme == ThemeMode.light ? AppColors.background: AppColors.backgroundDark;

}