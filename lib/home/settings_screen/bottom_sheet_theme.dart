import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:project_todo/mytheme.dart';
import 'package:provider/provider.dart';

import '../../providers/app_config_provider.dart';

class ThemeBottomSheet extends StatefulWidget {
  @override
  State<ThemeBottomSheet> createState() => _ThemeBottomSheetState();
}

class _ThemeBottomSheetState extends State<ThemeBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              provider.changeTheme(ThemeMode.light);
            },
            child: provider.appTheme == ThemeMode.light
                ? selectedTheme(AppLocalizations.of(context)!.light)
                : unselectedTheme(AppLocalizations.of(context)!.light),
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              provider.changeTheme(ThemeMode.dark);
            },
            child: provider.appTheme == ThemeMode.dark
                ? selectedTheme(AppLocalizations.of(context)!.dark)
                : unselectedTheme(AppLocalizations.of(context)!.dark),
          ),
        ],
      ),
    );
  }

  Widget selectedTheme(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(
            text,
            style: Theme.of(context as BuildContext)
                .textTheme
                .titleMedium!
                .copyWith(color: MyTheme.primaryColor),
          ),
          Icon(
            Icons.check,
            color: Theme.of(context as BuildContext).primaryColor,
          ),
        ],
      ),
    );
  }

  Widget unselectedTheme(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: Theme.of(context as BuildContext).textTheme.titleMedium,
      ),
    );
  }
}
