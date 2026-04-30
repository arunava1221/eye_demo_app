import 'dart:math';
import 'package:flutter/material.dart';

class IrisPainter extends CustomPainter {
  final List<int> highlightedSectors;
  final bool isRightEye;
  final int gridNumber;

  IrisPainter({
    required this.highlightedSectors,
    required this.isRightEye,
    required this.gridNumber,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) * 0.32;
    final data = _GridData.forGrid(gridNumber, isRightEye);

    final linePaint = Paint()
      ..color = const Color(0xFF245B58).withOpacity(0.78)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;

    final boldPaint = Paint()
      ..color = const Color(0xFF1C2F34)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3.8;

    final highlightPaint = Paint()
      ..color = const Color(0xFFF4D35E).withOpacity(0.35)
      ..style = PaintingStyle.fill;

    final circleFillPaint = Paint()
      ..color = Colors.white.withOpacity(0.18)
      ..style = PaintingStyle.fill;

    final sectorAngle = 2 * pi / 8;
    for (final sector in highlightedSectors) {
      final startAngle = sector * sectorAngle;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sectorAngle,
        true,
        highlightPaint,
      );
    }

    canvas.drawCircle(center, radius, circleFillPaint);
    canvas.drawCircle(center, radius, linePaint);
    canvas.drawCircle(center, radius * 0.36, linePaint..strokeWidth = 1.0);
    linePaint.strokeWidth = 1.4;

    for (int i = 0; i < 8; i++) {
      final angle = -pi / 2 + i * pi / 4;
      canvas.drawLine(center, _point(center, radius, angle), linePaint);
    }

    canvas.drawLine(
      _point(center, radius * 0.98, data.boldLineStart),
      _point(center, radius * 0.98, data.boldLineEnd),
      boldPaint,
    );

    canvas.drawCircle(
      center,
      4.5,
      Paint()
        ..color = const Color(0xFF1C2F34)
        ..style = PaintingStyle.fill,
    );

    _drawEyeTitle(canvas, size, isRightEye ? "Right" : "Left");
    _drawGridBadge(canvas, size);

    for (final label in data.labels) {
      _drawLabel(
        canvas,
        label.text,
        _point(center, radius * label.distance, label.angle),
        label.align,
      );
    }
  }

  Offset _point(Offset center, double distance, double angle) {
    return Offset(
      center.dx + distance * cos(angle),
      center.dy + distance * sin(angle),
    );
  }

  void _drawEyeTitle(Canvas canvas, Size size, String title) {
    final painter = TextPainter(
      text: TextSpan(
        text: title,
        style: const TextStyle(
          color: Color(0xFF1C2F34),
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    final offset = Offset((size.width - painter.width) / 2, 10);
    final rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        offset.dx - 12,
        offset.dy - 5,
        painter.width + 24,
        painter.height + 10,
      ),
      const Radius.circular(14),
    );

    canvas.drawRRect(
      rect,
      Paint()
        ..color = const Color(0xFFE8F5E9)
        ..style = PaintingStyle.fill,
    );
    painter.paint(canvas, offset);
  }

  void _drawGridBadge(Canvas canvas, Size size) {
    final painter = TextPainter(
      text: TextSpan(
        text: "Grid $gridNumber",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    final rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        size.width - painter.width - 32,
        size.height - 36,
        painter.width + 20,
        26,
      ),
      const Radius.circular(13),
    );

    canvas.drawRRect(
      rect,
      Paint()
        ..color = const Color(0xFF2E7D32)
        ..style = PaintingStyle.fill,
    );
    painter.paint(canvas, Offset(rect.left + 10, rect.top + 5));
  }

  void _drawLabel(Canvas canvas, String text, Offset point, TextAlign align) {
    final painter = TextPainter(
      text: TextSpan(
        text: text,
        style: const TextStyle(
          color: Color(0xFF1C2F34),
          fontSize: 12.5,
          fontWeight: FontWeight.w600,
        ),
      ),
      textAlign: align,
      textDirection: TextDirection.ltr,
      maxLines: 2,
    )..layout(maxWidth: 86);

    double dx = point.dx - painter.width / 2;
    if (align == TextAlign.left) dx = point.dx;
    if (align == TextAlign.right) dx = point.dx - painter.width;

    final offset = Offset(dx, point.dy - painter.height / 2);
    final rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        offset.dx - 5,
        offset.dy - 3,
        painter.width + 10,
        painter.height + 6,
      ),
      const Radius.circular(8),
    );

    canvas.drawRRect(
      rect,
      Paint()
        ..color = Colors.white.withOpacity(0.82)
        ..style = PaintingStyle.fill,
    );
    painter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant IrisPainter oldDelegate) {
    return oldDelegate.highlightedSectors != highlightedSectors ||
        oldDelegate.isRightEye != isRightEye ||
        oldDelegate.gridNumber != gridNumber;
  }
}

