import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  Color get background => currentTheme == ThemeMode.light ? AppColors.background: AppColors.backgroundDark;

  Future<void> saveTheme(bool isDark)async{
    await sharedPreferences!.setBool('isDark', isDark);
  }

  bool? getTheme(){
    return sharedPreferences!.getBool('isDark');
  }
}