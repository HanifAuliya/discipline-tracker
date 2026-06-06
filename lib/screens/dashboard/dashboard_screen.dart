import 'package:flutter/material.dart';
import '../../services/weight_service.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  Widget buildCard(String title, String value) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(title),
            const SizedBox(height: 10),
            Text(
              value,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final weightService = WeightService();

    const currentWeight = 74.0;

    const height = 170.0;

    const targetBodyFat = 15.0;

    final bmi = weightService.calculateBMI(
      weight: currentWeight,
      height: height,
    );

    final targetWeight = weightService.calculateTargetWeight(
      currentWeight: currentWeight,
      targetBodyFat: targetBodyFat,
    );

    final remaining = weightService.calculateRemainingWeight(
      currentWeight: currentWeight,
      targetWeight: targetWeight,
    );

    final weeks = weightService.estimateWeeks(remainingWeight: remaining);
    return Scaffold(
      appBar: AppBar(title: const Text("Dashboard")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const Text(
              "Halo Hanief 👋",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            buildCard("Progress Hari Ini", "0 / 10"),

            buildCard("Berat Saat Ini", "74 kg"),

            buildCard("Target Body Fat", "15 %"),

            // ← tambahkan 4 card ini di sini
            buildCard("BMI Saat Ini", bmi.toStringAsFixed(1)),

            buildCard("Target Berat", "${targetWeight.toStringAsFixed(1)} kg"),

            buildCard("Sisa Turun", "${remaining.toStringAsFixed(1)} kg"),

            buildCard("Estimasi", "$weeks Minggu"),

            const SizedBox(height: 20),

            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: const [
                Card(child: Center(child: Text("Jadwal"))),
                Card(child: Center(child: Text("Habit"))),
                Card(child: Center(child: Text("Workout"))),
                Card(child: Center(child: Text("Weight"))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
