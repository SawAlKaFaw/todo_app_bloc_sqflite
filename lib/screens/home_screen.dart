import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_sqflite_database/bloc/bloc/todo_bloc.dart';
import 'package:flutter_bloc_sqflite_database/screens/add_todo.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("ToDo"),
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          // state = TodoInitial();
          switch (state) {
            case TodoInitial():
              context.read<TodoBloc>().add(LoadToDoEvent());
              Fluttertoast.showToast(
                  msg: "Loading Todo",
                  toastLength: Toast.LENGTH_LONG,
                  backgroundColor: Colors.blue);
              return const Center(child: CircularProgressIndicator());

            case TodoLoadedState():
              return state.todoLists.isEmpty
                  ? const Center(
                      child: Text(
                        "No Todo",
                        style: TextStyle(fontSize: 20),
                      ),
                    )
                  : ListView.builder(
                      itemCount: state.todoLists.length,
                      itemBuilder: (context, index) => Card(
                            child: ListTile(
                              title: Text("${state.todoLists[index].title}"),
                              subtitle:
                                  Text("${state.todoLists[index].description}"),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                                  content: AddTodo(
                                                      todoModel: state
                                                          .todoLists[index]),
                                                ));

                                        //   print(
                                        //       "${state.todoLists[index].id} is Carrying");
                                        //   print(
                                        //       "${state.todoLists[index].title} is Carrying 1");
                                        //   print(
                                        //       "${state.todoLists[index].description} is Carrying 2");
                                        //
                                      },
                                      icon: const Icon(Icons.edit)),
                                  IconButton(
                                      onPressed: () {
                                        context.read<TodoBloc>().add(
                                            DeleteToDoEvent(
                                                id: state
                                                    .todoLists[index].id!));
                                        Fluttertoast.showToast(
                                            msg: "Deleting Todo is successful",
                                            toastLength: Toast.LENGTH_SHORT,
                                            backgroundColor: Colors.red);
                                        // print("${state.todoLists[index]} is Deleting");
                                      },
                                      icon: const Icon(Icons.delete))
                                ],
                              ),
                            ),
                          ));

            case TodoError():
              return const Center(
                child: Text("Error"),
              );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    content: AddTodo(),
                  ));
          print("pressed");
        },
        child: const Text("Add"),
      ),
    );
  }
}
