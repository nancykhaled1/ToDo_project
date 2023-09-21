import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:project_todo/mytheme.dart';
import 'package:provider/provider.dart';

import '../providers/app_config_provider.dart';

class ShowBottomSheet extends StatefulWidget {
  @override
  State<ShowBottomSheet> createState() => _ShowBottomSheetState();
}

class _ShowBottomSheetState extends State<ShowBottomSheet> {
  DateTime selectedDate = DateTime.now();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Container(
      color: provider.appTheme == ThemeMode.light
          ? MyTheme.whiteColor
          : MyTheme.darkBlackColor,
      padding: EdgeInsets.all(15),
      child: Column(
        children: [
          Text(
            AppLocalizations.of(context)!.addnewtask,
            style: provider.appTheme == ThemeMode.light
                ? Theme.of(context).textTheme.titleMedium
                : Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: MyTheme.whiteColor),
          ),
          Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (String? value) {
                        if (value!.isEmpty || value == null) {
                          return AppLocalizations.of(context)!.pleaseentertask;
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.entertask,
                        hintStyle: provider.appTheme == ThemeMode.light
                            ? Theme.of(context).textTheme.titleMedium
                            : Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(color: MyTheme.whiteColor),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (String? value) {
                        if (value!.isEmpty || value == null) {
                          return AppLocalizations.of(context)!
                              .pleaseentertaskdescription;
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        hintText:
                            AppLocalizations.of(context)!.enterdescription,
                        hintStyle: provider.appTheme == ThemeMode.light
                            ? Theme.of(context).textTheme.titleMedium
                            : Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(color: MyTheme.whiteColor),
                      ),
                      maxLines: 4,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      AppLocalizations.of(context)!.selectdate,
                      style: provider.appTheme == ThemeMode.light
                          ? Theme.of(context).textTheme.titleSmall
                          : Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(color: MyTheme.whiteColor),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        showDate();
                      },
                      child: Text(
                        '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                        style: provider.appTheme == ThemeMode.light
                            ? Theme.of(context).textTheme.titleSmall
                            : Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(color: MyTheme.whiteColor),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        addTask();
                        setState(() {});
                      },
                      child: Text(
                          AppLocalizations.of(context)!.add,
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    color: MyTheme.whiteColor,
                                  ))),
                ],
              ))
        ],
      ),
    );
  }

  void showDate() async {
    var chosenDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(Duration(days: 365)),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (chosenDate != null) {
      selectedDate = chosenDate;
    }

    setState(() {});
  }

  void addTask() {
    if (formKey.currentState!.validate() == true) {
      /// add task to firebase
    }
  }
}
