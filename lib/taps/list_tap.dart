import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/todo_model.dart';
import 'package:todo/provider/list_provider.dart';
import 'package:todo/utils/app_colors.dart';
import 'package:todo/widget/task_widget.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';

class ListTap extends StatefulWidget {
  const ListTap({super.key});

  @override
  State<ListTap> createState() => _ListTapState();
}

class _ListTapState extends State<ListTap> {
  late ListProvider listProvider;
  List<Todo> todos=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      listProvider.refreshTodo();});
  }

  @override
  Widget build(BuildContext context) {
    listProvider=Provider.of(context);
    return Column(
      children: [
        buildEasyInfiniteDateTimeLine(),
                Expanded(
                  child: ListView.builder(
                      itemCount:todos.length,
                      itemBuilder: (context,index){
                        return TaskWidget(todo: todos[index],);
                      }),
                )
      ],
    );
  }

  Widget buildEasyInfiniteDateTimeLine() {
    return Stack(
      children: [
        Positioned.fill(
          child: Column(
            children: [
              Expanded(child: Container(color: AppColors.backgroundBar,)),
              Spacer(),
            ],
          ),
        ),
        EasyInfiniteDateTimeLine(
          firstDate: DateTime.now().subtract(Duration(days: 365)),
          focusDate: listProvider.selectedDate,
          lastDate: DateTime.now().add(Duration(days: 365)),
          onDateChange: (selectedDate) {
            listProvider.onDateSelected(selectedDate);
          },
          dayProps: EasyDayProps(height: 90,width: 60),
          itemBuilder: (context,dayNumber,dayName,monthName,fullDate,isSelected){
            return Card(
              elevation: isSelected ? 20 : 0,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: AppColors.white),
                child: Column(
                  children: [
                    Spacer(),
                    Text(monthName,style: TextStyle(color: isSelected ? AppColors.backgroundBar : AppColors.black,fontWeight: FontWeight.bold,fontSize: 15)),
                    Spacer(),
                    Text(dayNumber,style: TextStyle(color: isSelected ? AppColors.backgroundBar : AppColors.black,fontWeight: FontWeight.bold,fontSize: 15)),
                    Spacer(),
                    Text(dayName,style: TextStyle(color: isSelected ? AppColors.backgroundBar : AppColors.black,fontWeight: FontWeight.bold,fontSize: 15)),
                    Spacer(),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
