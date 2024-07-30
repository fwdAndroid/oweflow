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
          "CREATE TABLE IF NOT EXISTS transactionsform(id INTEGER PRIMARY KEY, amount INTEGER, notes TEXT,status TEXT ,date TEXT, duedate Text, type TEXT ,contact_id INTEGER, contact_name TEXT, FOREIGN KEY(contact_id) REFERENCES contacts(id))",
        );
        await db.execute(
          "CREATE TABLE IF NOT EXISTS completedtransactions(id INTEGER PRIMARY KEY, amount INTEGER, notes TEXT,status TEXT ,date TEXT, duedate Text, type TEXT,contact_id INTEGER, contact_name TEXT, FOREIGN KEY(contact_id) REFERENCES contacts(id))",
        );
        await db.execute(
          "CREATE TABLE IF NOT EXISTS schedules(id INTEGER PRIMARY KEY, amount INTEGER, notes TEXT ,date TEXT, listRecrudesce Text, listRemainders TEXT,contact_id INTEGER, contact_name TEXT, FOREIGN KEY(contact_id) REFERENCES contacts(id))",
        );
        await db.execute(
          "CREATE TABLE IF NOT EXISTS goals(id INTEGER PRIMARY KEY, amount INTEGER, notes TEXT, name TEXT, date TEXT)",
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

  Future<void> insertSchedule(
    String contactId,
    int amount,
    String notes,
    String contactName,
    String date,
    String recurrence,
    String remainders,
  ) async {
    final db = await database;
    await db.insert(
      'schedules',
      {
        'contact_id': contactId,
        'amount': amount,
        'notes': notes,
        'date': date,
        'listRecrudesce': recurrence,
        'listRemainders': remainders,
        'contact_name': contactName,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print("Schedule inserted into the database");
  }

  Future<void> insertGoal(
    int amount,
    String notes,
    String name,
    String date,
  ) async {
    final db = await database;
    await db.insert(
      'goals',
      {
        'name': name,
        'amount': amount,
        'notes': notes,
        'date': date,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print("Schedule inserted into the database");
  }

  Future<List<Map<String, dynamic>>> getAllTransactions() async {
    final db = await database;
    return await db.query('transactionsform');
  }

  Future<List<Map<String, dynamic>>> getSchedules() async {
    final db = await database;
    return await db.query('schedules');
  }

  Future<List<Map<String, dynamic>>> getGoals() async {
    final db = await database;
    return await db.query('goals');
  }

  Future<void> deleteTransaction(int id) async {
    final db = await database;
    await db.delete(
      'transactionsform',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteSchedules(int id) async {
    final db = await database;
    await db.delete(
      'schedules',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteGoals(int id) async {
    final db = await database;
    await db.delete(
      'goals',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  insertCompletedTransaction(Map<String, dynamic> transaction) async {
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
