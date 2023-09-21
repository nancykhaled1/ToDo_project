import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:project_todo/mytheme.dart';
import 'package:provider/provider.dart';

import '../../providers/app_config_provider.dart';
import 'List_item.dart';

class TodoTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Container(
      child: Column(
        children: [
          CalendarTimeline(
            initialDate: DateTime.now(),
            firstDate: DateTime.now().subtract(Duration(days: 365)),
            lastDate: DateTime.now().add(Duration(days: 365)),
            onDateSelected: (date) => print(date),
            leftMargin: 20,
            monthColor: provider.appTheme == ThemeMode.light
                ? MyTheme.blackColor
                : MyTheme.whiteColor,
            dayColor: provider.appTheme == ThemeMode.light
                ? MyTheme.blackColor
                : MyTheme.whiteColor,
            activeDayColor: Colors.white,
            activeBackgroundDayColor: provider.appTheme == ThemeMode.light
                ? Theme.of(context).primaryColor
                : Theme.of(context).primaryColorDark,
            dotsColor: MyTheme.whiteColor,
            locale: 'en_ISO',
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) => ListItem(),
              itemCount: 20,
            ),
          )
        ],
      ),
    );
  }
}

