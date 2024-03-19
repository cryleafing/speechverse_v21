import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key, required SharedPreferences prefs}); // accept prefs
  // as a param

  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<String> _tasks = [];
  TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  // load tasks from SharedPreferences
  Future<void> _loadTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _tasks = prefs.getStringList('tasks') ?? [];
    });
  }

  // save tasks to SharedPreferences instance
  Future<void> _saveTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('tasks', _tasks);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List'),
        actions: [
          IconButton(
            icon: Icon(Icons.home),
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
            scrollPadding: EdgeInsets.all(8.0),
            controller: _textEditingController,
            decoration: InputDecoration(
              helperStyle: TextStyle(fontFamily: 'OpenSans'),
              hintText: 'Enter task',
              contentPadding: EdgeInsets.symmetric(),
              constraints: BoxConstraints.tight(Size(250, 40)),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _addTask(_textEditingController.text);
            },
            child: Text(style: TextStyle(fontFamily: 'OpenSans'), 'Add Task'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(_tasks[index]),
                  onDismissed: (direction) {
                    _removeTask(index);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Task deleted'),
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
                    padding: EdgeInsets.only(right: 20.0),
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                  child: ListTile(
                    tileColor: Theme.of(context).focusColor,
                    title: Text(_tasks[index]),
                  ),
                );
              },
            ),
          ),
          Tooltip(
            message: 'Swipe left or right to delete tasks',
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.lightbulb),
            ),
          ),
        ],
      ),
    );
  }

  void _addTask(String taskTitle) {
    setState(() {
      _tasks.add(taskTitle);
      _textEditingController.clear();
      _saveTasks(); // make sure to save this to sharedprefs
    });
  }

  void _removeTask(int index) {
    setState(() {
      _tasks.removeAt(index);
      _saveTasks(); // Save tasks to SharedPreferences
    });
  }
}
