import 'package:flutter/material.dart';
import 'package:to_do_app/Domain/Entity/add.dart';
import 'package:to_do_app/Domain/usecase/addusecase.dart';

class TaskProvider extends ChangeNotifier {
  final GetTasksUseCase getTasksUseCase;
  final AddTaskUseCase addTaskUseCase;
  final DeleteTaskUseCase deleteTaskUseCase;
  final UpdateTaskUseCase editTaskUseCase; // Add EditTaskUseCase

  List<addtask> _tasks = [];
  List<addtask> get tasks => _tasks;

  TaskProvider({
    required this.getTasksUseCase,
    required this.addTaskUseCase,
    required this.deleteTaskUseCase,
    required this.editTaskUseCase,
  });

  // Fetch tasks
  Future<void> fetchTasks() async {
    _tasks = await getTasksUseCase.execute();
    notifyListeners();
  }

  // Add new task
  Future<void> addTask(addtask task) async {
    await addTaskUseCase.execute(task);
    await fetchTasks();
  }

  // Delete task
  Future<void> deleteTask(int id) async {
    await deleteTaskUseCase.execute(id);
    await fetchTasks();
  }

  // Edit  task
  Future<void> editTask(int id, String newTask, String newDescription) async {
    final updatedTask = addtask(
      id: id,
      task: newTask,
      Disctiption: newDescription,
    );
    await editTaskUseCase.execute(updatedTask);
    await fetchTasks();
  }
}
