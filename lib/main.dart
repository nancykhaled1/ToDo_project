import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:project_todo/home/home_screen.dart';
import 'package:project_todo/home/todo_list_screen/edit_task_screen.dart';
import 'package:project_todo/mytheme.dart';
import 'package:project_todo/providers/app_config_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => AppConfigProvider(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: HomeScreen.routeNam,
      routes: {
        HomeScreen.routeNam: (context) => HomeScreen(),
        EditTaskScreen.routeNam: (context) => EditTaskScreen()
      },
      theme: MyTheme.LightMode,
      darkTheme: MyTheme.DarkMode,
      themeMode: provider.appTheme,
      locale: provider.appLang,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}