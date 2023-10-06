import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:project_todo/home/home_screen.dart';
import 'package:project_todo/home/todo_list_screen/edit_task_screen.dart';
import 'package:project_todo/mytheme.dart';
import 'package:project_todo/providers/app_config_provider.dart';
import 'package:project_todo/providers/auth_provider.dart';
import 'package:provider/provider.dart';

import 'auth/login/login_screen.dart';
import 'auth/register/register_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => AppConfigProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => AuthProvider(),
      )
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: RegisterScreen.routeNam,

      ///HomeScreen.routeNam,
      routes: {
        HomeScreen.routeNam: (context) => HomeScreen(),
        EditTaskScreen.routeNam: (context) => EditTaskScreen(),
        RegisterScreen.routeNam: (context) => RegisterScreen(),
        LoginScreen.routeNam: (context) => LoginScreen()
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