import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/customer.dart';
import '../models/transaction_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;
  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('ledger.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE customers (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        balance REAL NOT NULL
      )
    ''');
    await db.execute('''
      CREATE TABLE transactions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        customerId INTEGER,
        amount REAL,
        type TEXT,
        FOREIGN KEY (customerId) REFERENCES customers (id)
      )
    ''');
  }

  Future<int> insertCustomer(Customer customer) async {
    final db = await instance.database;
    return await db.insert('customers', customer.toMap());
  }

  Future<List<Customer>> getCustomers() async {
    final db = await instance.database;
    final result = await db.query('customers');
    return result.map((e) => Customer.fromMap(e)).toList();
  }

  Future<int> insertTransaction(TransactionModel txn) async {
    final db = await instance.database;
    return await db.insert('transactions', txn.toMap());
  }

  Future<List<TransactionModel>> getTransactions(int customerId) async {
    final db = await instance.database;
    final result = await db.query(
      'transactions',
      where: 'customerId = ?',
      whereArgs: [customerId],
    );
    return result.map((e) => TransactionModel.fromMap(e)).toList();
  }
}

