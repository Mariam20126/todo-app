import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_app/my_theme.dart';
import 'package:todo_app/providers/app_config_provider.dart';
import 'package:provider/provider.dart';

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  DateTime selectedDate =DateTime.now();
  var formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            Text(AppLocalizations.of(context)!.add_new_task,
              style: Theme.of(context).textTheme.titleMedium,),
            Form(key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(

                        validator: (text) {
                          if(text==null||text.isEmpty){
                            return AppLocalizations.of(context)!.please_enter_the_task_title;
                          }
                          return null ;
                        },
                        decoration: InputDecoration(label: Text(
                          AppLocalizations.of(context)!.enter_task_title,
                          style: TextStyle(color:provider.isDarkMood() ?
                          MyTheme.whiteColor
                              :
                          MyTheme.blackColor

                          ),
                        )
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        validator: (text) {
                          if(text==null||text.isEmpty){
                            return AppLocalizations.of(context)!.please_enter_the_task_describtion;
                          }
                          return null ;
                        },
                        decoration: InputDecoration(label: Text(
                          AppLocalizations.of(context)!.enter_task_descrition,
                          style: TextStyle(color:provider.isDarkMood() ?
                          MyTheme.whiteColor
                              :
                          MyTheme.blackColor

                          ),
                        )),
                        maxLines: 5,
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
                    ElevatedButton(
                        onPressed: (){
                          addTask();
                        },
                        child: Text(AppLocalizations.of(context)!.add,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                    ),
                  ],
                )
            ),
          ],
        ),
      ),
    );
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
