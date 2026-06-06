import 'package:flutter/material.dart';

import '../../widgets/app_logo.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';

import '../dashboard/dashboard_screen.dart';
import '../register/register_screen.dart';

import '../../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLoading = false; // ← pindah ke sini

  Future<void> login() async {
    // ← ubah jadi async
    if (emailController.text.isEmpty) {
      showMessage("Email wajib diisi");
      return;
    }

    if (passwordController.text.isEmpty) {
      showMessage("Password wajib diisi");
      return;
    }

    setState(() {
      isLoading = true;
    });

    final success = await AuthService().login(
      email: emailController.text,
      password: passwordController.text,
    );

    setState(() {
      isLoading = false;
    });

    if (success) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const DashboardScreen()),
      );
    }
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Center(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 450),
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 30),
                        const AppLogo(),
                        const SizedBox(height: 40),

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

                        const SizedBox(height: 24),

                        isLoading
                            ? const CircularProgressIndicator()
                            : CustomButton(text: "Login", onPressed: login),

                        const SizedBox(height: 20),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Belum punya akun?"),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const RegisterScreen(),
                                  ),
                                );
                              },
                              child: const Text("Register"),
                            ),
                          ],
                        ),
                      ],
                    ),
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
