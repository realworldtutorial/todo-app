class TodoItem {
  // Properties
  String title;
  bool isDone;

  // Constructor
  TodoItem({required this.title, required this.isDone});

  // Method
  void toggleDone() {
    isDone = !isDone;
  }
  
}