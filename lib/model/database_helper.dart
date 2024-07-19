import 'package:flutter_bloc_sqflite_database/model/todo_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const tableName = "todo";
  static const _databaseName = "todo.db";
  //static TodoModel model = TodoModel();
  final String columnId = 'id';
  final String columnTitle = 'title';
  final String columnDescription = 'description';
  late Database _database;

  Future<Database> getDatabase() async {
    var dbPath = await getDatabasesPath();
    _database = await openDatabase(join(dbPath, _databaseName),
        onCreate: _createDatabase, version: 1);
    return _database;
  }

  _createDatabase(Database db, int version) async {
    db = await getDatabase();

    String sql =
        'CREATE TABLE IF NOT EXISTS $tableName ($columnId INTEGER PRIMARY KEY, $columnTitle TEXT, $columnDescription TEXT)';
    db.execute(sql);
  }

  Future<int> insertData(TodoModel todo) async {
    _database = await getDatabase();
    int result = await _database.insert(tableName, todo.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    print("Creating Result is $result");
    return result;
  }

  Future<int> updateData(TodoModel todo) async {
    _database = await getDatabase();
    //int id = todo.id!;
    //print(id);
    //print("Todo id is $id on database file");

    int result = await _database.update(tableName, todo.toMap(),
        where: " id = ?",
        whereArgs: [todo.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
    // print("Updating id is ${todo.id}");
    // print("Updating title is ${todo.title}");
    // print("Updating description is ${todo.description}");

    return result;
  }

  Future<List<TodoModel>> getAllTodo() async {
    _database = await getDatabase();
    List<Map<String, dynamic>> maps = await _database.query(tableName);
    return maps.map((e) => TodoModel.fromMap(e)).toList();
  }

  Future<int> deleteData(int id) async {
    _database = await getDatabase();
    int delete =
        await _database.delete(tableName, where: " id=?", whereArgs: [id]);
    return delete;
  }
}
