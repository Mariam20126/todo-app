import 'package:flutter/material.dart';
import 'package:todo_app/home/home_screen.dart';
import 'package:todo_app/my_theme.dart';
import 'package:todo_app/providers/app_config_provider.dart';
import 'package:todo_app/splash_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_app/task_list/edit_task_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => AppConfigProvider(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
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
      locale: Locale(provider.appLanguage),
      themeMode: provider.appTheme,
      darkTheme: MyTheme.darkTheme,
    );
  }
}
