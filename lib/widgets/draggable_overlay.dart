import 'package:flutter/material.dart';

class DraggableOverlay extends StatefulWidget {

  final Widget child;

  const DraggableOverlay({super.key, required this.child});

  @override
  State<DraggableOverlay> createState() => _DraggableOverlayState();
}

class _DraggableOverlayState extends State<DraggableOverlay> {

  double scale = 1.0;
  Offset position = const Offset(0, 0);

  @override
  Widget build(BuildContext context) {

    return Positioned(
      left: position.dx,
      top: position.dy,

      child: GestureDetector(

        /// DRAG
        onPanUpdate: (details) {
          setState(() {
            position += details.delta;
          });
        },

        /// ZOOM
        onScaleUpdate: (details) {
          setState(() {
            scale = details.scale;
          });
        },

        child: Transform.scale(
          scale: scale,
          child: widget.child,
        ),
      ),
    );
  }
}