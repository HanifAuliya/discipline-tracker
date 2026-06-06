import 'package:flutter/material.dart';

import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create Account")),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),

                      const Text(
                        "Let's Start Your Journey 🚀",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      const Text("Create your account and set your goals"),

                      const SizedBox(height: 30),

                      const CustomTextField(
                        label: "Nama",
                        icon: Icons.person_outline,
                      ),

                      const SizedBox(height: 16),

                      const CustomTextField(
                        label: "Email",
                        icon: Icons.email_outlined,
                      ),

                      const SizedBox(height: 16),

                      const CustomTextField(
                        label: "Password",
                        icon: Icons.lock_outline,
                        obscure: true,
                      ),

                      const SizedBox(height: 16),

                      const CustomTextField(
                        label: "Umur",
                        icon: Icons.cake_outlined,
                      ),

                      const SizedBox(height: 16),

                      const CustomTextField(
                        label: "Tinggi Badan (cm)",
                        icon: Icons.height,
                      ),

                      const SizedBox(height: 16),

                      const CustomTextField(
                        label: "Berat Awal (kg)",
                        icon: Icons.monitor_weight_outlined,
                      ),

                      const SizedBox(height: 16),

                      const CustomTextField(
                        label: "Target Body Fat (%)",
                        icon: Icons.track_changes,
                      ),

                      const SizedBox(height: 30),

                      CustomButton(
                        text: "Register",
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
