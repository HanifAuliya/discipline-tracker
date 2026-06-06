import 'package:flutter/material.dart';
import '../../models/schedule_model.dart';

class EditScheduleScreen extends StatefulWidget {
  final ScheduleModel schedule;

  const EditScheduleScreen({super.key, required this.schedule});

  @override
  State<EditScheduleScreen> createState() => _EditScheduleScreenState();
}

class _EditScheduleScreenState extends State<EditScheduleScreen> {
  late TextEditingController titleController;
  late TextEditingController categoryController;
  late TimeOfDay selectedTime;
  late ReminderMode selectedMode;
  late String selectedRingtone;

  @override
  void initState() {
    super.initState();

    titleController = TextEditingController(text: widget.schedule.title);
    categoryController = TextEditingController(text: widget.schedule.category);
    selectedMode = widget.schedule.reminderMode;
    selectedRingtone = widget.schedule.ringtone;

    final split = widget.schedule.time.split(":");
    selectedTime = TimeOfDay(
      hour: int.parse(split[0]),
      minute: int.parse(split[1]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Jadwal")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: "Nama Aktivitas"),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: categoryController,
              decoration: const InputDecoration(labelText: "Kategori"),
            ),

            const SizedBox(height: 16),

            ListTile(
              title: Text(
                "${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}",
              ),
              trailing: const Icon(Icons.access_time),
              onTap: () async {
                final result = await showTimePicker(
                  context: context,
                  initialTime: selectedTime,
                );
                if (result != null) {
                  setState(() {
                    selectedTime = result;
                  });
                }
              },
            ),

            const SizedBox(height: 16),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Mode Pengingat",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),

            RadioListTile<ReminderMode>(
              title: const Text("Silent"),
              secondary: const Icon(Icons.volume_off),
              value: ReminderMode.silent,
              groupValue: selectedMode,
              onChanged: (value) => setState(() => selectedMode = value!),
            ),

            RadioListTile<ReminderMode>(
              title: const Text("Notification"),
              secondary: const Icon(Icons.notifications),
              value: ReminderMode.notification,
              groupValue: selectedMode,
              onChanged: (value) => setState(() => selectedMode = value!),
            ),

            RadioListTile<ReminderMode>(
              title: const Text("Alarm"),
              secondary: const Icon(Icons.alarm),
              value: ReminderMode.alarm,
              groupValue: selectedMode,
              onChanged: (value) => setState(() => selectedMode = value!),
            ),

            const SizedBox(height: 16),

            DropdownButtonFormField<String>(
              value: selectedRingtone,
              decoration: const InputDecoration(labelText: "Nada Dering"),
              items: const [
                DropdownMenuItem(value: "default", child: Text("Default")),
                DropdownMenuItem(value: "adzan", child: Text("Adzan")),
                DropdownMenuItem(value: "bell", child: Text("Bell")),
                DropdownMenuItem(value: "digital", child: Text("Digital")),
              ],
              onChanged: (value) {
                setState(() {
                  selectedRingtone = value!;
                });
              },
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(
                    context,
                    ScheduleModel(
                      title: titleController.text,
                      category: categoryController.text,
                      time:
                          "${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}",
                      reminderMode: selectedMode,
                      ringtone: selectedRingtone,
                    ),
                  );
                },
                child: const Text("Update"),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
