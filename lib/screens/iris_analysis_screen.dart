import 'package:flutter/material.dart';
import 'dart:typed_data';
import '../widgets/interactive_iris.dart';

class IrisAnalysisScreen extends StatelessWidget {
  final Uint8List leftEye;
  final Uint8List rightEye;

  const IrisAnalysisScreen({
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
          title: const Text("IRIGYAN Analyzer"),
          bottom: const TabBar(
            tabs: [
              Tab(text: "Left Eye"),
              Tab(text: "Right Eye"),
            ],
          ),
        ),

        body: TabBarView(
          children: [
            InteractiveIris(imageBytes: leftEye, isLeft: true),
            InteractiveIris(imageBytes: rightEye, isLeft: false),
          ],
        ),
      ),
    );
  }
}
