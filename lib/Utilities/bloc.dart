import 'package:flutter/material.dart';
import 'package:todo_task/Data/RepoHelper.dart';
import 'package:todo_task/Data/TaskModel.dart';

class Linker extends ChangeNotifier {
  final RepositoryHelper repositoryHelper = RepositoryHelper();
  List<Task> taskList = List<Task>();
  int count = 0;
  String categoryValue = 'Default';
  Color colorValue = Colors.blue.shade100;
 
  void updateView() {
    Future<List<Task>> taskListFuture = repositoryHelper.getTasks();
    taskListFuture.then((value) {
      taskList = value;
      count = value.length;
    });
    notifyListeners();
  }

  void update() {
    notifyListeners();
  }
}
