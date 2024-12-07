import 'package:sqflite/sqflite.dart';
import 'package:to_do_app/Data/Database/database.dart';
import 'package:to_do_app/Data/Model/addmodel.dart';
import 'package:to_do_app/Domain/Entity/add.dart';
import 'package:to_do_app/Domain/Repository/addrep.dart';

class AddTaskImpl implements addrepo {
  final DatabaseHelper dbHelper;

  AddTaskImpl(this.dbHelper);

  @override
  Future<void> addTask(addtask add) async {
    final db = await dbHelper.database;

    final addModel = Addmodel(
      id: null,
      task: add.task,
      Disctiption: add.Disctiption,
    );

    // Insert into the database
    await db.insert('tasks', addModel.toMap());
  }

  @override
  Future<void> deleteTask(int id) async {
    final db = await dbHelper.database;
    await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<List<addtask>> getTasks() async {
    final db = await dbHelper.database;
    final result = await db.query('tasks');
    return result.map((map) => Addmodel.fromMap(map)).toList();
  }

  @override
  Future<void> updateTask(addtask updatedTask) async {
    final db = await dbHelper.database;

    // Convert the updated task into an Addmodel
    final updatedModel = Addmodel(
      id: updatedTask.id,
      task: updatedTask.task,
      Disctiption: updatedTask.Disctiption,
    );

    // Update the task in the database
    await db.update('tasks', updatedModel.toMap(),
        where: 'id = ?', whereArgs: [updatedTask.id]);
  }
}
