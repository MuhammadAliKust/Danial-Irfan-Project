// To parse this JSON data, do
//
//     final taskModel = taskModelFromJson(jsonString);

import 'dart:convert';

class TaskModel {
  final String? docId;
  final String? title;
  final String? description;
  final int? createdAt;
  final bool? isCompleted;

  TaskModel({
    this.docId,
    this.title,
    this.description,
    this.createdAt,
    this.isCompleted,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        docId: json["docID"],
        title: json["title"],
        description: json["description"],
        createdAt: json["createdAt"],
        isCompleted: json["isCompleted"],
      );

  Map<String, dynamic> toJson(String documentID) => {
        "docID": documentID,
        "title": title,
        "description": description,
        "createdAt": DateTime.now().millisecondsSinceEpoch,
        "isCompleted": false,
      };
}
