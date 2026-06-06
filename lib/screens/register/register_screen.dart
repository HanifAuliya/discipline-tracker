import 'package:flutter/material.dart';

import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';

import '../../models/user_model.dart';
import '../../services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameController = TextEditingController();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final ageController = TextEditingController();

  final heightController = TextEditingController();

  final weightController = TextEditingController();

  final bodyFatController = TextEditingController();

  Future<void> register() async {
    if (nameController.text.trim().isEmpty) {
      showMessage("Nama wajib diisi");
      return;
    }

    if (emailController.text.trim().isEmpty) {
      showMessage("Email wajib diisi");
      return;
    }

    if (passwordController.text.trim().length < 6) {
      showMessage("Password minimal 6 karakter");
      return;
    }

    final user = UserModel(
      name: nameController.text,
      email: emailController.text,
      age: int.tryParse(ageController.text) ?? 0,
      height: double.tryParse(heightController.text) ?? 0,
      startWeight: double.tryParse(weightController.text) ?? 0,
      targetBodyFat: double.tryParse(bodyFatController.text) ?? 0,
    );

    await AuthService().register(user, passwordController.text);
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void dispose() {
    nameController.dispose();

    emailController.dispose();

    passwordController.dispose();

    ageController.dispose();

    heightController.dispose();

    weightController.dispose();

    bodyFatController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create Account")),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Column(
                children: [
                  const SizedBox(height: 20),

                  const Text(
                    "Let's Start Your Journey 🚀",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 10),

                  const Text("Create your account and set your goals"),

                  const SizedBox(height: 30),

                  CustomTextField(
                    label: "Nama",
                    icon: Icons.person_outline,
                    controller: nameController,
                  ),

                  const SizedBox(height: 16),

                  CustomTextField(
                    label: "Email",
                    icon: Icons.email_outlined,
                    controller: emailController,
                  ),

                  const SizedBox(height: 16),

                  CustomTextField(
                    label: "Password",
                    icon: Icons.lock_outline,
                    controller: passwordController,
                    obscure: true,
                  ),

                  const SizedBox(height: 16),

                  CustomTextField(
                    label: "Umur",
                    icon: Icons.cake_outlined,
                    controller: ageController,
                  ),

                  const SizedBox(height: 16),

                  CustomTextField(
                    label: "Tinggi Badan (cm)",
                    icon: Icons.height,
                    controller: heightController,
                  ),

                  const SizedBox(height: 16),

                  CustomTextField(
                    label: "Berat Awal (kg)",
                    icon: Icons.monitor_weight_outlined,
                    controller: weightController,
                  ),

                  const SizedBox(height: 16),

                  CustomTextField(
                    label: "Target Body Fat (%)",
                    icon: Icons.track_changes,
                    controller: bodyFatController,
                  ),

                  const SizedBox(height: 30),

                  CustomButton(text: "Register", onPressed: register),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
