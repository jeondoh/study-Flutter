import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todo_app/data/todo.dart';

class DatabaseHelper {
  static const _databaseName = "todo.db";
  static const _databaseVersion = 1;
  static const _todoTable = "todo";

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  late Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate, onUpgrade: _onUpgrade);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS $_todoTable (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        date INTEGER DEFAULT 0,
        title String,
        memo String,
        color INTEGER,
        category String,
      ) 
    ''');
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {}

  Future<int> insertTodo(Todo todo) async {
    Database db = await instance.database;

    Map<String, dynamic> row = {
      "title": todo.title,
      "date": todo.date,
      "memo": todo.memo,
      "done": todo.done,
      "color": todo.color,
      "category": todo.category,
    };

    if (todo.id == null) {
      return await db.insert(_todoTable, row);
    }

    return await db
        .update(_todoTable, row, where: "id = ?", whereArgs: [todo.id]);
  }

  Future<List<Todo>> getAllTodo() async {
    Database db = instance._database;
    List<Todo> todos = [];

    var queries = await db.query(_todoTable);
    for (var q in queries) {
      todos.add(
        Todo(
          id: int.parse(q["id"].toString()),
          title: q["title"].toString(),
          date: int.parse(q["date"].toString()),
          memo: q["memo"].toString(),
          category: q["category"].toString(),
          color: int.parse(q["color"].toString()),
          done: int.parse(q["done"].toString()),
        ),
      );
    }
    return todos;
  }

  Future<List<Todo>> getTodoByDate(int date) async {
    Database db = instance._database;
    List<Todo> todos = [];

    var queries =
        await db.query(_todoTable, where: "date = ?", whereArgs: [date]);
    for (var q in queries) {
      todos.add(
        Todo(
          id: int.parse(q["id"].toString()),
          title: q["title"].toString(),
          date: int.parse(q["date"].toString()),
          memo: q["memo"].toString(),
          category: q["category"].toString(),
          color: int.parse(q["color"].toString()),
          done: int.parse(q["done"].toString()),
        ),
      );
    }
    return todos;
  }
}
