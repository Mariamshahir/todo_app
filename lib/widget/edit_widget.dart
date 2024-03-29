import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/todo_model.dart';
import 'package:todo/provider/language_provider.dart';
import 'package:todo/provider/list_provider.dart';
import 'package:todo/provider/theme_provider.dart';
import 'package:todo/utils/aap_theme.dart';
import 'package:todo/utils/app_colors.dart';
import 'package:todo/utils/app_language.dart';

class EditTask extends StatefulWidget {
  static const String routeName = "edittask";

  EditTask({Key? key}) : super(key: key);

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  late DateTime selectDate = DateTime.now();
  final TextEditingController taskController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  late ListProvider listProvider;
  late LanguageProvider languageProvider;
  late ThemeProvider themeProvider;
  final GlobalKey<FormState> formKey = GlobalKey();
  Todo? todo;

  @override
  Widget build(BuildContext context) {
    listProvider = Provider.of<ListProvider>(context);
    languageProvider = Provider.of<LanguageProvider>(context);
    themeProvider = Provider.of<ThemeProvider>(context);

    if (todo == null) {
      todo = ModalRoute.of(context)?.settings.arguments as Todo;
      taskController.text = todo!.task!;
      descriptionController.text = todo!.description!;
      selectDate = todo!.dateTime!;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(context.getLocalizations.toDoList),
      ),
      backgroundColor: themeProvider.background,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  border:
                      Border.all(color: AppColors.backgroundBar, width: 30)),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  width: MediaQuery.of(context).size.width * 0.9,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
                  decoration: BoxDecoration(
                    color: themeProvider.addCart, // Moved color here
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          context.getLocalizations.editTask,
                          textAlign: TextAlign.center,
                          style: themeProvider.text,
                        ),
                        const SizedBox(
                          height: 19.5,
                        ),
                        TextFormField(
                          controller: taskController,
                          validator: (text) {
                            if (text?.isEmpty == true) {
                              return "Please enter a valid task";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: context.getLocalizations.thisIsTitle,
                            labelStyle: AppTheme.task,
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.gray,
                                width: 1.5,
                                style: BorderStyle.solid,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 31.5,
                        ),
                        TextFormField(
                          controller: descriptionController,
                          validator: (text) {
                            if (text?.isEmpty == true) {
                              return "Please enter a valid description";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: context.getLocalizations.editTask,
                            labelStyle: AppTheme.task,
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.gray,
                                width: 1.5,
                                style: BorderStyle.solid,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 33,
                        ),
                        Text(
                          context.getLocalizations.selectTime,
                          textAlign: TextAlign.start,
                          style: themeProvider.selectTime,
                        ),
                        InkWell(
                          onTap: () {
                            showMyDate(context);
                          },
                          child: Text(
                            "${selectDate.day}/${selectDate.month}/${selectDate.year}",
                            style: AppTheme.time,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 90),
                        buildElevatedButton(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ElevatedButton buildElevatedButton() {
    return ElevatedButton(
      onPressed: () async {
        await editTaskFireBase();
      },
      child: Text(
        context.getLocalizations.save,
        style: AppTheme.textTaskTitle.copyWith(color: AppColors.white),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.backgroundBar,
        padding: EdgeInsets.symmetric(vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }

  void showMyDate(BuildContext context) async {
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
            colorScheme: const ColorScheme.light().copyWith(
              primary: AppColors.backgroundBar,
            ),
            textTheme: const TextTheme(
              bodyText1: TextStyle(
                color: AppColors.backgroundBar,
              ),
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

  Future<void> editTaskFireBase() async {
    if (!formKey.currentState!.validate()) return;
    todo!.task = taskController.text;
    todo!.description = descriptionController.text;
    todo!.dateTime != selectDate;
    await listProvider.editTodo(todo!);
    Navigator.pop(context);
  }
}
