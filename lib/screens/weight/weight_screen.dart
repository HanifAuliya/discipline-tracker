import 'package:flutter/material.dart';

class WeightScreen extends StatefulWidget {
  const WeightScreen({super.key});

  @override
  State<WeightScreen> createState() => _WeightScreenState();
}

class _WeightScreenState extends State<WeightScreen> {
  final controller = TextEditingController();

  final List<double> weights = [74];

  void addWeight() {
    final weight = double.tryParse(controller.text);

    if (weight == null) {
      return;
    }

    setState(() {
      weights.add(weight);
    });

    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Weight Tracker')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Berat Badan'),
            ),

            const SizedBox(height: 10),

            ElevatedButton(onPressed: addWeight, child: const Text('Tambah')),

            const SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                itemCount: weights.length,
                itemBuilder: (_, index) {
                  return ListTile(
                    leading: const Icon(Icons.monitor_weight),
                    title: Text('${weights[index]} kg'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
