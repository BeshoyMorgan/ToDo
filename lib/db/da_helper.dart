import 'package:sqflite/sqflite.dart';
import '../model/task.dart';
import 'package:path/path.dart';

class DBHelper {
  static Database? _db;
  static final int _version = 1;
  static final String _tableName = 'tasks';
  static Future<void> initDB() async {
    if (_db != null) {
      return;
    } else {
      try {
        String _pathDB = await getDatabasesPath();
        String _path = join(_pathDB, 'task.db');
        _db = await openDatabase(_path, version: _version, onCreate: (Database db, int version) async {
          // When creating the db, create the table
          await db.execute('CREATE TABLE $_tableName (id INTEGER PRIMARY KEY AUTOINCREMENT, '
              'title STRING, note STRING, '
              'isCompleted STRING, '
              'date STRING, '
              'startTime STRING, '
              'endTime STRING, '
              'color INTEGER, '
              'remind INTEGER, '
              'REPEAT STRING)');
        });
        print('create db');
      } catch (e) {
        print(e);
        print('error');
      }
    }
  }

  //insert into db
  Future<int> insert(Task task) async {
    return await _db!.insert(_tableName, task.toJson());
  }

  Future<int> update(int index) async {
    return await _db!.rawUpdate(''' 
          UPDATE tasks
          SET isCompleted=?
          WHERE id=?
     ''', [
      1,
      index
    ]);
  }

  Future<int> delete(Task task) async {
    return await _db!.delete(_tableName, where: 'id=?', whereArgs: [
      task.id
    ]);
  }

  Future<int> deleteAll() async {
    return await _db!.delete(_tableName);
  }

  Future<List<Map<String, dynamic>>> query() async {
    return await _db!.query(_tableName);
  }
}
