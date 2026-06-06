import 'package:flutter/material.dart';

import '../../models/schedule_model.dart';
import '../../services/schedule_service.dart';
import '../../services/storage_service.dart';

import 'add_schedule_screen.dart';
import 'edit_schedule_screen.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  List<ScheduleModel> schedules = [];
  final storageService = StorageService();

  @override
  void initState() {
    super.initState();
    loadSchedules();
  }

  Future<void> loadSchedules() async {
    schedules = await storageService.loadSchedules();

    setState(() {});
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
                  reminderMode: result["reminderMode"],
                  ringtone: result["ringtone"],
                ),
              );
            });
            await storageService.saveSchedules(schedules);
          }
        },
        child: const Icon(Icons.add),
      ),

      body: ListView.builder(
        itemCount: schedules.length,
        itemBuilder: (_, index) {
          final item = schedules[index];

          return Card(
            color: item.isDone ? Colors.green.shade50 : null,

            child: ListTile(
              onTap: () async {
                final updated = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        EditScheduleScreen(schedule: schedules[index]),
                  ),
                );

                if (updated != null) {
                  setState(() {
                    schedules[index] = updated;
                  });
                  await storageService.saveSchedules(schedules);
                }
              },

              leading: Icon(
                getReminderIcon(item.reminderMode),
                color: item.isDone ? Colors.green : null,
              ),

              title: Text(
                item.title,
                style: TextStyle(
                  decoration: item.isDone ? TextDecoration.lineThrough : null,

                  color: item.isDone ? Colors.grey : null,
                ),
              ),

              subtitle: Text(
                "${item.time} • ${item.category} • ${item.reminderMode.name}",
                style: TextStyle(color: item.isDone ? Colors.grey : null),
              ),

              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Checkbox(
                    value: item.isDone,
                    onChanged: (value) async {
                      setState(() {
                        item.isDone = value ?? false;
                      });
                      await storageService.saveSchedules(schedules);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () async {
                      final deletedItem = schedules[index];

                      final confirm = await showDialog<bool>(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("Hapus Jadwal"),
                            content: Text(
                              "Yakin ingin menghapus '${deletedItem.title}' ?",
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context, false),
                                child: const Text("Batal"),
                              ),
                              ElevatedButton(
                                onPressed: () => Navigator.pop(context, true),
                                child: const Text("Hapus"),
                              ),
                            ],
                          );
                        },
                      );

                      if (confirm == true) {
                        setState(() {
                          schedules.removeAt(index);
                        });
                        await storageService.saveSchedules(schedules);

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("${deletedItem.title} dihapus"),
                            action: SnackBarAction(
                              label: "URUNGKAN",
                              onPressed: () async {
                                setState(() {
                                  schedules.insert(index, deletedItem);
                                });
                                await storageService.saveSchedules(schedules);
                              },
                            ),
                          ),
                        );
                      }
                    },
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
