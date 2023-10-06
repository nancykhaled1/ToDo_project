import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:project_todo/dialog_utils.dart';
import 'package:project_todo/firebase_utils/firebase_utils.dart';
import 'package:project_todo/model/task_data.dart';
import 'package:project_todo/mytheme.dart';
import 'package:provider/provider.dart';

import '../providers/app_config_provider.dart';
import '../providers/auth_provider.dart';

class ShowBottomSheet extends StatefulWidget {
  @override
  State<ShowBottomSheet> createState() => _ShowBottomSheetState();
}

class _ShowBottomSheetState extends State<ShowBottomSheet> {
  DateTime selectedDate = DateTime.now();
  var formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';
  late AppConfigProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AppConfigProvider>(context);
    var authProvider = Provider.of<AuthProvider>(context);

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
                      onChanged: (text) {
                        title = text;
                      },
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
                      onChanged: (text) {
                        description = text;
                      },
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
      initialDate: selectedDate,
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
      Task task =
          Task(dateTime: selectedDate, title: title, description: description);
      DialogUtils.showLoading(context, 'Loading...');
      var authProvider = Provider.of<AuthProvider>(context, listen: false);
      FirebaseUtils.addTaskToFireStore(task, authProvider.currentUser!.id!)
          .then((value) {
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(context, 'Task added successfully',
            posActionName: 'Ok', posAction: () {
          Navigator.pop(context);
        });
      }).timeout(Duration(milliseconds: 500), onTimeout: () {
        print('task added successfully');
        provider.getAllTasksFromFirestore(authProvider.currentUser!.id!);
        Navigator.of(context).pop();
      });
    }
  }
}
