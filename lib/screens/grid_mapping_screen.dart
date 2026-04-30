import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'mapping_screen.dart';

class GridMappingScreen extends StatefulWidget {
  final Uint8List leftEye;
  final Uint8List rightEye;

  const GridMappingScreen({
    super.key,
    required this.leftEye,
    required this.rightEye,
  });

  @override
  State<GridMappingScreen> createState() => _GridMappingScreenState();
}

class _GridMappingScreenState extends State<GridMappingScreen> {
  int selectedGrid = 1;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Grid Mapping"),
          bottom: const TabBar(
            tabs: [
              Tab(text: "Left Eye"),
              Tab(text: "Right Eye"),
            ],
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: const Color(0xFFD7E8D2)),
                ),
                child: Row(
                  children: List.generate(4, (index) {
                    final grid = index + 1;
                    final isSelected = selectedGrid == grid;

                    return Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedGrid = grid;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 180),
                          height: 42,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFF2E7D32)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Text(
                            "$grid",
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black87,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  MappingScreen(
                    isRightEye: false,
                    initialImageBytes: widget.leftEye,
                    allowImagePicker: false,
                    showAppBar: false,
                    gridNumber: selectedGrid,
                  ),
                  MappingScreen(
                    isRightEye: true,
                    initialImageBytes: widget.rightEye,
                    allowImagePicker: false,
                    showAppBar: false,
                    gridNumber: selectedGrid,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
