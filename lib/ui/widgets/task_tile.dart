import 'package:flutter/material.dart';
import '../size_config.dart';
import '../theme.dart';
import 'text_util.dart';
import 'package:todo/model/task.dart';

class TaskTile extends StatelessWidget {
  TaskTile(this.task);
  final Task task;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(SizeConfig.orientation == Orientation.landscape ? 4.0 : 20.0)),
      width: SizeConfig.orientation == Orientation.landscape ? SizeConfig.screenWidth / 2 : SizeConfig.screenWidth,
      margin: EdgeInsets.only(bottom: getProportionateScreenHeight(12.0)),
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: _getBGClr(task.color),
        ),
        child: Row(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextUtil(
                      title: task.title!,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      //crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.access_time_rounded, color: Colors.grey[200], size: 18),
                        const SizedBox(width: 12),
                        TextUtil(
                          title: '${task.startTime} - ${task.endTime}',
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey[100]!,
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    TextUtil(
                      title: task.note!,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[200]!,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              width: 0.5,
              height: 60,
              color: Colors.grey[200]!.withOpacity(0.7),
            ),
            RotatedBox(
              quarterTurns: 3,
              child: TextUtil(
                title: task.isCompleted == 0 ? 'To Do' : 'Completed',
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _getBGClr(int? color) {
    switch (color) {
      case 0:
        return primaryClr;
      case 1:
        return pinkClr;
      case 2:
        return orangeClr;
      default:
        return primaryClr;
    }
  }
}
