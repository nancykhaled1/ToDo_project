import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project_todo/firebase_utils/firebase_utils.dart';
import 'package:project_todo/home/todo_list_screen/edit_task_screen.dart';
import 'package:project_todo/mytheme.dart';
import 'package:provider/provider.dart';

import '../../model/task_data.dart';
import '../../providers/app_config_provider.dart';
import '../../providers/auth_provider.dart';

class ListItem extends StatefulWidget {
  Task task;

  ListItem({required this.task});

  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context);
    var provider = Provider.of<AppConfigProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Slidable(
          startActionPane: ActionPane(
            extentRatio: 0.25,
            motion: const ScrollMotion(),
            dismissible: DismissiblePane(onDismissed: () {}),
            children: [
              SlidableAction(
                onPressed: (context) {
                  ///delete task
                  FirebaseUtils.deleteTaskFromFirestore(
                      widget.task, authProvider.currentUser!.id!)
                      .timeout(Duration(milliseconds: 500), onTimeout: () {
                    Fluttertoast.showToast(
                        msg: "task deleted successfully",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: MyTheme.primaryColor,
                        textColor: Colors.white,
                        fontSize: 16.0);
                    provider.getAllTasksFromFirestore(
                        authProvider.currentUser!.id!);
                  });
                },
                backgroundColor: MyTheme.redColor,
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
              ),
            ],
          ),
          child: InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(EditTaskScreen.routeNam,
                  arguments: widget.task);
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: provider.appTheme == ThemeMode.light
                      ? MyTheme.whiteColor
                      : MyTheme.darkBlackColor),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    width: MediaQuery.of(context).size.width * 0.01,
                    height: MediaQuery.of(context).size.height * 0.1,
                    decoration: BoxDecoration(
                      color: widget.task.isDone!
                          ? MyTheme.greenColor
                          : MyTheme.primaryColor,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.task.title ?? '',
                            style: widget.task.isDone!
                                ? Theme
                                .of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: MyTheme.greenColor)
                                : Theme
                                .of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: MyTheme.primaryColor),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(widget.task.description ?? '',
                            style: provider.appTheme == ThemeMode.light ?
                            Theme
                                .of(context)
                                .textTheme
                                .titleSmall :
                            Theme
                                .of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                color: MyTheme.whiteColor
                            ),

                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      widget.task.isDone = !widget.task.isDone!;
                      FirebaseUtils.updateTask(
                          widget.task, authProvider.currentUser!.id!);
                      setState(() {});
                    },
                    child: widget.task
                        .isDone! // show the "done" text if the task is completed
                        ? Container(
                      margin: EdgeInsets.all(20),
                      padding: EdgeInsets.symmetric(
                          vertical: 5, horizontal: 20),
                      child: Text('Done!',
                          style: Theme
                              .of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                            color: MyTheme.greenColor,
                          )),
                    )
                        : Container(
                      margin: EdgeInsets.all(20),
                      padding: EdgeInsets.symmetric(
                          vertical: 5, horizontal: 20),
                      decoration: BoxDecoration(
                          color: MyTheme.primaryColor,
                          borderRadius: BorderRadius.circular(15)),
                      child: Icon(
                        Icons.check,
                        size: 30,
                        color: MyTheme.whiteColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
