import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/provider/language_provider.dart';
import 'package:todo/provider/theme_provider.dart';
import 'package:todo/utils/aap_theme.dart';
import 'package:todo/utils/app_colors.dart';
import 'package:todo/utils/app_language.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String selectLanguage = "en";
  String selectMode = "light";
  late LanguageProvider provider;
  late ThemeProvider themeProvider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context);
    themeProvider = Provider.of(context);

    return Column(
      children: [
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                children: [
                  Positioned.fill(
                    child: Column(
                      children: [
                        Expanded(child: Container(color: AppColors.backgroundBar,)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 25, horizontal: 16),
                    child: Center(
                      child: Text(context.getLocalizations.settings, style: AppTheme.titleSetting.copyWith(color: AppColors.white)),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12,),
              Text(context.getLocalizations.language, style: AppTheme.title),
              SizedBox(height: 20,),
              buildLanguageDropDownButton(),
              SizedBox(height: 20,),
              Text(context.getLocalizations.mode, style: AppTheme.title),
              SizedBox(height: 20,),
              buildLanguageDropDownButton2(),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildLanguageDropDownButton() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(color:AppColors.white,border: Border.all(color: AppColors.backgroundBar)),
      child: DropdownButton<String>(
        items: const[
          DropdownMenuItem(
              value: "en",
              child: Text("English", style: TextStyle(fontSize: 14,color: AppColors.backgroundBar))),
          DropdownMenuItem(
              value: "ar",
              child: Text("العربيه", style: TextStyle(fontSize: 14,color: AppColors.backgroundBar))),
        ],

        value: selectLanguage,
        isExpanded: true,
        onChanged: (newValue) {
          selectLanguage = newValue!;
          provider.setCurrentLocale(selectLanguage);
          setState(() {});
        },
      ),
    );
  }

  Widget buildLanguageDropDownButton2() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(color:AppColors.white,border: Border.all(color: AppColors.backgroundBar)),
      child: DropdownButton<String>(
        items: const[
          DropdownMenuItem(
              value: "light",
              child: Text("Light Mode", style: TextStyle(fontSize: 14,color: AppColors.backgroundBar))),
          DropdownMenuItem(
              value: "dark",
              child: Text("Dark Mode", style: TextStyle(fontSize: 14,color: AppColors.backgroundBar))),
        ],
        value: selectMode,
        isExpanded: true,
        onChanged: (newValue) {
          selectMode = newValue!;
          provider.setCurrentLocale(selectMode);
          setState(() {});
        },
      ),
    );
  }

}