class _GridData {
  final double boldLineStart;
  final double boldLineEnd;
  final List<_GridLabel> labels;

  const _GridData({
    required this.boldLineStart,
    required this.boldLineEnd,
    required this.labels,
  });

  factory _GridData.forGrid(int gridNumber, bool isRightEye) {
    final base = _baseLabels(isRightEye);

    switch (gridNumber) {
      case 2:
        return _GridData(
          boldLineStart: isRightEye ? _deg(252) : _deg(288),
          boldLineEnd: isRightEye ? _deg(252 - 180) : _deg(288 - 180),
          labels: [
            ...base,
            _GridLabel("cerebellum", isRightEye ? _deg(252) : _deg(288), 1.25),
            _GridLabel("uterus", _deg(72), 1.24),
            _GridLabel("rectum", _deg(108), 1.24),
          ],
        );
      case 3:
        return _GridData(
          boldLineStart: isRightEye ? _deg(240) : _deg(300),
          boldLineEnd: isRightEye ? _deg(60) : _deg(120),
          labels: [
            ...base,
            _GridLabel("forehead", isRightEye ? _deg(300) : _deg(240), 1.24),
            _GridLabel("ovary", isRightEye ? _deg(120) : _deg(60), 1.26),
          ],
        );
      case 4:
        return _GridData(
          boldLineStart: isRightEye ? _deg(200) : _deg(340),
          boldLineEnd: isRightEye ? _deg(20) : _deg(160),
          labels: [
            ...base,
            _GridLabel("Axilla", isRightEye ? _deg(205) : _deg(335), 1.25),
            _GridLabel("Loin", isRightEye ? _deg(20) : _deg(160), 1.25),
          ],
        );
      case 1:
      default:
        return _GridData(
          boldLineStart: isRightEye ? _deg(160) : _deg(200),
          boldLineEnd: isRightEye ? _deg(340) : _deg(20),
          labels: [
            ...base,
            _GridLabel("Mouth", isRightEye ? _deg(340) : _deg(200), 1.28),
            _GridLabel("Hand", isRightEye ? _deg(160) : _deg(20), 1.28),
          ],
        );
    }
  }

  static List<_GridLabel> _baseLabels(bool isRightEye) {
    return [
      _GridLabel("vertex", _deg(270), 1.18),
      _GridLabel("foot", _deg(90), 1.2),
      _GridLabel("Nose", isRightEye ? _deg(315) : _deg(225), 1.2),
      _GridLabel("ear", isRightEye ? _deg(225) : _deg(315), 1.22),
      _GridLabel("Neck", isRightEye ? _deg(180) : _deg(0), 1.18),
      _GridLabel("Throat", isRightEye ? _deg(0) : _deg(180), 1.18),
      _GridLabel("Bladder", isRightEye ? _deg(45) : _deg(135), 1.24),
      _GridLabel(isRightEye ? "Diaphragm" : "spleen", isRightEye ? _deg(135) : _deg(45), 1.28),
    ];
  }
}

class _GridLabel {
  final String text;
  final double angle;
  final double distance;

  const _GridLabel(this.text, this.angle, this.distance);

  TextAlign get align {
    final x = cos(angle);
    if (x > 0.35) return TextAlign.left;
    if (x < -0.35) return TextAlign.right;
    return TextAlign.center;
  }
}

double _deg(double degrees) => degrees * pi / 180;
