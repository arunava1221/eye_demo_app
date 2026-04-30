import 'package:flutter/material.dart';
import '../services/backend_service.dart';
import 'introduction_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isSignUp = false;
  bool isLoading = false;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> submit() async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (!BackendService.isConfigured) {
      openIntroduction();
      return;
    }

    if (email.isEmpty || password.isEmpty || (isSignUp && name.isEmpty)) {
      showMessage("Please fill all required details.");
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      if (isSignUp) {
        await BackendService.signUp(
          email: email,
          password: password,
          fullName: name,
        );
      } else {
        await BackendService.signIn(email: email, password: password);
      }

      if (!mounted) return;
      openIntroduction();
    } catch (error) {
      showMessage(error.toString());
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  void openIntroduction() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const IntroductionScreen()),
    );
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFE8F5E9),
              Color(0xFFF1F8E9),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image.asset(
                    "assets/images/app_logo.jpeg",
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "IRIGYAAN Analyzer",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
                if (!BackendService.isConfigured) ...[
                  const SizedBox(height: 12),
                  const Text(
                    "Demo mode: add Supabase keys to enable account login.",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black54),
                  ),
                ],
                const SizedBox(height: 28),
                if (isSignUp)
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: "Student Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                if (isSignUp) const SizedBox(height: 16),
                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : submit,
                    child: isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(isSignUp ? "Create Account" : "Login"),
                  ),
                ),
                TextButton(
                  onPressed: isLoading
                      ? null
                      : () {
                          setState(() {
                            isSignUp = !isSignUp;
                          });
                        },
                  child: Text(
                    isSignUp
                        ? "Already have an account? Login"
                        : "New student? Create account",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
