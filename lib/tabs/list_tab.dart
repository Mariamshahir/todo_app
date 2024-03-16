import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/todo_model.dart';
import 'package:todo/provider/language_provider.dart';
import 'package:todo/provider/list_provider.dart';
import 'package:todo/provider/theme_provider.dart';
import 'package:todo/utils/app_colors.dart';
import 'package:todo/utils/app_language.dart';
import 'package:todo/widget/task_widget.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';

class ListTab extends StatefulWidget {
  const ListTab({super.key});

  @override
  State<ListTab> createState() => _ListTabState();
}

class _ListTabState extends State<ListTab> {
  late ListProvider listProvider;
  List<Todo> todos = [];
  late LanguageProvider provider;
  late ThemeProvider themeProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      listProvider.refreshTodo();
    });
  }

  @override
  Widget build(BuildContext context) {
    listProvider = Provider.of<ListProvider>(context);
    themeProvider = Provider.of<ThemeProvider>(context);

    return Column(
      children: [
        buildEasyInfiniteDateTimeLine(),
        Expanded(
          child: ListView.builder(
            itemCount: listProvider.todos.length,
            itemBuilder: (context, index) {
              return Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 22),
                child: Slidable(
                  direction: Axis.horizontal,
                  startActionPane: ActionPane(
                      openThreshold: 0.5,
                      closeThreshold: 0.8,
                      dragDismissible: false,
                      motion: const StretchMotion(),
                      children: [
                        SlidableAction(
                          spacing: 9,
                          borderRadius: BorderRadius.circular(20),
                          backgroundColor: AppColors.red,
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: context.getLocalizations.delete,
                          onPressed: (BuildContext context) {
                            deleteTodo(listProvider.todos[index]);
                          },
                        ),
                      ]),
                  child: Container(
                    child: TaskWidget(
                      todo: listProvider.todos[index],
                    ),
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }

  Widget buildEasyInfiniteDateTimeLine() {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, _) {
        String selectLanguage = languageProvider.currentLocale;
        return Stack(
          children: [
            Positioned.fill(
              child: Column(
                children: [
                  Expanded(
                      child: Container(
                    color: AppColors.backgroundBar,
                  )),
                  const Spacer(),
                ],
              ),
            ),
            EasyInfiniteDateTimeLine(
              locale: selectLanguage,
              firstDate: DateTime.now().subtract(Duration(days: 365)),
              focusDate: listProvider.selectedDate,
              lastDate: DateTime.now().add(Duration(days: 365)),
              onDateChange: (selectedDate) {
                listProvider.onDateSelected(selectedDate);
              },
              dayProps: const EasyDayProps(height: 90, width: 60),
              itemBuilder: (context, dayNumber, dayName, monthName, fullDate,
                  isSelected) {
                return Card(
                  elevation: isSelected ? 20 : 0,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: themeProvider.cart),
                    child: Column(
                      children: [
                        const Spacer(),
                        Text(monthName,
                            style: TextStyle(
                                color: isSelected
                                    ? AppColors.backgroundBar
                                    : themeProvider.calender,
                                fontWeight: FontWeight.bold,
                                fontSize: 15)),
                        const Spacer(),
                        Text(dayNumber,
                            style: TextStyle(
                                color: isSelected
                                    ? AppColors.backgroundBar
                                    : themeProvider.calender,
                                fontWeight: FontWeight.bold,
                                fontSize: 15)),
                        const Spacer(),
                        Text(dayName,
                            style: TextStyle(
                                color: isSelected
                                    ? AppColors.backgroundBar
                                    : themeProvider.calender,
                                fontWeight: FontWeight.bold,
                                fontSize: 15)),
                        const Spacer(),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  void deleteTodo(Todo todo) {
    listProvider.removeTodo(todo);
  }
}
