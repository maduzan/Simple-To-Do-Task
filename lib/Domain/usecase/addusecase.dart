import 'package:to_do_app/Domain/Entity/add.dart';
import 'package:to_do_app/Domain/Repository/addrep.dart';

class AddTaskUseCase {
  final addrepo repository;

  AddTaskUseCase(this.repository);

  Future<void> execute(addtask add) => repository.addTask(add);
}

class GetTasksUseCase {
  final addrepo repository;

  GetTasksUseCase(this.repository);

  Future<List<addtask>> execute() => repository.getTasks();
}

class DeleteTaskUseCase {
  final addrepo repository;

  DeleteTaskUseCase(this.repository);

  Future<void> execute(int id) => repository.deleteTask(id);
}

class UpdateTaskUseCase {
  final addrepo repository;

  UpdateTaskUseCase(this.repository);

  Future<void> execute(addtask updatedTask) =>
      repository.updateTask(updatedTask);
}
