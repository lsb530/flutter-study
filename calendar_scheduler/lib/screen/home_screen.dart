import 'package:calendar_scheduler/component/schedule_bottom_sheet.dart';
import 'package:calendar_scheduler/component/schedule_card.dart';
import 'package:calendar_scheduler/component/today_banner.dart';
import 'package:calendar_scheduler/const/color.dart';
import 'package:calendar_scheduler/database/drift.dart';
import 'package:calendar_scheduler/model/schedule.dart';
import 'package:flutter/material.dart';
import 'package:calendar_scheduler/component/calendar.dart';
import 'package:get_it/get_it.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDay = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  /// {
  ///   2023-11-23:[Schedule, Schedule],
  ///   2023-11-24:[Schedule, Schedule]
  /// }
  // Map<DateTime, List<ScheduleTable>> schedules = {
  //   DateTime.utc(2025, 8, 30): [
  //     ScheduleTable(
  //       id: 1,
  //       startTime: 11,
  //       endTime: 12,
  //       content: 'Flutter 공부하기',
  //       date: DateTime.utc(2025, 3, 8),
  //       color: categoryColors[0],
  //       createdAt: DateTime.now().toUtc(),
  //     ),
  //     ScheduleTable(
  //       id: 2,
  //       startTime: 14,
  //       endTime: 16,
  //       content: 'Spring 공부하기',
  //       date: DateTime.utc(2025, 3, 8),
  //       color: categoryColors[2],
  //       createdAt: DateTime.now().toUtc(),
  //     ),
  //   ],
  // };

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final firstDayOfCurrentMonth = DateTime(now.year, now.month, 1);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final schedule = await showModalBottomSheet<ScheduleTable>(
            context: context,
            builder: (_) {
              return ScheduleBottomSheet(selectedDay: selectedDay);
            },
          );

          setState(() { });

          // 방법1
          /*
          final dateExists = schedules.containsKey(schedule.date);

          final List<Schedule> existingSchedules = dateExists
              ? schedules[schedule.date]!
              : [];
          existingSchedules.add(schedule);

          setState(() {
            schedules = {
              ...schedules,
              schedule.date: existingSchedules,
            };
          });
          */

          // 방법2
          // setState(() {
          //   schedules = {
          //     ...schedules,
          //     schedule.date: [
          //       if (schedules.containsKey(schedule.date))
          //         ...schedules[schedule.date]!,
          //       schedule,
          //     ],
          //   };
          // });
        },
        backgroundColor: primaryColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Calendar(
              focusedDay: firstDayOfCurrentMonth.copyWith(
                day: now.day,
              ),
              onDaySelected: onDaySelected,
              selectedDayPredicate: selectedDayPredicate,
            ),
            TodayBanner(
              selectedDay: selectedDay,
              taskCount: 0,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  top: 16.0,
                ),
                child: FutureBuilder<List<ScheduleTableData>>(
                  future: GetIt.I<AppDateBase>().getSchedules(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          snapshot.error.toString(),
                        ),
                      );
                    }

                    if (!snapshot.hasData
                        && snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    final schedules = snapshot.data!;
                    
                    final selectedSchedules = schedules.where(
                        (e) => e.date.isAtSameMomentAs(selectedDay),
                    ).toList();

                    return ListView.separated(
                      itemCount: selectedSchedules.length,
                      itemBuilder: (BuildContext context, int index) {
                        final schedule = selectedSchedules[index];

                        return ScheduleCard(
                          startTime: schedule.startTime,
                          endTime: schedule.endTime,
                          content: schedule.content,
                          color: Color(
                            int.parse(
                              'FF${schedule.color}',
                              radix: 16,
                            ),
                          ),
                        );
                      },

                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(height: 8.0);
                      },
                    );
                  }
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      this.selectedDay = selectedDay;
    });
  }

  bool selectedDayPredicate(DateTime day) {
    return day.isAtSameMomentAs(selectedDay);
  }
}
