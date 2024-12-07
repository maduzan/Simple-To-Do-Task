import 'package:to_do_app/Domain/Entity/add.dart';

abstract class addrepo {
  Future<void> addTask(addtask add);
  Future<List<addtask>> getTasks();
  Future<void> deleteTask(int id);
  Future<void> updateTask(addtask updatedTask);
}
