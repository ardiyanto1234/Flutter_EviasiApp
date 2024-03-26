// // DatabaseHelper.dart
// import 'package:path/path.dart';

// class User {
//   final int? id;
//   final String username;
//   final String password;

//   User({this.id, required this.username, required this.password});

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'username': username,
//       'password': password,
//     };
//   }
// }

// class DatabaseHelper {
//   static Database? _database;

//   Future<Database> get database async {
//     if (_database != null) return _database!;

//     _database = await initDatabase();
//     return _database!;
//   }

//   Future<Database> initDatabase() async {
//     String path = join(await getDatabasesPath(), 'efiasi_app.db');
//     return await openDatabase(
//       path,
//       version: 1,
//       onCreate: (Database db, int version) async {
//         // Create tables here
//         await db.execute(
//           "CREATE TABLE users(id INTEGER PRIMARY KEY, username TEXT, password TEXT)",
//         );
//       },
//     );
//   }

//   Future<void> insertUser(User user) async {
//     final Database db = await database;
//     await db.insert(
//       'users',
//       user.toMap(),
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//   }

//   Future<List<User>> getUsers() async {
//     final Database db = await database;
//     final List<Map<String, dynamic>> maps = await db.query('users');
//     return List.generate(maps.length, (i) {
//       return User(
//         id: maps[i]['id'],
//         username: maps[i]['username'],
//         password: maps[i]['password'],
//       );
//     });
//   }
// }
