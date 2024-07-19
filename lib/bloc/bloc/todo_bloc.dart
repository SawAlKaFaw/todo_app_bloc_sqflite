import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_sqflite_database/model/database_helper.dart';
import 'package:flutter_bloc_sqflite_database/model/todo_model.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  TodoBloc() : super(TodoInitial()) {
    List<TodoModel> todos = [];
    // void _showPrint() {
    //   for (var to in todos) {
    //     print(
    //         "Id is ${to.id!} -- Title is ${to.title!} -- Description is ${to.description!} ");
    //   }
    // }
    on<LoadToDoEvent>((event, emit) async {
      todos = await databaseHelper.getAllTodo();
      await Future.delayed(const Duration(seconds: 1));
      emit(TodoLoadedState(todoLists: todos));
    });
    on<AddToDoEvent>((event, emit) async {
      await databaseHelper.insertData(event.todo);
      todos = await databaseHelper.getAllTodo();

      emit(TodoLoadedState(todoLists: todos));
      //showPrint();
    });
    on<UpdateToDoEvent>((event, emit) async {
      //int id = event.todo.id!;
      await databaseHelper.updateData(event.todo);
      //print(id);

      todos = await databaseHelper.getAllTodo();
      //print("All Todo list is $todos");
      //showPrint();
      emit(TodoLoadedState(todoLists: todos));
    });

    on<DeleteToDoEvent>((event, emit) async {
      await databaseHelper.deleteData(event.id);
      todos = await databaseHelper.getAllTodo();
      emit(TodoLoadedState(todoLists: todos));
    });
  }
}
