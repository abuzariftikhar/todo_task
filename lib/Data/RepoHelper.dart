import 'package:todo_task/Data/DatabaseHelper.dart';
import 'package:todo_task/Data/Injection.dart';
import 'package:todo_task/Data/TaskModel.dart';

class RepositoryHelper {
  DatabaseHelper _databaseHelper = Injection.injector.get();

//add a task to the database
  Future<int> create(Task task) async {
    int id = await _databaseHelper.db.insert('Task', task.toMapWithoutId());
    return id;
  }

  //query an item from the database by id
  Future<Task> getItemById(int id) async {
    List<Map> list = await _databaseHelper.db
        .rawQuery("Select * from Task where id = ?", [id]);
    if (list.length > 0) {
      return Task.fromMap(list[0]);
    }
    return null;
  }

//update a task
  Future<int> updateItem(Task task) async {
    return await _databaseHelper.db
        .update("Task", task.toMap(), where: "id = ?", whereArgs: [task.id]);
  }

//delete a task
  Future<int> deleteItem(int id) async {
    return await _databaseHelper.db
        .delete("Task", where: "id = ?", whereArgs: [id]);
  }

  /// Get all tasks with ids, will return a list with all the tasks found
  Future<List<Task>> getTasks() async {
    List<Map> result = await _databaseHelper.db.query('Task');
    List<Task> tasks = List<Task>();
    for (Map<String, dynamic> item in result) {
      tasks.add(Task.fromMap(item));
    }
    return tasks;
  }
}
