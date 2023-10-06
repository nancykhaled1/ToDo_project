import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:project_todo/auth/login/login_screen.dart';
import 'package:project_todo/home/bottom_sheet.dart';
import 'package:project_todo/home/settings_screen/settings_screen.dart';
import 'package:project_todo/home/todo_list_screen/todolist_screen.dart';
import 'package:project_todo/mytheme.dart';
import 'package:provider/provider.dart';

import '../providers/app_config_provider.dart';
import '../providers/auth_provider.dart';

class HomeScreen extends StatefulWidget {
  static const routeNam = 'home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  List<Widget> tabs = [TodoTab(), SettingsTab()];

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(
            '${AppLocalizations.of(context)!.app_title} , ${authProvider.currentUser!.name!}',
            style: provider.appTheme == ThemeMode.light
                ? Theme.of(context).textTheme.titleLarge
                : Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: MyTheme.primaryDarkColor)),
        actions: [
          IconButton(
              onPressed: () {
                provider.tasksList = [];
                authProvider.currentUser = null;
                Navigator.pushReplacementNamed(context, LoginScreen.routeNam);
              },
              icon: Icon(Icons.logout)),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8,
        child: BottomNavigationBar(
          backgroundColor: provider.appTheme == ThemeMode.light
              ? MyTheme.whiteColor
              : MyTheme.darkBlackColor,
          currentIndex: selectedIndex,
          onTap: (index) {
            selectedIndex = index;
            setState(() {});
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: AppLocalizations.of(context)!.todo_list),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: AppLocalizations.of(context)!.settings),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: provider.appTheme == ThemeMode.light
            ? Theme.of(context).primaryColor
            : Theme.of(context).primaryColor,
        onPressed: () {
          showBottomSheet();
        },
        child: Icon(
          Icons.add,
          size: 30,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: tabs[selectedIndex],
    );
  }

  void showBottomSheet() {
    showModalBottomSheet(
        context: context, builder: (context) => ShowBottomSheet());
  }
}
