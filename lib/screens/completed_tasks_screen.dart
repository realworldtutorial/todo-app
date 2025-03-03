import 'package:flutter/material.dart';
import '../models/task.dart';
import '../services/database_service.dart';

class CompletedTasksScreen extends StatefulWidget {
  const CompletedTasksScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CompletedTasksScreenState createState() => _CompletedTasksScreenState();
}

class _CompletedTasksScreenState extends State<CompletedTasksScreen> {
  final DatabaseService _dbService = DatabaseService();
  List<Task> completedTasks = [];

  @override
  void initState() {
    super.initState();
    _loadCompletedTasks();
  }

  Future<void> _loadCompletedTasks() async {
    final tasks = await _dbService.getTasksForDate(DateTime.now());
    setState(() {
      completedTasks = tasks.where((task) => task.isCompleted ?? false).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Công việc đã hoàn thành')),
      body: ListView.builder(
        itemCount: completedTasks.length,
        itemBuilder: (context, index) {
          final task = completedTasks[index];
          return ListTile(
            title: Text(task.title ?? "No title", style: TextStyle(decoration: TextDecoration.lineThrough)),
            leading: Checkbox(
              value: task.isCompleted,
              onChanged: (value) async {
                task.isCompleted = false;
                await _dbService.updateTask(task);
                _loadCompletedTasks();
              },
            ),
          );
        },
      ),
    );
  }
}