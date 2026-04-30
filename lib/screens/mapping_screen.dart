import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/iris_painter.dart';
import '../models/organ_mapping.dart';

class MappingScreen extends StatefulWidget {
  final bool isRightEye;
  final Uint8List? initialImageBytes;
  final bool allowImagePicker;
  final bool showAppBar;
  final int gridNumber;

  const MappingScreen({
    super.key,
    required this.isRightEye,
    this.initialImageBytes,
    this.allowImagePicker = true,
    this.showAppBar = true,
    this.gridNumber = 1,
  });

  @override
  State<MappingScreen> createState() => _MappingScreenState();
}

class _MappingScreenState extends State<MappingScreen> {
  Uint8List? selectedImageBytes;
  List<int> highlightedSectors = [];

  final ImagePicker picker = ImagePicker();

  Future<void> pickImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      final bytes = await image.readAsBytes();

      setState(() {
        selectedImageBytes = bytes;
      });
    }
  }

  void detectSector(TapDownDetails details, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final dx = details.localPosition.dx - center.dx;
    final dy = details.localPosition.dy - center.dy;

    double angle = atan2(dy, dx);
    if (angle < 0) angle += 2 * pi;

    int sector = (angle / (2 * pi / 8)).floor();

    String organ = widget.isRightEye
        ? rightEyeMap[sector]!
        : leftEyeMap[sector]!;

    showDefectDialog(sector, organ);
  }

  void showDefectDialog(int sector, String organ) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(organ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildOption("Free of defects", sector),
            buildOption("Closed lacunae", sector),
            buildOption("Toxic rays", sector),
            buildOption("Circular rings", sector),
          ],
        ),
      ),
    );
  }

  Widget buildOption(String title, int sector) {
    return ListTile(
      title: Text(title),
      onTap: () {
        setState(() {
          if (!highlightedSectors.contains(sector)) {
            highlightedSectors.add(sector);
          }
        });
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final imageBytes = selectedImageBytes ?? widget.initialImageBytes;
    final content = Column(
      children: [
        if (widget.allowImagePicker) ...[
          ElevatedButton(
            onPressed: pickImage,
            child: const Text("Select Iris Image"),
          ),
          const SizedBox(height: 10),
        ],
        if (imageBytes != null)
          Expanded(
            child: Center(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final boxSize = min(
                    constraints.maxWidth * 0.9,
                    constraints.maxHeight * 0.9,
                  );

                  return GestureDetector(
                    onTapDown: (details) =>
                        detectSector(details, Size(boxSize, boxSize)),
                    child: Container(
                      width: boxSize,
                      height: boxSize,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.92),
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(color: const Color(0xFFD7E8D2)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 18,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          ClipOval(
                            child: SizedBox(
                              width: boxSize * 0.64,
                              height: boxSize * 0.64,
                              child: Image.memory(
                                imageBytes,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned.fill(
                            child: CustomPaint(
                              painter: IrisPainter(
                                highlightedSectors: highlightedSectors,
                                isRightEye: widget.isRightEye,
                                gridNumber: widget.gridNumber,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          )
        else
          const Padding(
            padding: EdgeInsets.all(20),
            child: Text("No image selected"),
          ),
      ],
    );

    if (!widget.showAppBar) {
      return content;
    }

    return Scaffold(
      appBar: AppBar(title: Text(widget.isRightEye ? "Right Eye" : "Left Eye")),
      body: content,
    );
  }
}
