import 'package:flutter/material.dart';
import 'package:todo_app/my_theme.dart';
import 'package:todo_app/providers/app_config_provider.dart';
import 'package:todo_app/settings/settings.dart';
import 'package:todo_app/task_list/add_task_bottom_sheet.dart';
import 'package:todo_app/task_list/task_list.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex =0;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(25),
          child: Text(
            AppLocalizations.of(context)!.to_do_list,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
      notchMargin: 8,
      child:BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index){
          selectedIndex=index;
          setState(() {

          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.list), label:
          AppLocalizations.of(context)!.task_list,
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label:
          AppLocalizations.of(context)!.settings,
          ),
        ],
      )),
      floatingActionButton: FloatingActionButton(
        shape: StadiumBorder(
            side: BorderSide(width: 6, color:provider.isDarkMood()
                ?
            MyTheme.darkBlack:
            MyTheme.whiteColor)),
        onPressed: () {
          showAddTaskBottomSheet();
        },
        child: Icon(
          Icons.add,
          size: 30,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: tabs[selectedIndex],
    );
  }
  List<Widget>tabs=[
    TaskListTab(),SettingsTab()
  ];

  void showAddTaskBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context)=>AddTaskBottomSheet(),
    );
  }
}
