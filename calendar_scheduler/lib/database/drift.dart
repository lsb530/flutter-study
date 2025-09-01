import 'dart:io';
import 'package:calendar_scheduler/model/schedule.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:sqlite3/sqlite3.dart';

part 'drift.g.dart';

@DriftDatabase(tables: [ScheduleTable])
class AppDateBase extends _$AppDateBase {
  AppDateBase() : super(_openConnection());

  Future<List<ScheduleTableData>> getSchedules(
    DateTime date,
  ) => (select(scheduleTable)..where((table) => table.date.equals(date))).get();

  Future<int> createSchedule(ScheduleTableCompanion data) =>
      into(scheduleTable).insert(data);

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    final cacheDatabase = await getTemporaryDirectory();

    sqlite3.tempDirectory = cacheDatabase.path;

    return NativeDatabase.createInBackground(file);
  });
}
