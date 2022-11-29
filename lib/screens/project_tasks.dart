import 'package:flutter/material.dart';
import 'package:project_task/utils/app_utils.dart';

import '../models/task_data.dart';

class ProjectTaskList extends StatelessWidget {
  final List<TaskData> taskList;

  const ProjectTaskList({required this.taskList, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: ListView.builder(
          itemCount: taskList.length,
          itemBuilder: (context, index) {
            return _buildTaskData(index, Theme.of(context));
          }),
    );
  }

  Widget _buildTaskData(int index, ThemeData themeData) {
    TaskData taskData = taskList[index];
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(10)),
        child: ListTile(
          title: Text(
            "Task ${index+1}",
            style: themeData.textTheme.titleSmall,
          ),
          subtitle: Row(
            children: [
              _buildTimeWidget(taskData.startAt, themeData),
              Text(
                " - ",
                style: themeData.textTheme.titleLarge,
              ),
              _buildTimeWidget(taskData.endAt, themeData)
            ],
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            color: Colors.black,
          ),
        )
        );
  }

  _buildTimeWidget(DateTime date, ThemeData themeData) {
    String hours = AppUtils.twoDigits(date.hour);
    String minute = AppUtils.twoDigits(date.minute);
    return Text(
      "$hours:$minute",
      style: themeData.textTheme.titleSmall,
    );
  }

}
