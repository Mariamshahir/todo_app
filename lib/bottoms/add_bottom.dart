import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/todo_model.dart';
import 'package:todo/provider/language_provider.dart';
import 'package:todo/provider/list_provider.dart';
import 'package:todo/utils/aap_theme.dart';
import 'package:todo/utils/app_colors.dart';
import 'package:todo/utils/app_language.dart';

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
  late LanguageProvider languageProvider;
  @override
  Widget build(BuildContext context) {
    listProvider=Provider.of(context);
    languageProvider=Provider.of(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 22),
      height: MediaQuery.of(context).size.height*0.45,
      color: AppColors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 44,vertical: 38.28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(context.getLocalizations.addNewTask,textAlign:TextAlign.center,style: AppTheme.title,),
            TextField(
              controller: taskController,
              decoration: InputDecoration(
                labelText: context.getLocalizations.enterYourTask,
                labelStyle: AppTheme.task,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.gray, width: 1.5, style: BorderStyle.solid),
                ),
              ),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: context.getLocalizations.enterYourDescription,
                labelStyle: AppTheme.task,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.gray, width: 1.5, style: BorderStyle.solid),
                ),
                ),
            ),

            const SizedBox(height: 33,),
             Text(context.getLocalizations.selectTime,textAlign: TextAlign.start,style: AppTheme.selectTime),
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
    return ElevatedButton(onPressed: () async{
      await addTodoFirebase();
    }, child: Text(context.getLocalizations.add,
      style: AppTheme.textTaskTitle.copyWith(color: AppColors.white),),
      style: ElevatedButton.styleFrom(backgroundColor: AppColors.backgroundBar,
          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),);
  }

  void ShowMyDate(BuildContext context) async {
    Locale selectLanguage = Locale(languageProvider.currentLocale);
    DateTime? selectedDate = await showDatePicker(
      locale: selectLanguage,
      context: context,
      initialDate: selectDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light().copyWith(
              primary: AppColors.backgroundBar,
            ),
            textTheme: TextTheme(
              bodyLarge: TextStyle(color: AppColors.backgroundBar), // Change font color here
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

  Future<void> addTodoFirebase() async{
    CollectionReference todoCollection = FirebaseFirestore.instance.collection(Todo.collectionName);
    DocumentReference doc =todoCollection.doc();
    await doc.set({
      "id" : doc.id,
      "title" : taskController.text,
      "description" : descriptionController.text,
      "date":Timestamp.fromDate(selectDate),
      "isDone" : false
    }).timeout(Duration(milliseconds: 300),onTimeout: () async{
      await listProvider.refreshTodo();
      Navigator.pop(context);
    });
  }
}

