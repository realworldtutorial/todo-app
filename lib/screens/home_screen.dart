import 'package:flutter/material.dart';
import 'package:todo_list/services/notification_service.dart';
import '../models/task.dart';
import '../services/database_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DatabaseService _dbService = DatabaseService();
  List<Task> tasks = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final todayTasks = await _dbService.getTasksForDate(DateTime.now());
    setState(() {
      tasks = todayTasks..sort((a, b) => (a.isCompleted ?? false) ? 1 : -1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Danh sách công việc hôm nay'),
        actions: [
          IconButton(
            icon: Icon(Icons.check_circle),
            onPressed: () => Navigator.pushNamed(context, '/completed'),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return ListTile(
                    title: Text(
                      task.title ?? 'No Title',
                      style: TextStyle(
                        decoration: (task.isCompleted ?? false)
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                    leading: Checkbox(
                      value: task.isCompleted,
                      onChanged: (value) async {
                        task.isCompleted = value!;
                        await _dbService.updateTask(task);
                        _loadTasks();
                      },
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  NotificationService().scheduleDailyNotification();
                },
                child: Text("Test show notification")),
            SizedBox(height: 20),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final isAdded = await Navigator.pushNamed(context, '/add');
          if (isAdded == true) {
            _loadTasks();
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
