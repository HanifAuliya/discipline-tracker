import 'package:flutter/material.dart';

import '../../models/schedule_model.dart';
import '../../services/schedule_service.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Jadwal Harian")),

      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),

      body: ListView.builder(
        itemCount: schedules.length,

        itemBuilder: (_, index) {
          final item = schedules[index];

          return Card(
            child: ListTile(
              leading: Checkbox(
                value: item.isDone,
                onChanged: (value) {
                  setState(() {
                    item.isDone = value ?? false;
                  });
                },
              ),

              title: Text(item.title),

              subtitle: Text("${item.time} • ${item.category}"),

              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  deleteSchedule(index);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
