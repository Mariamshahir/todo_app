import 'package:flutter/material.dart';
import 'package:todo/utils/app_colors.dart';

abstract class AppTheme{
static const TextStyle appBarTextStyle = TextStyle(
  fontSize:22,
  fontWeight: FontWeight.bold,
  color: AppColors.white,
);
static const TextStyle days = TextStyle(
  fontSize:15,
  fontWeight: FontWeight.bold,
  color: AppColors.black,
);

static const TextStyle numbers = TextStyle(
  fontSize:12,
  fontWeight: FontWeight.w600,
  color: AppColors.black,
);
static const TextStyle title = TextStyle(
  fontSize:18,
  fontWeight: FontWeight.bold,
  color: AppColors.black,
);
static const TextStyle textTaskTitle = TextStyle(
  fontSize:18,
  fontWeight: FontWeight.bold,
  color: AppColors.backgroundBar,
);
static const TextStyle selectTime = TextStyle(
  fontSize:20,
  fontWeight: FontWeight.w600,
  color: AppColors.black,
);
static const TextStyle time = TextStyle(
  fontSize:18,
  fontWeight: FontWeight.w600,
  color: AppColors.gray,
);
static const TextStyle task = TextStyle(
  fontSize:20,
  fontWeight: FontWeight.w600,
  color: AppColors.gray,
);
static const TextStyle titleSetting = TextStyle(
  fontSize:25,
  fontWeight: FontWeight.bold,
  color: AppColors.backgroundBar,
);
static const TextStyle setting = TextStyle(
  fontSize:14,
  fontWeight: FontWeight.w600,
  color: AppColors.background,
);
static const TextStyle save = TextStyle(
  fontSize:18,
  fontWeight: FontWeight.w600,
  color: AppColors.white,
);


static const TextStyle appBarTextStyleDark = TextStyle(
  fontSize:22,
  fontWeight: FontWeight.bold,
  color: AppColors.black,
);
static const TextStyle numbersDark = TextStyle(
  fontSize:12,
  fontWeight: FontWeight.w600,
  color: AppColors.white,
);
static const TextStyle titleDark = TextStyle(
  fontSize:18,
  fontWeight: FontWeight.bold,
  color: AppColors.white,
);
static const TextStyle selectTimeDark = TextStyle(
  fontSize:20,
  fontWeight: FontWeight.w600,
  color: AppColors.white,
);

static ThemeData lightTheme = ThemeData(
  primaryColor: AppColors.backgroundBar,
  scaffoldBackgroundColor: AppColors.transparent,
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(color: Colors.white),
    backgroundColor: AppColors.backgroundBar,
    elevation: 0,
    titleTextStyle: appBarTextStyle,
  ),
colorScheme:const ColorScheme(brightness: Brightness.light,
    primary: AppColors.background,
    onPrimary: AppColors.onBackgroundBar,
    secondary: AppColors.black,
    onSecondary: AppColors.white,
    error: AppColors.error,
    onError: AppColors.error,
    background: AppColors.white,
    onBackground: AppColors.white,
    surface: AppColors.black,
    onSurface: AppColors.black),
  bottomAppBarTheme: const BottomAppBarTheme(
    elevation: 0,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
    elevation: 0,
    backgroundColor: AppColors.transparent,
    selectedItemColor: AppColors.backgroundBar,
    selectedIconTheme: IconThemeData(size: 36),
    unselectedIconTheme: IconThemeData(size: 30),
    unselectedItemColor: AppColors.selectItem,
    showSelectedLabels: false,
    showUnselectedLabels: false,
  ),
  floatingActionButtonTheme:  const FloatingActionButtonThemeData(
    elevation: 0,
    backgroundColor: AppColors.backgroundBar,
    iconSize: 30,
    shape:StadiumBorder(side: BorderSide(color: AppColors.white,width: 4)),
  ),

    );
static ThemeData darkTheme = ThemeData(
  primaryColor: AppColors.backgroundBar,
  scaffoldBackgroundColor: AppColors.transparent,
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(color: Colors.black),
    backgroundColor: AppColors.backgroundBar,
    elevation: 0,
    titleTextStyle: appBarTextStyleDark,
  ),
  colorScheme:const ColorScheme(brightness: Brightness.light,
      primary: AppColors.backgroundDark,
      onPrimary: AppColors.onBackgroundDark,
      secondary: AppColors.black,
      onSecondary: AppColors.onblack,
      error: AppColors.error,
      onError: AppColors.error,
      background: AppColors.white,
      onBackground: AppColors.white,
      surface: AppColors.black,
      onSurface: AppColors.black),
  bottomAppBarTheme: const BottomAppBarTheme(
    elevation: 0,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
    elevation: 0,
    backgroundColor: AppColors.transparent,
    selectedItemColor: AppColors.backgroundBar,
    selectedIconTheme: IconThemeData(size: 36),
    unselectedIconTheme: IconThemeData(size: 30),
    unselectedItemColor: AppColors.selectItem,
    showSelectedLabels: false,
    showUnselectedLabels: false,
  ),
  floatingActionButtonTheme:  const FloatingActionButtonThemeData(
    elevation: 0,
    backgroundColor: AppColors.backgroundBar,
    iconSize: 30,
    shape:StadiumBorder(side: BorderSide(color: AppColors.cart,width: 4)),
  ),

);

}