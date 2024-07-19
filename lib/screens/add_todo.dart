import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_sqflite_database/bloc/bloc/todo_bloc.dart';
import 'package:flutter_bloc_sqflite_database/model/todo_model.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddTodo extends StatelessWidget {
  final TodoModel? todoModel;
  AddTodo({this.todoModel, super.key}) {
    //int? id = todoModel?.id;
    // String? title = todoModel.title;
    // String? description = todoModel.description;
    // print("Model id is $id");
    //print("Model title is $title");
    //print("Model description is $description");
  }
  final GlobalKey<FormState> _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleTextEditingController =
        TextEditingController(
            text: todoModel != null ? "${todoModel!.title}" : "");
    final TextEditingController descriptionTextEditingController =
        TextEditingController(
            text: todoModel != null ? "${todoModel!.description}" : "");

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.4,
      child: Form(
        key: _globalKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return ("Please you want  todo");
                }
                return null;
              },
              autovalidateMode: AutovalidateMode.always,
              controller: titleTextEditingController,
              //initialValue: "titiel", enabled: true,
              // initialValue: todoModel!.title!,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                hintText: "Add todo",
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: descriptionTextEditingController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  hintText: "Add Description"),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                bool valid = _globalKey.currentState!.validate();
                if (valid) {
                  TodoModel todo = TodoModel(
                      title: titleTextEditingController.text,
                      description: descriptionTextEditingController.text);
                  // context.read<TodoBloc>().add(AddToDoEvent(todo: todo));
                  if (todoModel == null) {
                    context.read<TodoBloc>().add(AddToDoEvent(todo: todo));
                    Fluttertoast.showToast(
                        msg: "Adding Todo is successful",
                        backgroundColor: Colors.blue);
                    Navigator.pop(context);
                  } else {
                    if (todoModel!.title == titleTextEditingController.text &&
                        todoModel!.description ==
                            descriptionTextEditingController.text) {
                      Fluttertoast.showToast(
                          msg: "Nothing update", backgroundColor: Colors.blue);
                      Navigator.pop(context);
                    } else {
                      todoModel!.title = titleTextEditingController.text;
                      todoModel!.description =
                          descriptionTextEditingController.text;
                      context
                          .read<TodoBloc>()
                          .add(UpdateToDoEvent(todo: todoModel!));

                      Fluttertoast.showToast(
                          msg: "Updating Todo is successful",
                          backgroundColor: Colors.blue);
                      Navigator.pop(context);
                    }
                  }
                } else {
                  Fluttertoast.showToast(
                      msg: "Please Add a todo ",
                      backgroundColor: Colors.orange);
                }
              },
              child: Text((todoModel == null) ? "Add" : "Update"),
            ),
          ],
        ),
      ),
    );
  }
}
