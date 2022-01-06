import 'package:moor_flutter/moor_flutter.dart';

part 'moor_db.g.dart';

class MoorTransactions extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get title => text()();

  RealColumn get amount => real()();

  DateTimeColumn get date => dateTime()();
}

@UseMoor(tables: [MoorTransactions], daos: [TransactionDao])
class TransactionDatabase extends _$TransactionDatabase {
  TransactionDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(
            path: 'transaction.sqlite', logStatements: true));

  @override
  int get schemaVersion => 1;
}

@UseDao(tables: [MoorTransactions])
class TransactionDao extends DatabaseAccessor<TransactionDatabase>
    with _$TransactionDaoMixin {
  TransactionDatabase db;

  TransactionDao(this.db) : super(db);

  Future<List<MoorTransaction>> getAllTransactions() =>
      select(moorTransactions).get();

  Stream<List<MoorTransaction>> watchLastWeekTransactions(DateTime _dateTime) {
    return (select(moorTransactions)
          ..where((t) => t.date.date.isBetweenValues(
              _dateTime.subtract(const Duration(days: 7)).toIso8601String(),
              _dateTime.toIso8601String())))
        .watch();
  }

  Stream<List<MoorTransaction>> watchAllTransactions() =>
      select(moorTransactions).watch();

  Future<int> insertTransaction(MoorTransactionsCompanion transaction) =>
      into(moorTransactions).insert(transaction);

  Future deleteTransaction(MoorTransaction transaction) =>
      delete(moorTransactions).delete(transaction);
}
