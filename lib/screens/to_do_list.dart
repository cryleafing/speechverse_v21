import 'package:flutter/material.dart';
import '../sqlite/todo_db_helper.dart';

// USE SQLITE
class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  // tasks as a map
  List<Map<String, dynamic>> _tasks = [];

  TextEditingController _textEditingController = TextEditingController();

  final db = DatabaseHelper.instance;

  @override
  void initState() {
    super.initState();
    _loadTasks(); // get tasks from the database
  }

  // fetch all tasks from the database and update the UI.

  Future<void> _loadTasks() async {
    _tasks = await db.queryAll();
    setState(() {}); // Trigger a rebuild of the widget with updated tasks.
  }

  // add a new task to the database and refresh the task list.
  void _addTask(String taskTitle) async {
    await db.insert({'name': taskTitle});
    _loadTasks();
    _textEditingController.clear();
  }

  // remove a task from the database by its ID and refresh the task list.
  void _removeTask(int id) async {
    await db.delete(id);
    _loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              // navigate to the home screen
              Navigator.pushNamed(context, '/dashboard');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          TextField(
            scrollPadding: const EdgeInsets.all(8.0),
            controller: _textEditingController,
            decoration: InputDecoration(
              helperStyle: const TextStyle(fontFamily: 'OpenSans'),
              hintText: 'Enter task',
              contentPadding: const EdgeInsets.symmetric(),
              constraints: BoxConstraints.tight(const Size(250, 40)),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _addTask(_textEditingController.text);
            },
            child: const Text(
                style: TextStyle(fontFamily: 'OpenSans'), 'Add Task'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(_tasks[index]['name'].toString()), // cast
                  onDismissed: (direction) {
                    int taskID = _tasks[index]['_id'];
                    _removeTask(
                        taskID); // make sure to remove task by id, index can change
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Task deleted'),
                        action: SnackBarAction(
                          label: 'OK',
                          onPressed: () {
                            // do nothing until it goes away
                          },
                        ),
                      ),
                    );
                  },
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20.0),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  child: ListTile(
                    tileColor: Theme.of(context).focusColor,
                    title: Text(_tasks[index]['name'].toString()),
                  ),
                );
              },
            ),
          ),
          const Tooltip(
            message: 'Swipe left or right to delete tasks',
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.lightbulb),
            ),
          ),
        ],
      ),
    );
  }
}
