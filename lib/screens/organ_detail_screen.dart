import 'package:flutter/material.dart';

class OrganDetailScreen extends StatelessWidget {
  final String organ;
  final String description;

  const OrganDetailScreen({
    super.key,
    required this.organ,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(organ),
        backgroundColor: Colors.green.shade700,
      ),

      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),

        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.green.shade50,
              Colors.green.shade100,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// 🌿 Title
            Text(
              organ,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            /// 🌿 Description
            Text(
              description,
              style: const TextStyle(
                fontSize: 18,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 30),

            /// 🌿 Extra Section (future ready)
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    color: Colors.black12,
                  )
                ],
              ),
              child: const Text(
                "More analysis coming soon...",
                style: TextStyle(fontSize: 16),
              ),
            ),

          ],
        ),
      ),
    );
  }
}