import 'package:flutter/material.dart';
import 'package:todo_app/my_theme.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_app/providers/app_config_provider.dart';
import 'package:todo_app/task_list/edit_task_screen.dart';
import 'package:provider/provider.dart';


class TaskWidget extends StatelessWidget {
  const TaskWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);

    return
      Slidable(
      startActionPane: ActionPane(
        extentRatio: .25,
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            borderRadius: BorderRadius.circular(20),
            onPressed: (context) {},
            backgroundColor: MyTheme.redColor,
            foregroundColor: MyTheme.whiteColor,
            icon: Icons.delete,
            label: AppLocalizations.of(context)!.delete,
          ),
        ],
      ),
      child:
      InkWell(
        onTap: (){
          Navigator.of(context).pushNamed(EditTaskScreen.routeName);
        },
        child: Container(
          margin: EdgeInsets.all(12),
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15), color:provider.isDarkMood() ?
          MyTheme.darkBlack
          :
          MyTheme.whiteColor
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                color: Theme.of(context).primaryColor,
                height: 80,
                width: 6,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      AppLocalizations.of(context)!.task_title,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(color: Theme.of(context).primaryColor),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(AppLocalizations.of(context)!.desc,
                        style: Theme.of(context).textTheme.titleSmall),
                  ),
                ],
              )),
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
            ],
          ),
        ),
      ),
    );
  }
}
