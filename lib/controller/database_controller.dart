import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/user.dart';

class DatabaseController{
  static Database? _database;
  static final DatabaseController instance = DatabaseController._();

  DatabaseController._();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'users');
    return await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        email TEXT,
        password TEXT
      )
    ''');
  }

  Future<int> insertUser(User user) async {
    Database db = await instance.database;
    return await db.insert('users', user.toMap());
  }

  Future<List<User>> getUsers() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> userMap = await db.query('users');
    return List.generate(userMap.length, (i) {
      return User(
        id: userMap[i]['id'],
        userName: userMap[i]['name'],
        email: userMap[i]['email'],
        password: userMap[i]['password']
      );
    });
  }

  void printUsers() async {
    List<User> users = await getUsers();
    for (User user in users) {
      print('User ID: ${user.id}');
      print('Username: ${user.userName}');
      print('Email: ${user.email}');
      print('Password: ${user.password}');
      print('------------------');
    }
  }
}
