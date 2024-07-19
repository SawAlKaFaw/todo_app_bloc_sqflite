part of 'todo_bloc.dart';

@immutable
sealed class TodoEvent {}

//load todo
class LoadToDoEvent extends TodoEvent {
  LoadToDoEvent();
}

//add todo
class AddToDoEvent extends TodoEvent {
  final TodoModel todo;

  AddToDoEvent({required this.todo});
}

//update todo
class UpdateToDoEvent extends TodoEvent {
  final TodoModel todo;
  //final int id;

  UpdateToDoEvent({required this.todo});
}

//delete todo
class DeleteToDoEvent extends TodoEvent {
  final int id;

  DeleteToDoEvent({required this.id});
}
