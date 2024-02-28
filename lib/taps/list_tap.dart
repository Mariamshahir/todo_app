import 'package:flutter/material.dart';
import 'package:todo/widget/task_widget.dart';

class ListTap extends StatelessWidget {
  const ListTap({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
                Expanded(
                  child: ListView.builder(
                      itemCount:10,
                      itemBuilder: (context,index){
                        return TaskWidget();
                      }),
                )
      ],
    );
  }
}
