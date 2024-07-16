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
          "CREATE TABLE IF NOT EXISTS contacts(id INTEGER PRIMARY KEY, name TEXT)",
        );
        await db.execute(
          "CREATE TABLE IF NOT EXISTS transactionsform(id INTEGER PRIMARY KEY, amount INTEGER, notes TEXT,status TEXT ,date TEXT, duedate Text, contact_id INTEGER, contact_name TEXT, FOREIGN KEY(contact_id) REFERENCES contacts(id))",
        );
        await db.execute(
          "CREATE TABLE IF NOT EXISTS completedtransactions(id INTEGER PRIMARY KEY, amount INTEGER, notes TEXT, date TEXT, contact_id INTEGER, contact_name TEXT, FOREIGN KEY(contact_id) REFERENCES contacts(id))",
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

  Future<List<Map<String, dynamic>>> getAllTransactions() async {
    final db = await database;
    return await db.query('transactionsform');
  }

  Future<void> deleteTransaction(int id) async {
    final db = await database;
    await db.delete(
      'transactionsform',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> insertCompletedTransaction(
      Map<String, dynamic> transaction) async {
    final db = await database;
    await db.insert(
      'completedtransactions',
      transaction,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> calculateTotalAmount() async {
    final db = await database;
    final result =
        await db.rawQuery('SELECT SUM(amount) as total FROM transactionsform');
    return result.first['total'] != null ? result.first['total'] as int : 0;
  }

  Future<List<Map<String, dynamic>>> getAllContacts() async {
    final db = await database;
    return await db.query('contacts');
  }

  Future<List<Map<String, dynamic>>> getAllCompletedTransactions() async {
    final db = await database;
    return await db.query('completedtransactions');
  }

  Future<void> updateTransaction(Map<String, dynamic> transaction) async {
    final db = await database;
    await db.update(
      'transactionsform',
      transaction,
      where: 'id = ?',
      whereArgs: [transaction['id']],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getAllTransactionsGave() async {
    final db = await database;
    return await db
        .query('transactionsform', where: 'status = ?', whereArgs: ['Gave']);
  }

  Future<List<Map<String, dynamic>>> getAllTransactionsReceived() async {
    final db = await database;
    return await db.query('transactionsform',
        where: 'status = ?', whereArgs: ['Received']);
  }
}
