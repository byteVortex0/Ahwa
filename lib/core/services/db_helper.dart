import 'package:ahwa/features/home/data/models/order_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static Database? _db;

  static const tableName = "orders";

  static Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await initDB();
    return _db!;
  }

  static Future<Database> initDB() async {
    String path = join(await getDatabasesPath(), 'ahwa_manager.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $tableName (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            customerName TEXT,
            drinkType TEXT,
            instructions TEXT,
            isCompleted INTEGER
          )
        ''');
      },
    );
  }

  Future<int> insertOrder({required OrderModel orderModel}) async {
    final db = await database;
    return await db.insert(tableName, orderModel.toMap());
  }

  Future<List<Map<String, Object?>>> getOrders({
    bool onlyPending = false,
    bool onlyCompleted = false,
  }) async {
    final db = await database;
    if (onlyPending) {
      return await db.query(
        tableName,
        where: "isCompleted = ?",
        whereArgs: [0],
      );
    } else if (onlyCompleted) {
      return await db.query(
        tableName,
        where: "isCompleted = ?",
        whereArgs: [1],
      );
    }
    return await db.query(tableName);
  }

  Future<int> markCompleted(int id) async {
    final db = await database;
    return await db.update(
      tableName,
      {"isCompleted": 1},
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
