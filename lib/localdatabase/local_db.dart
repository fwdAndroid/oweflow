import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseMethod {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    final String path = join(await getDatabasesPath(), 'app_database.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          "CREATE TABLE IF NOT EXISTS contacts(id INTEGER PRIMARY KEY, name TEXT, email TEXT, phonenumber TEXT)",
        );
        await db.execute(
          "CREATE TABLE IF NOT EXISTS transactionsform(id INTEGER PRIMARY KEY, amount INTEGER, notes TEXT, date TEXT,contact_id INTEGER, contact_name TEXT,FOREIGN KEY(contact_id) REFERENCES contacts(id))",
        );
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 1) {}
      },
    );
  }

  Future<void> insertContact(Map<String, dynamic> contact) async {
    final db = await database;
    await db.insert(
      'contacts',
      contact,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> inserttransactionsform(Map<String, dynamic> event) async {
    final db = await database;
    await db.insert(
      'transactionsform',
      event,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getAllContacts() async {
    final db = await database;
    return await db.query('contacts');
  }
}
