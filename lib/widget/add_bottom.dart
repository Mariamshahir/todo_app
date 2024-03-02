import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/todo_model.dart';
import 'package:todo/provider/list_provider.dart';
import 'package:todo/utils/aap_theme.dart';
import 'package:todo/utils/app_colors.dart';

class AddBottom extends StatefulWidget {
  const AddBottom({super.key});

  @override
  State<AddBottom> createState() => _AddBottomState();
}

class _AddBottomState extends State<AddBottom> {
  DateTime selectDate = DateTime.now();
  TextEditingController taskController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  late ListProvider listProvider;

  @override
  Widget build(BuildContext context) {
    listProvider=Provider.of(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 22),
      height: MediaQuery.of(context).size.height*0.45,
      color: AppColors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 44,vertical: 38.28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text("Add new Task",textAlign:TextAlign.center,style: AppTheme.title,),
            TextField(
              controller: taskController,
              decoration: InputDecoration(
                labelText: "Enter your task",
                labelStyle: AppTheme.task,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.gray, width: 1.5, style: BorderStyle.solid),
                ),
              ),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: "Enter your description",
                labelStyle: AppTheme.task,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.gray, width: 1.5, style: BorderStyle.solid),
                ),
                ),
            ),

            const SizedBox(height: 33,),
            const Text("Select time",textAlign: TextAlign.start,style: AppTheme.selectTime),
            InkWell(
                onTap: (){ShowMyDate(context);},
                child:  Text("${selectDate.day}/${selectDate.month}/${selectDate.year}",style: AppTheme.time,textAlign: TextAlign.center,)),
            const Spacer(),
            buildElevatedButton()
          ],
        ),
      ),
    );
  }

  ElevatedButton buildElevatedButton() {
    return ElevatedButton(onPressed: (){
      addTodoFirebase();
    }, child: Text("Add",
            style: AppTheme.textTaskTitle.copyWith(color: AppColors.white),),
            style: ElevatedButton.styleFrom(primary: AppColors.backgroundBar,
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),);
  }

  void ShowMyDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light().copyWith(
              primary: AppColors.backgroundBar,
            ),
            textTheme: TextTheme(
              bodyText1: TextStyle(color: AppColors.backgroundBar), // Change font color here
            ),
          ),
          child: child!,
        );
      },
    );
    if (selectedDate != null) {
      setState(() {
        selectDate = selectedDate;
      });
    }
  }
  void addTodoFirebase() {
    CollectionReference todoCollection = FirebaseFirestore.instance.collection("todo");
    todoCollection.doc().set({
      "title" : taskController.text,
      "description" : descriptionController.text,
      "date":selectDate,
      "isDone" : false
    });
  }

}

