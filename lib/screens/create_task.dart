import 'package:backend_di/models/task.dart';
import 'package:backend_di/services/task.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';

class CreateTaskView extends StatefulWidget {
  final bool isUpdateMode;
  final TaskModel model;

  CreateTaskView({super.key, required this.model, required this.isUpdateMode});

  @override
  State<CreateTaskView> createState() => _CreateTaskViewState();
}

class _CreateTaskViewState extends State<CreateTaskView> {
  TextEditingController titleController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  bool isLoading = false;

  @override
  void initState() {
    if (widget.isUpdateMode) {
      titleController =
          TextEditingController(text: widget.model.title.toString());
      descriptionController =
          TextEditingController(text: widget.model.description.toString());
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: isLoading,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.isUpdateMode ? "Update Task" : "Create Task"),
        ),
        body: Column(
          children: [
            TextField(
              controller: titleController,
            ),
            TextField(
              controller: descriptionController,
            ),
            ElevatedButton(
                onPressed: () async {
                  isLoading = true;
                  setState(() {});
                  try {
                    if (widget.isUpdateMode) {
                      await TaskServices()
                          .updateTask(TaskModel(
                        title: titleController.text,
                        docId: widget.model.docId.toString(),
                        description: descriptionController.text,
                      ))
                          .then((val) {
                        isLoading = false;
                        setState(() {});
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Task update"),
                              );
                            });
                      });
                    } else {
                      await TaskServices()
                          .createTask(TaskModel(
                        title: titleController.text,
                        description: descriptionController.text,
                      ))
                          .then((val) {
                        isLoading = false;
                        setState(() {});
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Task created"),
                              );
                            });
                      });
                    }
                  } catch (e) {
                    isLoading = false;
                    setState(() {});
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(e.toString())));
                  }
                },
                child:
                    Text(widget.isUpdateMode ? "Update Task" : "Create Task"))
          ],
        ),
      ),
    );
  }
}
