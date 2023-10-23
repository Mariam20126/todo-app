import 'package:flutter/material.dart';
import 'package:todo_app/firebase_utils.dart';
import 'package:todo_app/model/task.dart';
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
  late Task task;
  late AppConfigProvider provider1;
  var TitleController=TextEditingController();
  var DescriptionController =TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      task=ModalRoute.of(context)!.settings.arguments as Task;
      TitleController.text=task.title!;
      DescriptionController.text=task.description!;
      selectedDate=task.dateTime!;

    });
  }
  @override
  var formKey=GlobalKey<FormState>();

  DateTime selectedDate =DateTime.now();
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    provider1=Provider.of<AppConfigProvider>(context);
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
                              controller: TitleController,
                              decoration: InputDecoration(hintText: 'Enter Task Title'),

                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: DescriptionController,
                              decoration: InputDecoration(hintText: 'Enter Task Describtion'),
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
                                editTask();
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

  void editTask() {
    if(formKey.currentState?.validate()==true){
      task.title=TitleController.text;
      task.description=DescriptionController.text;
      task.dateTime=selectedDate;
      FireBaseUtils.editTask(task).
      timeout(
          Duration(milliseconds: 500),onTimeout: (){
        print('todo added successfully');
        provider1.getAllTasksFromFirestore();
        Navigator.pop(context);
      }
      );

    }
  }
}
