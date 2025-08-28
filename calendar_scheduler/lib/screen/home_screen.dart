import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime? selectedDay;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final firstDayOfCurrentMonth = DateTime(now.year, now.month, 1);

    return Scaffold(
      body: SafeArea(
        child: TableCalendar(
          focusedDay: firstDayOfCurrentMonth.copyWith(
            day: now.day,
          ),
          firstDay: DateTime(
            1800,
          ),
          lastDay: DateTime(
            3000,
          ),
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              this.selectedDay = selectedDay;
            });
          },
          selectedDayPredicate: (day) {
            if (selectedDay == null) {
              return false;
            }

            return day.isAtSameMomentAs(selectedDay!);
          },
        ),
      ),
    );
  }
}
