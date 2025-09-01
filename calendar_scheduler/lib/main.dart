import 'package:flutter/material.dart';
import 'package:calendar_scheduler/screen/home_screen.dart';
import 'package:calendar_scheduler/const/color.dart';
import 'package:drift/drift.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:calendar_scheduler/database/drift.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting();

  final database = AppDateBase();

  await database.createSchedule(
    ScheduleTableCompanion(
      startTime: Value(12),
      endTime: Value(12),
      content: Value('Flutter 프로그래밍'),
      date: Value(DateTime.utc(2025,9,1)),
      color: Value(categoryColors.first),
    ),
  );
  final resp = await database.getSchedules();

  print('------------------------');
  print(resp);

  runApp(
    MaterialApp(
      theme: ThemeData(
        fontFamily: 'NotoSans',
      ),
      home: HomeScreen(),
    ),
  );
}
