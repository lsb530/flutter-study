import 'dart:io';
import 'package:calendar_scheduler/model/category.dart';
import 'package:calendar_scheduler/model/schedule.dart';
import 'package:calendar_scheduler/model/schedule_with_category.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:sqlite3/sqlite3.dart';

part 'drift.g.dart';

@DriftDatabase(
  tables: [
    ScheduleTable,
    CategoryTable,
  ],
)
class AppDateBase extends _$AppDateBase {
  AppDateBase() : super(_openConnection());

  Future<ScheduleTableData> getScheduleById(int id) => (select(
    scheduleTable,
  )..where((table) => table.id.equals(id))).getSingle();

  Future<int> updateScheduleById(int id, ScheduleTableCompanion data) =>
      (update(
        scheduleTable,
      )..where((table) => table.id.equals(id))).write(data);

  Future<List<ScheduleTableData>> getSchedules(
    DateTime date,
  ) => (select(scheduleTable)..where((table) => table.date.equals(date))).get();

  Stream<List<ScheduleWithCategory>> streamSchedules(
    DateTime date,
  ) {
    final query = select(scheduleTable).join(
      [
        innerJoin(
          categoryTable,
          categoryTable.id.equalsExp(scheduleTable.colorId),
        ),
      ],
    )..where(scheduleTable.date.equals(date));

    return query.map((row) {
      final schedule = row.readTable(scheduleTable);
      final category = row.readTable(categoryTable);

      return ScheduleWithCategory(
        category: category,
        schedule: schedule,
      );
    }).watch();

    /*
     (select(scheduleTable)
            ..where((table) => table.date.equals(date))
            ..orderBy([
              (table) => OrderingTerm(
                expression: table.startTime,
                mode: OrderingMode.asc,
              ),
              (table) => OrderingTerm(
                expression: table.endTime,
                mode: OrderingMode.asc,
              ),
            ]))
          .watch();
     */
  }

  Future<int> createSchedule(ScheduleTableCompanion data) =>
      into(scheduleTable).insert(data);

  Future<int> removeSchedule(
    int id,
  ) =>
      (delete(scheduleTable)..where(
            (table) => table.id.equals(id),
          ))
          .go();

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
