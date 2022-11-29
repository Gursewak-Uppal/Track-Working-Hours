import 'package:flutter/material.dart';
import 'package:project_task/utils/app_utils.dart';

import '../models/task_data.dart';

class ProjectTaskList extends StatelessWidget {
  final List<TaskData> taskList;
  final void Function(int)? callback;

  const ProjectTaskList({required this.taskList, this.callback, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: ListView.builder(
          itemCount: taskList.length,
          itemBuilder: (cont, index) {
            return _buildTaskData(index, Theme.of(cont), context);
          }),
    );
  }

  //task list tile
  Widget _buildTaskData(int index, ThemeData themeData, BuildContext context) {
    TaskData taskData = taskList[index];
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
            border: Border.all(), borderRadius: BorderRadius.circular(10)),
        child: ListTile(
          onTap: () {
            //remove task
            _removeTask(context, index,
                '${formatTime(taskData.startAt)} - ${formatTime(taskData.endAt)}');
          },
          title: Text(
            "Task ${index + 1}",
            style: themeData.textTheme.titleSmall,
          ),
          subtitle: Row(
            children: [
              Text(
                '${formatTime(taskData.startAt)} - ${formatTime(taskData.endAt)}',
                style: themeData.textTheme.titleSmall,
              )
            ],
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            color: Colors.black,
          ),
        ));
  }

  //method for format time
  String formatTime(DateTime date) {
    String hours = AppUtils.twoDigits(date.hour);
    String minute = AppUtils.twoDigits(date.minute);
    String sec = AppUtils.twoDigits(date.second);
    return '$hours:$minute:$sec';
  }

  //remove task alert dialog
  void _removeTask(BuildContext context, int index, String time) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Tasks"),
        content: Wrap(
          children: [
            const Divider(
              color: Colors.black,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Task ${index + 1}',
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(time)
              ],
            ),
            const Divider(
              color: Colors.black,
            ),
            const SizedBox(
              height: 10,
            ),
            const Align(
                alignment: Alignment.center,
                child: Text(
                  "Complete Task?",
                )),
            const Divider(
              color: Colors.black,
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                callback!(index);
                Navigator.of(context).pop();
              },
              child: const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Yes",
                  )),
            ),
            const Divider(
              color: Colors.black,
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                Navigator.of(context).pop();
              },
              child: const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "No",
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
