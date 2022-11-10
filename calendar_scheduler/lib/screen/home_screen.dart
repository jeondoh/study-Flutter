import 'package:calendar_scheduler/components/schedule_card.dart';
import 'package:calendar_scheduler/components/today_banner.dart';
import 'package:calendar_scheduler/const/colors.dart';
import 'package:calendar_scheduler/database/drift_database.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../components/calendar.dart';
import '../components/schedule_bottom_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDay = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  DateTime focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Calendar(
              onDaySelected: onDaySelected,
              selectedDay: selectedDay,
              focusedDay: focusedDay,
            ),
            const SizedBox(height: 8.0),
            TodayBanner(
              selectedDay: selectedDay,
              scheduleCount: 3,
            ),
            const SizedBox(height: 8.0),
            _ScheduleList(selectedDate: selectedDay),
          ],
        ),
      ),
      floatingActionButton: renderFloatingActionButton(),
    );
  }

  FloatingActionButton renderFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (_) {
            return ScheduleBottomSheet(selectedDate: selectedDay);
          },
        );
      },
      backgroundColor: PRIMARY_COLOR,
      child: const Icon(Icons.add),
    );
  }

  onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      this.selectedDay = selectedDay;
      this.focusedDay = selectedDay;
    });
  }
}

class _ScheduleList extends StatelessWidget {
  final DateTime selectedDate;
  const _ScheduleList({Key? key, required this.selectedDate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: StreamBuilder<List<Schedule>>(
            stream: GetIt.I<LocalDatabase>().watchSchedules(),
            builder: (context, snapshot) {
              List<Schedule> schedules = [];
              if (snapshot.hasData) {
                schedules = snapshot.data!
                    .where((element) => element.date == selectedDate)
                    .toList();
              }

              return ListView.separated(
                itemCount: 3,
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 8.0);
                },
                itemBuilder: (context, index) {
                  return ScheduleCard(
                    startTime: 8,
                    endTime: 12,
                    content: 'programming study',
                    color: Colors.red,
                  );
                },
              );
            }),
      ),
    );
  }
}
