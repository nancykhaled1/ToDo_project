import 'package:flutter/material.dart';
import 'package:project_todo/home/home_screen.dart';
import 'package:project_todo/home/todo_list_screen/edit_task_screen.dart';
import 'package:project_todo/mytheme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: HomeScreen.routeNam,
        routes: {
          HomeScreen.routeNam: (context) => HomeScreen(),
          EditTaskScreen.routeNam: (context) => EditTaskScreen()
        },
        theme: MyTheme.LightMode);
  }
}