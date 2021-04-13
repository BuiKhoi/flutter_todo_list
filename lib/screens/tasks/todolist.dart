import 'package:flutter/material.dart';
import 'package:todolist/models/task.dart';
import 'package:todolist/models/todoList.dart';
import 'package:todolist/screens/tasks/task.dart';
import 'package:provider/provider.dart';

//widget class

class TodoListWidget extends StatelessWidget {
  final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
        child: Consumer<TodoListModel>(builder: (context, todoList, child) {
          return ListView(
            children: todoList.tasks.map((TaskModel task) {
              return ChangeNotifierProvider.value(
                  value: task, child: TaskWidget());
            }).toList(),
          );
        }),
      ),
      Consumer<TodoListModel>(builder: (contexst, todoList, child) {
        return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                  child: Column(children: <Widget>[
                Container(
                    child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.teal[500])),
                            labelText: 'New task'),
                        onSubmitted: (newTask) {
                          todoList.addTaks(TaskModel(
                              text:
                                  newTask)); // create new instance of task changeNotifier model
                          _controller
                              .clear(); // clear the text input after adding taks
                          todoList.saveTasksToSharedPrefs();
                        }),
                margin: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                )

              ])),
              Align(
                  alignment: Alignment.bottomRight,
                  child: Column(children: <Widget>[
                    Container(
                        child: FloatingActionButton(
                            onPressed: () {
                              todoList
                                  .addTaks(TaskModel(text: _controller.text));
                              _controller.clear();
                              todoList.saveTasksToSharedPrefs();
                            },
                            tooltip: 'Add Todo',
                            backgroundColor: Colors.teal[300],
                            hoverColor: Colors.teal[600],
                            child: const Icon(Icons.add)),
                            margin: const EdgeInsets.all(15.0),
                    )
                  ]))
            ]);
      }),
    ]);
  }
}
