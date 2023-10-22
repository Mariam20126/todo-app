import 'package:flutter/material.dart';
import 'package:todo_app/my_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/app_config_provider.dart';

class EditTaskScreen extends StatefulWidget {
  static const String routeName = 'edit_task_screen';

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  @override
  var formKey=GlobalKey<FormState>();
  DateTime selectedDate =DateTime.now();
  Widget build(BuildContext context) {
    String taskTitle='';
    String taskDescription ='';
    var provider = Provider.of<AppConfigProvider>(context);
    DataOfTask args=ModalRoute.of(context)?.settings.arguments as DataOfTask;
    return
      Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.all(25),
            child: Text(
              AppLocalizations.of(context)!.to_do_list,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ),
        body: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(left: 20,right: 20,top: 6,bottom: 50),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                  color: provider.isDarkMood() ?
                  MyTheme.darkBlack
                      :
                  MyTheme.whiteColor
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(AppLocalizations.of(context)!.edit_task,
                        style: Theme.of(context).textTheme.titleMedium,),
                    ),
                    Form(key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              onChanged: (text){
                                taskTitle=text;
                              },
                              decoration: InputDecoration(label: Text(
                                args.title1,
                                style: TextStyle(color:provider.isDarkMood() ?
                                MyTheme.whiteColor
                                    :
                                MyTheme.blackColor

                                ),
                              )),

                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              onChanged: (text){
                                taskDescription=text;
                              },
                              decoration: InputDecoration(label: Text(
                                args.desc1,
                                style: TextStyle(color:provider.isDarkMood() ?
                                MyTheme.whiteColor
                                    :
                                MyTheme.blackColor

                                ),
                              )),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(AppLocalizations.of(context)!.select_date,
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              showCalender();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                                style: Theme.of(context).textTheme.titleSmall,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(40.0),
                            child: ElevatedButton(
                              onPressed: (){
                                addTask();
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Text(AppLocalizations.of(context)!.save_changes,
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ),
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    // Change your radius here
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                              ),
                            ),
                          ),

                  ],
                ),
            )
          ],
        ),
              ),
    )]));
  }

  void showCalender() async{
    var chooseDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365))
    );
    if(chooseDate!=null){
      selectedDate=chooseDate;
      setState(() {

      });
    }
  }

  void addTask() {
    if(formKey.currentState?.validate()==true){

    }
  }
}
class DataOfTask{
  String title1;
  String desc1;
  DataOfTask({required this.title1,required this.desc1});
}