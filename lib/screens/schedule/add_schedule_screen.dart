import 'package:flutter/material.dart';

class AddScheduleScreen extends StatefulWidget {
  const AddScheduleScreen({super.key});

  @override
  State<AddScheduleScreen> createState() => _AddScheduleScreenState();
}

class _AddScheduleScreenState extends State<AddScheduleScreen> {
  final titleController = TextEditingController();

  final categoryController = TextEditingController();

  TimeOfDay selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tambah Jadwal")),

      body: Padding(
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

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, {
                    "title": titleController.text,
                    "category": categoryController.text,
                    "time":
                        "${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}",
                  });
                },
                child: const Text("Simpan"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
