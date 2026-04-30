import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'iris_analysis_screen.dart';
import 'eye_notes_screen.dart';
import 'iris_library_screen.dart';
import 'grid_mapping_screen.dart';

class ModeSelectionScreen extends StatelessWidget {
  final Uint8List leftEye;
  final Uint8List rightEye;

  const ModeSelectionScreen({
    super.key,
    required this.leftEye,
    required this.rightEye,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("IRIGYAN Modes"), centerTitle: true),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            /// 🌿 ORGAN MAPPING
            _buildCard(
              context,
              title: "Eye Organ Mapping",
              subtitle: "Analyze iris with organ overlay",
              icon: Icons.remove_red_eye,
              color: Colors.green,

              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => IrisAnalysisScreen(
                      leftEye: leftEye,
                      rightEye: rightEye,
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 16),

            /// 📘 NOTES MODE
            _buildCard(
              context,
              title: "Eye Notes",
              subtitle: "Tap iris to learn body parts",
              icon: Icons.menu_book,
              color: Colors.blue,

              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        EyeNotesScreen(leftEye: leftEye, rightEye: rightEye),
                  ),
                );
              },
            ),

            const SizedBox(height: 16),

            /// 🧠 IRIS LIBRARY
            _buildCard(
              context,
              title: "Iris Disease Library",
              subtitle: "Learn iris defects & patterns",
              icon: Icons.science,
              color: Colors.orange,

              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const IrisLibraryScreen()),
                );
              },
            ),

            const SizedBox(height: 16),

            /// 🔲 GRID MODE (COMING SOON)
            _buildCard(
              context,
              title: "Grid Mapping",
              subtitle: "Sector-based iris analysis",
              icon: Icons.grid_on,
              color: Colors.purple,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        GridMappingScreen(leftEye: leftEye, rightEye: rightEye),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  /// 🔥 CARD WIDGET
  Widget _buildCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
    bool enabled = true,
  }) {
    return InkWell(
      onTap: enabled ? onTap : null,

      child: Container(
        padding: const EdgeInsets.all(16),

        decoration: BoxDecoration(
          color: enabled ? color.withOpacity(0.1) : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.5)),
        ),

        child: Row(
          children: [
            /// ICON
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color),
            ),

            const SizedBox(width: 16),

            /// TEXT
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: enabled ? Colors.black : Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(subtitle, style: TextStyle(color: Colors.grey[700])),
                ],
              ),
            ),

            /// ARROW
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: enabled ? Colors.black : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
