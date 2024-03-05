import 'package:flutter/material.dart';
import 'package:todo/utils/aap_theme.dart';
import 'package:todo/utils/app_assets.dart';
import 'package:todo/utils/app_colors.dart';
import 'package:todo/models/todo_model.dart';

class TaskWidget extends StatefulWidget {
  final Todo todo;
  const TaskWidget({super.key, required this.todo});

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  late DateTime dateTime = widget.todo.dateTime??DateTime.now();
  late String date = "${dateTime.day}/${dateTime.month}/${dateTime.year}";
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(15)
      ),
      margin: const EdgeInsets.symmetric(vertical: 22,horizontal: 30),
      padding: const EdgeInsets.symmetric(vertical: 24,horizontal: 18),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
                color: AppColors.backgroundBar,
                borderRadius: BorderRadius.circular(10)
            ),
            height: 62,
            width: 4,
          ),
          const SizedBox(width: 25,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.todo.task?? "",
                  style: AppTheme.textTaskTitle,maxLines: 1,overflow: TextOverflow.ellipsis,),
                const SizedBox(height: 8,),
                Row(
                  children: [
                    const Icon(Icons.timelapse),
                    const SizedBox(width: 5,),
                    Text(date,style: AppTheme.numbers,),
                    const SizedBox(width: 10,),
                    Text(widget.todo.description?? "",style: AppTheme.numbers,)
                  ],
                )
              ],
            ),
          ),
          InkWell(
            onTap: (){},
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 7.38,horizontal: 21.6),
              decoration: BoxDecoration(
                color: AppColors.backgroundBar,
                borderRadius: BorderRadius.circular(10)
              ),
              child: Image.asset(AppAssets.done),
            ),
          )
        ],
      ),
    );
  }
}
