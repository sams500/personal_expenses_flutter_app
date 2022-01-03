import 'dart:async';
// 1
import 'database_helper.dart';
import '../../models/transaction.dart';

class SqliteRepository {
  // 3
  final dbHelper = DatabaseHelper.instance;

  Future<List<Transaction>> findAllTransactions() {
    return dbHelper.findAllTransactions();
  }

  Stream<List<Transaction>> watchAllTransactions() {
    return dbHelper.watchAllTransactions();
  }

  Future<Transaction> findTransactionByID(int id){
    return dbHelper.findTransactionByID(id);
  }


  Future<Transaction> insertTransaction(Transaction transaction){
     return dbHelper.insertTransaction(transaction);
  }

  Future<void> deleteTransaction(Transaction transaction){
    dbHelper.deleteTransaction(transaction);
    return Future.value();
  }

  Future init() async{
    await dbHelper.database;
    return Future.value();
  }

  void close(){
    dbHelper.close();
  }
}
