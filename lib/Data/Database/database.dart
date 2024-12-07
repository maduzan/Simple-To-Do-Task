import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _databaseName = "tasks.db";
  static final _databaseVersion = 1;

  static final table = 'tasks';

  static final columnId = 'id';
  static final columnTask = 'task';
  static final columnDisctiption = 'Disctiption';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    String path = await getDatabasesPath() + _databaseName;
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // Table creation SQL
  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnTask TEXT NOT NULL,
        $columnDisctiption TEXT NOT NULL
      )
    ''');
  }
}
