import 'package:flutter/material.dart';
import 'package:todolist/models/task.dart';
import 'package:provider/provider.dart';
import 'package:todolist/models/todoList.dart';

class TaskWidget extends StatelessWidget {
  // method to style completed/uncompleted item
  TextStyle _taskStyle(completed) {
    if (completed)
      return TextStyle(
        color: Colors.black38,
        decoration: TextDecoration.lineThrough,
      );
    else
      return TextStyle(
        decoration: TextDecoration.none,
      );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskModel>(builder: (context, task, child) {
      return Container(
        child: CheckboxListTile(
          title: Text(
            task.text,
            style: _taskStyle(task.completed),
          ),
          secondary: Icon(Icons.delete),
          value: task.completed,
          onChanged: (newValue) {
            task.toggle();
            Provider.of<TodoListModel>(context, listen: false)
                .saveTasksToSharedPrefs();
          },
          activeColor: Colors.black87,
          controlAffinity: ListTileControlAffinity.leading,
          ),
          margin: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(color: Colors.teal[300], spreadRadius: 2),
            ],
          ),
          width: 48.0,
          height: 48.0,
      );
    });
  }
}
