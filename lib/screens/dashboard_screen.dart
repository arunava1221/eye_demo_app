import 'package:flutter/material.dart';
import 'upload_eye_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text("IRIGYAN Dashboard")),

      body: Center(
        child: ElevatedButton(
          child: const Text("Start Iris Analysis"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const UploadEyeScreen(),
              ),
            );
          },
        ),
      ),
    );
  }
}