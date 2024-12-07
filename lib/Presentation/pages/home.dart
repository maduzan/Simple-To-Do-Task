import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/Domain/Entity/add.dart';
import 'package:to_do_app/Presentation/Providers/addtaskprovider.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 175, 167, 167),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        title: Center(
            child: Text(
          "To-Do App",
          style: TextStyle(color: Colors.white),
        )),
      ),
      body: Consumer<TaskProvider>(
        builder: (context, provider, child) {
          return ListView.builder(
            itemCount: provider.tasks.length,
            itemBuilder: (context, index) {
              final task = provider.tasks[index];
              return TaskItem(
                task: task,
                onEdit: () => _editTask(context, task, provider),
                onDelete: () => provider.deleteTask(task.id!),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddTaskDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Add Task"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: "Task Title"),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: "Task Description"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                final task = titleController.text.isEmpty
                    ? 'Default Task'
                    : titleController.text;
                final description = descriptionController.text.isEmpty
                    ? 'No description provided'
                    : descriptionController.text;

                final taskData = addtask(
                  task: task,
                  Disctiption: description,
                  id: null,
                );

                context.read<TaskProvider>().addTask(taskData);

                Navigator.of(context).pop();
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }

  void _editTask(BuildContext context, addtask task, TaskProvider provider) {
    TextEditingController taskController =
        TextEditingController(text: task.task);
    TextEditingController descriptionController =
        TextEditingController(text: task.Disctiption);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit Task"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: taskController,
                decoration: InputDecoration(labelText: "Task Name"),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: "Description"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (taskController.text.isNotEmpty &&
                    descriptionController.text.isNotEmpty) {
                  final updatedTask = addtask(
                    id: task.id,
                    task: taskController.text,
                    Disctiption: descriptionController.text,
                  );

                  provider.editTask(updatedTask.id!, updatedTask.task,
                      updatedTask.Disctiption);

                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Please fill in both fields")),
                  );
                }
              },
              child: Text("Save"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
          ],
        );
      },
    );
  }
}

class TaskItem extends StatefulWidget {
  final addtask task;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const TaskItem({
    required this.task,
    required this.onEdit,
    required this.onDelete,
    Key? key,
  }) : super(key: key);

  @override
  _TaskItemState createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: isChecked,
        onChanged: (value) {
          setState(() {
            isChecked = value ?? false;
          });
        },
      ),
      title: Text(
        widget.task.task,
        style: TextStyle(
          decoration:
              isChecked ? TextDecoration.lineThrough : TextDecoration.none,
        ),
      ),
      subtitle: Text(widget.task.Disctiption),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: widget.onEdit,
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: widget.onDelete,
          ),
        ],
      ),
    );
  }
}
