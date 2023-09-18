import 'package:flutter/material.dart';

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
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            Text('Add New Task',style: Theme.of(context).textTheme.titleMedium,),
            Form(key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        validator: (text) {
                          if(text==null||text.isEmpty){
                            return 'please enter the task title';
                          }
                          return null ;
                        },
                        decoration: InputDecoration(label: Text('Enter Task Title')),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        validator: (text) {
                          if(text==null||text.isEmpty){
                            return 'please enter the task describtion';
                          }
                          return null ;
                        },
                        decoration: InputDecoration(label: Text('Enter Task Describtion')),
                        maxLines: 5,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Select Date',
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
                        child: Text('Add',
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
