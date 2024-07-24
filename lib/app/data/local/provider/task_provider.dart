import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_it/app/data/local/models/task_model.dart';
import 'package:todo_it/app/Constants/constants.dart';

class TasksContext{
  SharedPreferences? prefs;

  TasksContext() {
    _initPrefs();
  }

  Future<void> _initPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    this.prefs = prefs;
  }

  Future<void> save(List<Task> items) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String encodedData = Task.encode(items);
    await prefs.setString(Constants.prefKey, encodedData);
  }

  Future<List<Task>> get() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? encodedString = prefs.getString(Constants.prefKey);
    if (encodedString != null) {
      return Task.decode(encodedString);
    }
    return [];
  }

  Future<void> add(Task item) async {
    List<Task> items = await get();
    items.add(item);
    await save(items);
  }

  Future<void> update(Task task) async {
    List<Task> items = await get();
    //print("Before update " + task.isCompleted.toString());
    Task removedItem = items.where((e) => e.id == task.id).first;
    items.remove(removedItem);
    items.add(task);
    //print("After update " + task.isCompleted.toString());
    await save(items);
  }

  Future<void> remove(Task item) async {
    List<Task> items = await get();
    items.removeWhere((e) => e.id == item.id);
    await save(items);
  }
}
