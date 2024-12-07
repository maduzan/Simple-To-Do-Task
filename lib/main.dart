import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/Data/Database/database.dart';
import 'package:to_do_app/Data/Repository/addtask.dart';
import 'package:to_do_app/Domain/usecase/addusecase.dart';
import 'package:to_do_app/Presentation/Providers/addtaskprovider.dart';
import 'package:to_do_app/Presentation/pages/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper.instance.database;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the database helper and repository
    final databaseHelper = DatabaseHelper.instance;
    final repository = AddTaskImpl(databaseHelper);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => TaskProvider(
            getTasksUseCase: GetTasksUseCase(repository),
            addTaskUseCase: AddTaskUseCase(repository),
            deleteTaskUseCase: DeleteTaskUseCase(repository),
            editTaskUseCase: UpdateTaskUseCase(repository),
          )..fetchTasks(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Home(),
      ),
    );
  }
}
