class TodoModel {
  int? id;
  String? title;
  String? description;
  TodoModel({this.id, this.title, this.description});

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'description': description,
      };
  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
        id: map["id"], title: map["title"], description: map["description"]);
  }
  //
}
