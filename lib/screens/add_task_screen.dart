import 'package:flutter/material.dart';
import '../models/task.dart';
import '../services/database_service.dart';

class AddTaskScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  final DatabaseService _dbService = DatabaseService();

  AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Thêm công việc')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Nội dung công việc'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (_controller.text.isNotEmpty) {
                  final task = Task(
                    title: _controller.text,
                    date: DateTime.now(),
                  );
                  await _dbService.insertTask(task);
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context, true);
                }
              },
              child: Text('Thêm'),
            ),
          ],
        ),
      ),
    );
  }
}