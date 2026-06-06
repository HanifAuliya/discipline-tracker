import 'package:flutter/material.dart';

import '../../models/habit_model.dart';
import '../../services/habit_service.dart';

class HabitScreen extends StatefulWidget {
  const HabitScreen({super.key});

  @override
  State<HabitScreen> createState() => _HabitScreenState();
}

class _HabitScreenState extends State<HabitScreen> {
  late List<HabitModel> habits;

  @override
  void initState() {
    super.initState();

    habits = HabitService().getDefaultHabits();
  }

  int get completedHabits {
    return habits.where((e) => e.isDone).length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Habit Tracker")),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Text(
                  "$completedHabits / ${habits.length}",
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const Text("Habit Selesai"),
              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: habits.length,
              itemBuilder: (_, index) {
                final habit = habits[index];

                return CheckboxListTile(
                  value: habit.isDone,

                  title: Text(habit.title),

                  onChanged: (value) {
                    setState(() {
                      habit.isDone = value ?? false;
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
