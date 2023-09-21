import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:project_todo/mytheme.dart';
import 'package:provider/provider.dart';

import '../../providers/app_config_provider.dart';

class LanguageBottomSheet extends StatefulWidget {
  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              provider.changeTLang(Locale('en'));
            },
            child: provider.appLang == Locale('en')
                ? selectedLang(AppLocalizations.of(context)!.english)
                : unselectedLang(AppLocalizations.of(context)!.english),
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              provider.changeTLang(Locale('ar'));
            },
            child: provider.appLang == Locale('ar')
                ? selectedLang(AppLocalizations.of(context)!.arabic)
                : unselectedLang(AppLocalizations.of(context)!.arabic),
          ),
        ],
      ),
    );
  }

  Widget selectedLang(String text) {
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
            color: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }

  Widget unselectedLang(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}
