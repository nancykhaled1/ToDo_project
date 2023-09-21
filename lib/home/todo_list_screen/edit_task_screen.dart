import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:project_todo/mytheme.dart';
import 'package:provider/provider.dart';

import '../../providers/app_config_provider.dart';

class EditTaskScreen extends StatefulWidget {
  static const routeNam = 'edit_task';

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  DateTime selectedDate = DateTime.now();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.app_title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.all(15),
            margin: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.width * 0.15,
                horizontal: MediaQuery.of(context).size.width * 0.1),

            /// width: double.infinity,
            decoration: BoxDecoration(
                color: provider.appTheme == ThemeMode.light
                    ? MyTheme.whiteColor
                    : MyTheme.darkBlackColor,
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: [
                Text(
                  AppLocalizations.of(context)!.edittask,
                  style: provider.appTheme == ThemeMode.light
                      ? Theme.of(context).textTheme.titleMedium
                      : Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: MyTheme.whiteColor),
                ),
                SizedBox(
                  height: 30,
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
                              return AppLocalizations.of(context)!
                                  .pleaseentertask;
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
                              ? Theme.of(context).textTheme.titleMedium
                              : Theme.of(context)
                                  .textTheme
                                  .titleMedium!
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
                      Container(
                        margin: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.width * 0.3,
                          horizontal: MediaQuery.of(context).size.height * 0.01,
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            addTask();
                            setState(() {});
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              AppLocalizations.of(context)!.savechanges,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    color: MyTheme.whiteColor,
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )),
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
