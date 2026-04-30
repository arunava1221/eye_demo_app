import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../widgets/interactive_notes.dart';

class EyeNotesScreen extends StatelessWidget {
  final Uint8List leftEye;
  final Uint8List rightEye;

  const EyeNotesScreen({
    super.key,
    required this.leftEye,
    required this.rightEye,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Eye Notes"),
          bottom: const TabBar(
            tabs: [
              Tab(text: "Left Eye"),
              Tab(text: "Right Eye"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            InteractiveNotes(imageBytes: leftEye, isRightEye: false),
            InteractiveNotes(imageBytes: rightEye, isRightEye: true),
          ],
        ),
      ),
    );
  }
}
