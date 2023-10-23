import 'package:flutter/material.dart';
import 'package:todo_app/firebase_utils.dart';
import 'package:todo_app/model/task.dart';
import 'package:todo_app/my_theme.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_app/providers/app_config_provider.dart';
import 'package:todo_app/task_list/edit_task_screen.dart';
import 'package:provider/provider.dart';
class TaskWidget extends StatefulWidget {
  Task task;
  TaskWidget({required this.task});
  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}
class _TaskWidgetState extends State<TaskWidget> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Container(
      margin: EdgeInsets.all(12),
      child:
      Slidable(
        startActionPane: ActionPane(
          extentRatio: .25,
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              borderRadius: BorderRadius.circular(20),
              onPressed: (context) {
                FireBaseUtils.deleteTaskFromFireStore(widget.task)
                    .timeout(Duration(milliseconds: 500), onTimeout: () {
                  print('todo deleted');
                  provider.getAllTasksFromFirestore();
                });
              },
              backgroundColor: MyTheme.redColor,
              foregroundColor: MyTheme.whiteColor,
              icon: Icons.delete,
              label: AppLocalizations.of(context)!.delete,
            ),
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: provider.isDarkMood()
                  ? MyTheme.darkBlack
                  : MyTheme.whiteColor),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                color:widget.task.isDone!?MyTheme.greenLight: Theme.of(context).primaryColor,
                height: 80,
                width: 6,
              ),
              Expanded(
                  child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, EditTaskScreen.routeName,arguments: widget.task);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.task.title ?? '',
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(color:widget.task.isDone!?MyTheme.greenLight: Theme.of(context).primaryColor),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(widget.task.description ?? '',
                          style: Theme.of(context).textTheme.titleSmall),
                    ),
                  ],
                ),
              )),
              InkWell(
                onTap:(){
                  widget.task.isDone=!widget.task.isDone!;
                  FireBaseUtils.editIsDone(widget.task);
                  setState(() {
                  });
                } ,
                child: widget.task.isDone!?
                    Text('IsDone!',style: TextStyle(
                      color: MyTheme.greenLight,
                      fontWeight:FontWeight.bold ,
                      fontSize: 22
                    ),)
                    :
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 21, vertical: 7),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Icon(
                    Icons.check,
                    size: 35,
                    color: MyTheme.whiteColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
