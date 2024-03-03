import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo/homescreen.dart';
import 'package:todo/provider/language_provider.dart';
import 'package:todo/provider/list_provider.dart';
import 'package:todo/provider/theme_provider.dart';
import 'package:todo/splash.dart';
import 'package:todo/utils/aap_theme.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: const FirebaseOptions(apiKey: "AIzaSyAsZzYRoZ230qYBQITuoY9KM0_Vf6lvWDY",
      appId: "todo-app-10247", projectId: "todo-app-10247", messagingSenderId: "todo-app-10247"));

  await FirebaseFirestore.instance.disableNetwork();

  LanguageProvider languageProvider =LanguageProvider();
  await languageProvider.setItems();

  ThemeProvider themeProvider =ThemeProvider();
  await themeProvider.setItems();
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ListProvider()),
        ChangeNotifierProvider(create: (_) => languageProvider),
        ChangeNotifierProvider(create: (_) => themeProvider),
      ],
      child: const MyApp()),
  );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    LanguageProvider provider=Provider.of(context);
    ThemeProvider themeProvider=Provider.of(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const[
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const[
        Locale("en"),
        Locale("ar")
      ],
      locale: Locale(provider.currentLocale),
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.currentTheme,
      routes: {
        Splash.routeName:(_) => Splash(),
        HomeScreen.routeName:(_) => HomeScreen(),
      },
      initialRoute: Splash.routeName,
    );
  }
}



