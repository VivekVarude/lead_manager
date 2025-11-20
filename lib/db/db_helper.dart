import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/lead.dart';

class DBHelper {
  static final DBHelper instance = DBHelper._internal();
  DBHelper._internal();

  static Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'lead_manager.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE leads (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          contact TEXT,
          notes TEXT,
          status TEXT
        )
        ''');
      },
    );
  }

  Future<int> insertLead(Lead lead) async {
    final db = await database;
    return await db.insert('leads', lead.toMap());
  }

  Future<List<Lead>> getLeads() async {
    final db = await database;
    final result = await db.query('leads');
    return result.map((e) => Lead.fromMap(e)).toList();
  }

  Future<int> updateLead(Lead lead) async {
    final db = await database;
    return await db.update(
      'leads',
      lead.toMap(),
      where: 'id = ?',
      whereArgs: [lead.id],
    );
  }

  Future<int> deleteLead(int id) async {
    final db = await database;
    return await db.delete(
      'leads',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
