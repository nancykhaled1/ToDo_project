import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:project_todo/mytheme.dart';
import 'package:provider/provider.dart';

import '../../providers/app_config_provider.dart';
import 'bottom_sheet_language.dart';
import 'bottom_sheet_theme.dart';

class SettingsTab extends StatefulWidget {
  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);

    return Container(
      margin: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.width * 0.15,
        horizontal: MediaQuery.of(context).size.height * 0.02,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            AppLocalizations.of(context)!.theming,
            style: provider.appTheme == ThemeMode.light
                ? Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: MyTheme.blackColor)
                : Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: MyTheme.whiteColor),
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              showThemeSheet();
            },
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    provider.appTheme == ThemeMode.light
                        ? AppLocalizations.of(context)!.light
                        : AppLocalizations.of(context)!.dark,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            AppLocalizations.of(context)!.language,
            style: provider.appTheme == ThemeMode.light
                ? Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: MyTheme.blackColor)
                : Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: MyTheme.whiteColor),
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              showLanguageSheet();
            },
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    provider.appLang == Locale('en')
                        ? AppLocalizations.of(context)!.english
                        : AppLocalizations.of(context)!.arabic,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showThemeSheet() {
    showModalBottomSheet(
        context: context, builder: (context) => ThemeBottomSheet());
  }

  void showLanguageSheet() {
    showModalBottomSheet(
        context: context, builder: (context) => LanguageBottomSheet());
  }
}
