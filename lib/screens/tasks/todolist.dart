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
      Consumer<TodoListModel>(builder: (context, todoList, child) {
        return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  width: MediaQuery.of(context).size.width,
                  constraints: BoxConstraints(minWidth: 100, maxWidth: 980),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          child: Container(
                              child: TextField(
                                  controller: _controller,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.teal),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      labelText: 'new task'),
                                  onSubmitted: (newTask) {
                                    todoList.addTaks(TaskModel(
                                        text:
                                            newTask)); // create new instance of task changeNotifier model
                                    _controller
                                        .clear(); // clear the text input after adding taks
                                    todoList.saveTasksToSharedPrefs();
                                  }))),
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
                    ],
                  )),
            ]);
      }),
    ]);
  }
}
