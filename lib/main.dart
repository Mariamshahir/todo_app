import 'package:flutter/material.dart';
import 'package:todo/homescreen.dart';
import 'package:todo/provider/language_provider.dart';
import 'package:todo/provider/theme_provider.dart';
import 'package:todo/splash.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:todo/utils/aap_theme.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  LanguageProvider languageProvider =LanguageProvider();
  await languageProvider.setItems();

  ThemeProvider themeProvider =ThemeProvider();
  await themeProvider.setItems();
  runApp(MultiProvider(
      providers:[
        ChangeNotifierProvider(create: (_) => languageProvider),
        ChangeNotifierProvider(create: (_) => themeProvider),
      ],
      child: const MyApp()
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    LanguageProvider provider=Provider.of(context);
    ThemeProvider themeProvider=Provider.of(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale("en"),
        Locale("ar")
      ],
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.currentTheme,
      routes: {
        Splash.routeName:(_) => Splash(),
        HomeScreen.routeName: (_) => HomeScreen(),
      },
      initialRoute: Splash.routeName,
    );
  }
}

