import 'package:todo_it/app/data/local/models/task_model.dart';
import 'package:intl/intl.dart';
import 'package:todo_it/app/data/local/enums/priority_enum.dart';
import 'dart:math';

import '../local/provider/task_provider.dart';

class TaskRepository {
  final TasksContext taskProvider;

  TaskRepository({required this.taskProvider});

  Future<List<Task>> getTasks() async {
    return await taskProvider.get();
  }

  Future<void> createNewTask(Task taskModel) async {
    return await taskProvider.add(taskModel);
  }

  Future<void> updateTask(Task taskModel) async {
    return await taskProvider.update(taskModel);
  }

  Future<void> deleteTask(Task taskModel) async {
    return await taskProvider.remove(taskModel);
  }

  Future<int> getTaskCountByDate(DateTime date, bool isLimited,
      {List<Task>? tasks}) async {
    tasks ??= await taskProvider.get();

    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    String d1 = "";
    String d2 = "";
    int count = 0;
    for (Task task in tasks) {
      d1 = formatter.format(date);
      d2 = formatter.format(task.startDate!);
      if (d1 == d2) {
        count++;
      }
    }
    if (isLimited) {
      if (count > 3) return 3;
    }
    return count;
  }

  Future<List<Task>> getByPriority(Priority priority,
      {List<Task>? tasks}) async {
    tasks ??= await taskProvider.get();
    List<Task> result = [];

    for (Task task in tasks) {
      if (task.priority == priority) result.add(task);
    }
    return result;
  }

  Future<List<Task>> sortByPriority({List<Task>? tasks}) async {
    tasks ??= await taskProvider.get();

    List<Task> result = [];
    List<Task> basic = await getByPriority(Priority.basic, tasks: tasks);
    List<Task> urgent = await getByPriority(Priority.urgent, tasks: tasks);
    List<Task> important =
        await getByPriority(Priority.important, tasks: tasks);
    List<Task> urimpor =
        await getByPriority(Priority.urgentImportant, tasks: tasks);
    List<List<Task>> lists = [urimpor, urgent, important, basic];

    for (List<Task> list in lists) {
      for (Task task in list) {
        result.add(task);
      }
    }

    return result;
  }

  Future<List<Task>> sortByDate({List<Task>? tasks}) async {
    tasks ??= await taskProvider.get();
    List<Task> sortedTasks = List.from(tasks);
    sortedTasks.sort((a, b) => a.startDate!.compareTo(b.startDate!));
    return sortedTasks;
  }

  Future<List<Task>> getCompleted({List<Task>? tasks}) async {
    tasks ??= await taskProvider.get();
    List<Task> completedTasks =
        tasks.where((task) => task.isCompleted!).toList();
    return sortByDate(tasks: completedTasks);
  }

  Future<List<Task>> getByDate(int selected, DateTime dateTime,
      {List<Task>? tasks}) async {
    tasks ??= await taskProvider.get();
    List<Task> result = [];
    for (Task task in tasks) {
      final DateFormat formatter = DateFormat('yyyy-MM-dd');
      final String d1 = formatter.format(task.startDate!);
      final String d2 = formatter.format(dateTime);
      if (d1 == d2) {
        result.add(task);
      }
    }
    switch (selected) {
      case -1:
        return result;
      case 0:
        return sortByPriority(tasks: result);
      case 1:
        return getCompleted(tasks: result);
    }
    return result;
  }

  Future<List<Task>> search(String query, {List<Task>? tasks}) async {
    tasks ??= await taskProvider.get();

    if (query.isEmpty) {
      return tasks;
    } else {
      return tasks
          .where((e) => e.title!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

  void createTasks(int count) async{
    for (int i = 0; i < count; i++) {
      await taskProvider.add(create());
    }
    print("Added $count task!");
  }

  Task create() {
    List<String> titles = [
      'Günlük Stand-up Toplantısı',
      'Proje Planını Güncelle',
      'Müşteri Görüşmesi',
      'Haftalık Rapor Hazırlığı',
      'Kod İncelemesi',
      'Veritabanı Yedeklemesi',
      'Yeni Özellik Tasarımı',
      'Hata Düzeltme',
      'Eğitim Oturumu',
      'Pazar Araştırması'
    ];
    List<String> taskDescriptions = [
      'Takım üyeleriyle güncel durumu paylaş ve günlük hedefleri belirle.',
      'Proje planındaki değişiklikleri yansıt ve yeni görevleri ekle.',
      'Müşteriyle yeni özellikler hakkında toplantı yap ve geri bildirimleri al.',
      'Haftalık ilerleme ve performans raporunu hazırla ve yönetime sun.',
      'Takım arkadaşının kodunu gözden geçir ve iyileştirme önerileri yap.',
      'Veritabanının tam yedeğini al ve güvenli bir şekilde sakla.',
      'Yeni bir özelliğin kullanıcı arayüzü ve işlevselliği üzerinde çalış.',
      'Uygulamada tespit edilen hataları düzelt ve ilgili testleri gerçekleştir.',
      'Yeni teknolojiler veya araçlar hakkında takım için bir eğitim oturumu düzenle.',
      'Rakip ürünleri ve pazar trendlerini analiz ederek stratejik içgörüler oluştur.'
    ];

    DateTime now = DateTime.now();
    DateTime lastDayofMonth = DateTime(now.year, now.month + 1, 0);

    DateTime startDate = DateTime(now.year, now.month - 1, 0);
    DateTime endDate =
        DateTime.now().add(Duration(days: lastDayofMonth.day - now.day));
    int differenceInDays = endDate.difference(startDate).inDays;
    int randomDays = Random().nextInt(differenceInDays + 1);
    startDate = startDate.add(Duration(days: randomDays));
    randomDays = Random().nextInt(differenceInDays + 1);
    endDate = endDate.subtract(Duration(days: randomDays));

    bool isComp = (Random().nextInt(2) % 2 == 0) ? true : false;
    Priority p1 = Priority.values[Random().nextInt(Priority.values.length)];
    titles.shuffle(Random());
    taskDescriptions.shuffle(Random());

    return Task(
        title: titles[0],
        description: taskDescriptions[0],
        startDate: startDate,
        priority: p1,
        isCompleted: isComp);
  }
}
