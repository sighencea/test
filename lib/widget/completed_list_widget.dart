import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_ui_example/provider/todos.dart';
import 'package:todo_app_ui_example/widget/todo_widget.dart';

class CompletedListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodosProvider>(context);
    final todos = provider.todosCompleted;

    return todos.isEmpty
        ? Center(
            child: Text(
              'No completed items',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white60,
              ),
            ),
          )
        : ListView.separated(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.all(16),
            separatorBuilder: (context, index) => Container(height: 8),
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos[index];

              return TodoWidget(todo: todo);
            },
          );
  }
}