import 'package:backend_di/models/task.dart';
import 'package:backend_di/screens/create_task.dart';
import 'package:backend_di/services/task.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GetInCompletedTaskView extends StatelessWidget {
  const GetInCompletedTaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Get ALl Task"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CreateTaskView()));
        },
        child: const Icon(Icons.add),
      ),
      body: StreamProvider.value(
        value: TaskServices().fetchInCompletedTask(),
        initialData: [TaskModel()],
        builder: (context, child) {
          List<TaskModel> taskList = context.watch<List<TaskModel>>();
          return ListView.builder(
              itemCount: taskList.length,
              itemBuilder: (context, i) {
                return ListTile(
                  title: Text(taskList[i].title.toString()),
                  subtitle: Text(taskList[i].description.toString()),
                );
              });
        },
      ),
    );
  }
}
