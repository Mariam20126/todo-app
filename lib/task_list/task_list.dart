import 'package:flutter/material.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:todo_app/my_theme.dart';
import 'package:todo_app/task_list/task_widget.dart';
class TaskListTab extends StatelessWidget {
  const TaskListTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CalendarTimeline(
          initialDate: DateTime.now(),
          firstDate: DateTime.now().subtract(Duration(days: 365)),
          lastDate: DateTime.now().add(Duration(days: 365)),
          onDateSelected: (date) => print(date),
          leftMargin: 20,
          monthColor: MyTheme.blackColor,
          dayColor: MyTheme.blackColor,
          activeDayColor: Theme.of(context).primaryColor,
          activeBackgroundDayColor: MyTheme.greenLight,
          dotsColor: Color(0xFF333A47),
          selectableDayPredicate: (date) => true,
          locale: 'en_ISO',
        ),
        Expanded(
          child: ListView.builder(
              itemBuilder: (context,index){
                return TaskWidget();
              },
            itemCount: 20,
          ),
        ),
      ],
    );
  }
}
