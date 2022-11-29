import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:project_task/models/task_data.dart';
import 'package:project_task/screens/project_tasks.dart';
import 'package:project_task/screens/stop_watch.dart';
import 'package:project_task/utils/app_utils.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<TaskData> _taskList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tasks"),
      ),
      bottomNavigationBar: StopWatch(
        onNewTaskEnd: _handleTaskEnd,
      ),
      body: _buildBody(),
    );
  }

  _buildBody() {
    return ProjectTaskList(
      taskList: _taskList,
    );
  }

  _handleTaskEnd(Duration duration) {
    if (mounted) {
      setState(() {
        _taskList.add(TaskData(id: DateTime.now().microsecondsSinceEpoch.toString(), startAt: DateTime.now().subtract(duration), endAt: DateTime.now()));
      });
    }
  }
}
