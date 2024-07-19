part of 'todo_bloc.dart';

@immutable
sealed class TodoState {}

final class TodoInitial extends TodoState {
  final List<TodoModel> todos = [];
}

//loading
//class TodoLoadingState extends TodoState {}

//loaded
class TodoLoadedState extends TodoState {
  final List<TodoModel> todoLists;
  TodoLoadedState({required this.todoLists});
}

//error
class TodoError extends TodoState {
  final String error;

  TodoError({required this.error});
}
