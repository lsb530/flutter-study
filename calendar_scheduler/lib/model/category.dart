import 'package:drift/drift.dart';

class CategoryTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get color => text()();

  IntColumn get randomNumber => integer()();

  IntColumn get randomNumber2 => integer()();

  DateTimeColumn get createdAt => dateTime().clientDefault(
        () => DateTime.now().toUtc(),
  )();
}