import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/provider/list_provider.dart';
import 'package:todo/provider/theme_provider.dart';
import 'package:todo/utils/aap_theme.dart';
import 'package:todo/utils/app_colors.dart';
import 'package:todo/models/todo_model.dart';
import 'package:todo/utils/app_language.dart';
import 'package:todo/widget/edit_widget.dart';

class TaskWidget extends StatefulWidget {
  final Todo todo;

  const TaskWidget({Key? key, required this.todo}) : super(key: key);

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  late DateTime dateTime = widget.todo.dateTime ?? DateTime.now();
  late String date = "${dateTime.day}/${dateTime.month}/${dateTime.year}";
  late ThemeProvider themeProvider;
  late ListProvider listProvider;

  @override
  Widget build(BuildContext context) {
    themeProvider = Provider.of<ThemeProvider>(context);
    listProvider = Provider.of(context);
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, EditTask.routeName,
            arguments: widget.todo);
      },
      child: Container(
        decoration: BoxDecoration(
            color: themeProvider.cart, borderRadius: BorderRadius.circular(15)),
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 18),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: widget.todo.isDone!
                      ? AppColors.green
                      : AppColors.backgroundBar,
                  borderRadius: BorderRadius.circular(10)),
              height: 62,
              width: 4,
            ),
            const SizedBox(
              width: 25,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.todo.task ?? "",
                    style: widget.todo.isDone!
                        ? AppTheme.textTaskTitle
                            .copyWith(color: AppColors.green)
                        : AppTheme.textTaskTitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.timelapse,
                        color: themeProvider.icon,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        date,
                        style: themeProvider.numbertext,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          widget.todo.description ?? "",
                          style: themeProvider.numbertext,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () async{
                await toggleDone();
              },
              onTapDown: (_) {
                setState(() {
                  widget.todo.isDone = true;
                });
              },
              onTapUp: (_) {
                setState(() {
                  widget.todo.isDone = true;
                });
              },
              onDoubleTapCancel: () {
                setState(() {
                  widget.todo.isDone = false;
                  listProvider.updateIsDone(widget.todo, true);
                });
              },
              onTapCancel: () {
                setState(() {
                  widget.todo.isDone = false;
                });
              },
              child: buildisDoneBotton(context),
            ),
          ],
        ),
      ),
    );
  }

  Container buildisDoneBotton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7.38, horizontal: 21.6),
      decoration: BoxDecoration(
        color: widget.todo.isDone! ? AppColors.green : AppColors.backgroundBar,
        borderRadius: BorderRadius.circular(10),
      ),
      child: widget.todo.isDone!
          ? Text(
              context.getLocalizations.done,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            )
          : const Icon(
              Icons.done_sharp,
              size: 30,
              color: Colors.white,
            ),
    );
  }

  Future<void> toggleDone() async{
    await listProvider.updateIsDone(widget.todo, !widget.todo.isDone!);
  }
}
