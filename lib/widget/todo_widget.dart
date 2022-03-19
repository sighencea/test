// import 'package:flutter/cupertino.dart';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_ui_example/model/todo.dart';
import 'package:todo_app_ui_example/page/edit_todo_page.dart';
import 'package:todo_app_ui_example/provider/todos.dart';
import 'package:todo_app_ui_example/utils.dart';

class TodoWidget extends StatelessWidget {
  final Todo todo;

  const TodoWidget({
    @required this.todo,
    Key key,
  }) : super(key: key);

  get doNothing => null;

  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Slidable(
          startActionPane: ActionPane(motion: ScrollMotion(), children: [
            SlidableAction(
              onPressed: (context) {
                editTodo(context, todo);
              },
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              label: 'Edit',
              icon: Icons.edit,
            )
          ]),
          endActionPane: ActionPane(motion: ScrollMotion(), children: [
            SlidableAction(
              onPressed: (context) {
                deleteTodo(context, todo);
                //ScaffoldMessenger.of(context).showSnackBar(
                //SnackBar(content: Text('Removed \"${todo.title}\"')));
              },
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              label: 'Remove',
              icon: Icons.delete,
            )
          ]),
          key: Key(todo.id),
          child: buildTodo(context),
        ),
      );

  Widget buildTodo(BuildContext context) => GestureDetector(
        onTap: () => editTodo(context, todo),
        child: Container(
          color: Colors.white10,
          padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
          child: Row(
            children: [
              Transform.scale(
                scale: 1.5,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10, left: 5),
                  child: Checkbox(
                    //activeColor: Theme.of(context).primaryColor,
                    shape: CircleBorder(),
                    activeColor: Colors.deepPurple,
                    fillColor: MaterialStateProperty.all(Colors.deepPurple),
                    checkColor: Colors.white,
                    value: todo.isDone,
                    onChanged: (_) {
                      final provider =
                          Provider.of<TodosProvider>(context, listen: false);
                      final isDone = provider.toggleTodoStatus(todo);

                      Utils.showSnackBar(
                        context,
                        isDone
                            ? '\"${todo.title}\" completed'
                            : '\"${todo.title}\" moved to Shopping List',
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      todo.title,
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                        // color: Theme.of(context).primaryColor,
                        fontSize: 22,
                      ),
                    ),
                    if (todo.description.isNotEmpty)
                      Container(
                        margin: EdgeInsets.only(top: 4),
                        child: Text(
                          todo.description,
                          style: TextStyle(
                              fontSize: 20, height: 1.5, color: Colors.white60),
                        ),
                      )
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  void deleteTodo(BuildContext context, Todo todo) {
    final provider = Provider.of<TodosProvider>(context, listen: false);
    provider.removeTodo(todo);

    Utils.showSnackBar(context, 'Removed item \"${todo.title}\"');
  }

  void editTodo(BuildContext context, Todo todo) => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => EditTodoPage(todo: todo),
        ),
      );
}
