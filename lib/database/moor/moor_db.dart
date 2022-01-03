import 'package:moor_flutter/moor_flutter.dart';
import '../../models/transaction.dart';

part 'moor_db.g.dart';

class Transactions extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get title => text()();

  RealColumn get amount => real()();

  DateTimeColumn get date => dateTime()();
}

@UseMoor(tables: [Transactions])
class TransactionDatabase extends _$TransactionDatabase {
  TransactionDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(
            path: 'transaction.sqlite', logStatements: true));

  @override
  int get schemaVersion => 1;


}
