import 'package:flutter/material.dart';
import 'package:todo/utils/aap_theme.dart';
import 'package:todo/utils/app_assets.dart';
import 'package:todo/utils/app_colors.dart';

class TaskWidget extends StatelessWidget {
  const TaskWidget({super.key});

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
                Text("Play basket ball",style: AppTheme.textTaskTitle,maxLines: 1,overflow: TextOverflow.ellipsis,),
                SizedBox(height: 8,),
                Row(
                  children: [
                    Icon(Icons.timelapse),
                    Text("10:30 AM",style: AppTheme.numbers,),
                  ],
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 7.38,horizontal: 21.6),
            decoration: BoxDecoration(
              color: AppColors.backgroundBar,
              borderRadius: BorderRadius.circular(10)
            ),
            child: Image.asset(AppAssets.done),
          )
        ],
      ),
    );
  }
}
