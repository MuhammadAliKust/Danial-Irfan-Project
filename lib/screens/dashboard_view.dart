import 'package:backend_di/models/task.dart';
import 'package:backend_di/services/task.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard View"),
      ),
      body: StreamProvider.value(
          value: TaskServices().fetchAllTask(),
          initialData: [TaskModel()],
          builder: (context, child) {
            List<TaskModel> taskList = context.watch<List<TaskModel>>();
            return StreamProvider.value(
                value: TaskServices().fetchCompletedTask(),
                initialData: [TaskModel()],
                builder: (context, child) {
                  List<TaskModel> completedTaskList =
                      context.watch<List<TaskModel>>();

                  return StreamProvider.value(
                      value: TaskServices().fetchInCompletedTask(),
                      initialData: [TaskModel()],
                      builder: (context, child) {
                        List<TaskModel> inCompletedTaskList =
                            context.watch<List<TaskModel>>();

                        return Column(
                          children: [
                            Text(
                              "All Task ${taskList.length}",
                              style: TextStyle(fontSize: 30),
                            ),
                            Text("Completed Task ${completedTaskList.length}",
                              style: TextStyle(fontSize: 30),),
                            Text(
                                "InCompleted Task ${inCompletedTaskList.length}",
                              style: TextStyle(fontSize: 30),),
                          ],
                        );
                      });
                });
          }),
    );
  }
}
