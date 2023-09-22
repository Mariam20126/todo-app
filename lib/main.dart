import 'package:flutter/material.dart';
import 'package:todo_app/home/home_screen.dart';
import 'package:todo_app/my_theme.dart';
import 'package:todo_app/providers/app_config_provider.dart';
import 'package:todo_app/splash_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_app/task_list/edit_task_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

void main() {
  runApp(ChangeNotifierProvider(create: (context) => AppConfigProvider(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
     Future<SharedPreferences> prefs = SharedPreferences.getInstance();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName:(context)=>SplashScreen(),
        HomeScreen.routeName :(context)=>HomeScreen(),
        EditTaskScreen.routeName :(context)=>EditTaskScreen(),
      },
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: MyTheme.lightTheme ,
      darkTheme: MyTheme.darkTheme,
      themeMode: provider.prefs.getString('appTheme') as ThemeMode,
      locale: Locale(provider.prefs.getString('appLanguage')),

    );
  }
}
