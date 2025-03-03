// import 'package:flutter/material.dart';
// import 'package:todo_list/todo_item.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Todo App',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
//         useMaterial3: true,
//       ),
//       home: const MyHomePage(title: 'Home'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   List<TodoItem> todos = [];

//   final TextEditingController _controllerTitle = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.title),
//       ),
//       body: Center(
//           child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           SizedBox(height: 20),
//           SizedBox(
//             width: 300,
//             child: TextField(
//               controller: _controllerTitle,
//               decoration: InputDecoration(
//                 hintText: 'Add a new todo',
//                 suffixIcon: IconButton(
//                   icon: Icon(Icons.add),
//                   onPressed: () {
//                     setState(() {
//                       _addTodo();
//                     });
//                   },
//                 ),
//                 contentPadding: EdgeInsets.all(10),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//               onSubmitted: (value) {},
//             ),
//           ),
//           SizedBox(height: 10),
//           Expanded(
//             child: ListView.builder(
//               itemCount: todos.length,
//               itemBuilder: (context, index) {
//                 final todo = todos[index];
//                 return ListTile(
//                   title: Text(todo.title),
//                   trailing: Checkbox(
//                     value: todo.isDone,
//                     onChanged: (value) {
//                       _toggleDone(todo);
//                     },
//                   ),
//                 );
//               },
//             ),
//           ),
//           Padding(padding: EdgeInsets.all(20.0)),
//         ],
//       )),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }

//   void _incrementCounter() {
//     setState(() {
//       // _counter++;
//     });
//   }

//   void _toggleDone(TodoItem todo) {
//     setState(() {
//       todo.toggleDone();
//     });
//   }

//   void _addTodo() {
//     if (_controllerTitle.text.isEmpty) return;
//     final title = _controllerTitle.text;
//     setState(() {
//       todos.add(TodoItem(title: title, isDone: false));
//     });
//     _controllerTitle.clear();
//   }
// }

import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/completed_tasks_screen.dart';
import 'screens/add_task_screen.dart';
import 'services/notification_service.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  final notificationService = NotificationService();
  await notificationService.init();
  await notificationService.scheduleDailyNotification();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/completed': (context) => CompletedTasksScreen(),
        '/add': (context) => AddTaskScreen(),
      },
    );
  }
}
