import 'dart:typed_data';
import 'package:flutter/material.dart';

class InteractiveIris extends StatefulWidget {
  final Uint8List imageBytes;
  final bool isLeft;

  const InteractiveIris({
    super.key,
    required this.imageBytes,
    required this.isLeft,
  });

  @override
  State<InteractiveIris> createState() => _InteractiveIrisState();
}

class _InteractiveIrisState extends State<InteractiveIris> {
  double overlayScale = 1.0;
  Offset overlayOffset = Offset.zero;

  void moveBy(Offset delta) {
    setState(() {
      overlayOffset += delta;
    });
  }

  void resetOverlay() {
    setState(() {
      overlayScale = 1.0;
      overlayOffset = Offset.zero;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: ClipOval(
            child: SizedBox(
              width: 300,
              height: 300,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned.fill(
                    child: Image.memory(widget.imageBytes, fit: BoxFit.cover),
                  ),
                  GestureDetector(
                    onPanUpdate: (details) => moveBy(details.delta),
                    child: Transform.translate(
                      offset: overlayOffset,
                      child: Transform.scale(
                        scale: overlayScale,
                        child: Opacity(
                          opacity: 0.35,
                          child: Image.asset(
                            widget.isLeft
                                ? "assets/images/left_organ_map.jpeg"
                                : "assets/images/right_organ_map.jpeg",
                            width: 300,
                            height: 300,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 18),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              _sliderControl(
                icon: Icons.zoom_in,
                label: "Zoom",
                value: overlayScale,
                min: 0.6,
                max: 2.4,
                onChanged: (value) {
                  setState(() {
                    overlayScale = value;
                  });
                },
              ),
              _sliderControl(
                icon: Icons.swap_horiz,
                label: "Left / Right",
                value: overlayOffset.dx,
                min: -120,
                max: 120,
                onChanged: (value) {
                  setState(() {
                    overlayOffset = Offset(value, overlayOffset.dy);
                  });
                },
              ),
              _sliderControl(
                icon: Icons.swap_vert,
                label: "Up / Down",
                value: overlayOffset.dy,
                min: -120,
                max: 120,
                onChanged: (value) {
                  setState(() {
                    overlayOffset = Offset(overlayOffset.dx, value);
                  });
                },
              ),
              const SizedBox(height: 8),
              OutlinedButton.icon(
                onPressed: resetOverlay,
                icon: const Icon(Icons.refresh),
                label: const Text("Reset"),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _sliderControl({
    required IconData icon,
    required String label,
    required double value,
    required double min,
    required double max,
    required ValueChanged<double> onChanged,
  }) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF2E7D32)),
        const SizedBox(width: 10),
        SizedBox(
          width: 88,
          child: Text(
            label,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
        ),
        Expanded(
          child: Slider(
            value: value.clamp(min, max).toDouble(),
            min: min,
            max: max,
            divisions: 48,
            activeColor: const Color(0xFF2E7D32),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
