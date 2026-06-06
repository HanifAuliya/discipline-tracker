import 'package:flutter/material.dart';

import '../../models/schedule_model.dart';
import '../../services/schedule_service.dart';

import 'add_schedule_screen.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  late List<ScheduleModel> schedules;

  @override
  void initState() {
    super.initState();
    schedules = ScheduleService().getDefaultSchedules();
  }

  void deleteSchedule(int index) {
    setState(() {
      schedules.removeAt(index);
    });
  }

  IconData getReminderIcon(ReminderMode mode) {
    switch (mode) {
      case ReminderMode.silent:
        return Icons.volume_off;
      case ReminderMode.notification:
        return Icons.notifications;
      case ReminderMode.alarm:
        return Icons.alarm;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Jadwal Harian")),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddScheduleScreen()),
          );

          if (result != null) {
            setState(() {
              schedules.add(
                ScheduleModel(
                  title: result["title"],
                  category: result["category"],
                  time: result["time"],
                ),
              );
            });
          }
        },
        child: const Icon(Icons.add),
      ),

      body: ListView.builder(
        itemCount: schedules.length,
        itemBuilder: (_, index) {
          final item = schedules[index];

          return Card(
            child: ListTile(
              leading: Icon(getReminderIcon(item.reminderMode)),

              title: Text(item.title),

              subtitle: Text(
                "${item.time} • ${item.category} • ${item.reminderMode.name}",
              ),

              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Checkbox(
                    value: item.isDone,
                    onChanged: (value) {
                      setState(() {
                        item.isDone = value ?? false;
                      });
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => deleteSchedule(index),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
