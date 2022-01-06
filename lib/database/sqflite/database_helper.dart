import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlbrite/sqlbrite.dart';
import 'package:synchronized/synchronized.dart';
import 'transaction.dart' as myTransaction;

class DatabaseHelper {
  static const _databaseName = 'Transaction.db';
  static const _databaseVersion = 1;

  static const _transactionTable = 'TransactionTable';
  static const _transactionID = 'transactionID';

  static late BriteDatabase _streamDatabase;

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static var lock = Lock();

  static Database? _database;

  // Function to create the Database
  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE  TABLE $_transactionTable(
      $_transactionID INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT NOT NULL,
      amount REAL NOT NULL,
      date TEXT NOT NULL,
      )''');
  }

  Future<Database> _initDatabase() async {
    final documentDirectory = await getApplicationDocumentsDirectory();

    final path = join(documentDirectory.path, _databaseName);

    Sqflite.setDebugModeOn(true);

    return openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  Future<Database> get database async {
    if (_database != null) return _database!;

    await lock.synchronized(() async {
      if (_database == null) {
        _database = await _initDatabase();

        _streamDatabase = BriteDatabase(_database!);
      }
    });
    return _database!;
  }

  Future<BriteDatabase> get streamDatabase async {
    await database;
    return _streamDatabase;
  }

  List<myTransaction.Transaction> parseTransactions(
      List<Map<String, dynamic>> transactionList) {
    final transactions = <myTransaction.Transaction>[];

    for (var trans in transactionList) {
      final transaction = myTransaction.Transaction.fromJson(trans);
      transactions.add(transaction);
    }
    return transactions;
  }

  Future<List<myTransaction.Transaction>> findAllTransactions() async {
    final db = await instance.streamDatabase;
    final transactionList = await db.query(_transactionTable);
    final transactions = parseTransactions(transactionList);

    return transactions;
  }

  Stream<List<myTransaction.Transaction>> watchAllTransactions() async* {
    final db = await instance.streamDatabase;

    yield* db
        .createQuery(_transactionTable)
        .mapToList((row) => myTransaction.Transaction.fromJson(row));
  }

  Future<myTransaction.Transaction> findTransactionByID(int id) async{
    final db = await instance.streamDatabase;
    final transactionList = await db.query(_transactionTable, where:'id == $id');
    final transaction = parseTransactions(transactionList);
    return transaction.first;
  }


  Future<int> _insert(String table, Map<String, dynamic> row) async{
    final db = await instance.streamDatabase;

    return db.insert(table, row);
  }

  Future<myTransaction.Transaction> insertTransaction(myTransaction.Transaction transaction) async{
    final id = await _insert(_transactionTable, transaction.toJson());
    return transaction.copy(id: id);
  }

  Future<int> _delete(String table, String columnID, int id) async{
    final db = await instance.streamDatabase;

    return db.delete(table, where: '$columnID == ?', whereArgs: [id]);

  }
  Future<int> deleteTransaction(myTransaction.Transaction transaction) async{
    return _delete(_transactionTable, _transactionID, transaction.id!);
  }

  void close(){
    _streamDatabase.close();
  }

}
