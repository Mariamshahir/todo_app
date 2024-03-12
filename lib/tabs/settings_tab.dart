import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/provider/language_provider.dart';
import 'package:todo/provider/theme_provider.dart';
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

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LanguageProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

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
                    child: Center(child: Text(context.getLocalizations.settings, style: themeProvider.title)),
                  ),
                ],
              ),
              SizedBox(height: 12,),
              Padding(
                padding: const EdgeInsets.only(top: 25,left: 38),
                child: Text(context.getLocalizations.language, style: themeProvider.text),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(left: 56,right: 37),
                child: buildLanguageDropDownButton(provider),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(left: 38),
                child: Text(context.getLocalizations.mode, style: themeProvider.text),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(left: 56,right: 37),
                child: buildThemeDropDownButton(themeProvider),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildLanguageDropDownButton(LanguageProvider provider) {
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

  Widget buildThemeDropDownButton(ThemeProvider themeProvider) {
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
          themeProvider.changeTheme(selectMode == "dark" ? ThemeMode.dark : ThemeMode.light);
          setState(() {});
        },
      ),
    );
  }
}
