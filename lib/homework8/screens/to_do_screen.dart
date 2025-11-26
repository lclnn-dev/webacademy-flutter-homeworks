import 'package:flutter/material.dart';

class ToDoScreen extends StatefulWidget {
  const ToDoScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ToDoScreenState();
}

class TaskItem {
  String title;
  bool isDone;

  TaskItem({required this.title, this.isDone = false});
}

class _ToDoScreenState extends State<ToDoScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<TaskItem> _tasks = [];
  final GlobalKey<AnimatedListState> _keyListTask =
      GlobalKey<AnimatedListState>();

  void _addTask() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    final task = TaskItem(title: text);

    setState(() {
      _tasks.insert(0, task);
    });

    _keyListTask.currentState!.insertItem(0);
    _controller.clear();
  }

  void _removeTask(int index) {
    final removedTask = _tasks[index];

    setState(() {
      _tasks.removeAt(index);
    });

    _keyListTask.currentState!.removeItem(
      index,
      (context, animation) => _buildTask(removedTask, animation, index),
    );
  }

  void _updateTask(int index) {
    setState(() {
      _tasks[index].isDone = !_tasks[index].isDone;
    });
  }

  Widget _buildTask(TaskItem task, Animation<double> animation, int index) {
    return SizeTransition(
      sizeFactor: animation,
      child: ListTile(
        leading: Checkbox(
          value: task.isDone,
          onChanged: (_) => _updateTask(index),
        ),
        title: AnimatedDefaultTextStyle(
            style: TextStyle(
              fontSize: 18,
              decoration: task.isDone
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
              color: task.isDone ? Colors.grey : Colors.black,
            ),
            duration: const Duration(milliseconds: 300),
            child: Text(task.title)),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () => _removeTask(index),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("To-Do List"),
        centerTitle: true,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    onChanged: (_) => setState(() {}),
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: 'New task'),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.all(15),
                      disabledBackgroundColor: Colors.green.shade50,
                      backgroundColor: Colors.green.shade200,
                    ),
                    onPressed:
                        _controller.text.trim().isEmpty ? null : _addTask,
                    child: const Icon(Icons.add))
              ],
            ),
          ),
          Expanded(
            child: AnimatedList(
              key: _keyListTask,
              initialItemCount: _tasks.length,
              itemBuilder: (context, index, animation) =>
                  _buildTask(_tasks[index], animation, index),
            ),
          ),
        ],
      ),
    );
  }
}
