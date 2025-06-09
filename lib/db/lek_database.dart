import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/lek.dart';

class LekDatabase {
  static final LekDatabase instance = LekDatabase._init();

  static Database? _database;

  LekDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('leki.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE leki (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nazwa TEXT NOT NULL,
        ilosc INTEGER NOT NULL,
        dataWaznosci TEXT NOT NULL,
        opis TEXT
      )
    ''');
  }

  Future<Lek> create(Lek lek) async {
    final db = await instance.database;
    final id = await db.insert('leki', lek.toMap());
    return lek.copyWith(id: id);
  }

  Future<List<Lek>> getAll() async {
    final db = await instance.database;
    final result = await db.query('leki');
    return result.map((map) => Lek.fromMap(map)).toList();
  }

  Future<void> delete(int id) async {
    final db = await instance.database;
    await db.delete('leki', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> clear() async {
    final db = await instance.database;
    await db.delete('leki');
  }

  Future<void> close() async {
    final db = await instance.database;
    db.close();
  }
}