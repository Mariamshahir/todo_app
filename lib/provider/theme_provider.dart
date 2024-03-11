import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/utils/aap_theme.dart';
import 'package:todo/utils/app_assets.dart';
import 'package:todo/utils/app_colors.dart';

class ThemeProvider extends ChangeNotifier{
  ThemeMode currentTheme = ThemeMode.light;
  SharedPreferences? sharedPreferences;

  Future<void> setItems()async{
    sharedPreferences=await SharedPreferences.getInstance();
    if(getTheme()==null){
      currentTheme=ThemeMode.light;
    }else{
      currentTheme = getTheme()! ? ThemeMode.dark : ThemeMode.light;
    }
  }
  void changeTheme(ThemeMode selectMode){
    currentTheme = selectMode;
    saveTheme(selectMode == ThemeMode.dark);
    notifyListeners();
  }

  String get splash => currentTheme == ThemeMode.light ? AppAssets.splash: AppAssets.darkSplash;

  TextStyle get numbertext => currentTheme == ThemeMode.light ? AppTheme.numbers: AppTheme.numbersDark;

  TextStyle get selectTime => currentTheme == ThemeMode.light ? AppTheme.selectTime: AppTheme.selectTimeDark;

  TextStyle get text => currentTheme == ThemeMode.light ? AppTheme.title: AppTheme.titleDark;

  TextStyle get title => currentTheme == ThemeMode.light ? AppTheme.titleSetting.copyWith(color: AppColors.white): AppTheme.titleSetting.copyWith(color: AppColors.black);

  Color get background => currentTheme == ThemeMode.light ? AppColors.background: AppColors.backgroundDark;

  Color get buttonAppBar => currentTheme == ThemeMode.light ? AppColors.white: AppColors.cart;

  Color get calender => currentTheme == ThemeMode.light ? AppColors.black: AppColors.white;

  Color get cart => currentTheme == ThemeMode.light ? AppColors.white: AppColors.cart;

  Color get addCart => currentTheme == ThemeMode.light ? AppColors.white: AppColors.cart;

  Future<void> saveTheme(bool isDark)async{
    await sharedPreferences!.setBool('isDark', isDark);
  }

  bool? getTheme(){
    return sharedPreferences!.getBool('isDark');
  }
}