import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';

class InteractiveNotes extends StatefulWidget {
  final Uint8List imageBytes;
  final bool isRightEye;

  const InteractiveNotes({
    super.key,
    required this.imageBytes,
    required this.isRightEye,
  });

  @override
  State<InteractiveNotes> createState() => _InteractiveNotesState();
}

class _InteractiveNotesState extends State<InteractiveNotes> {
  _EyeNote? selectedNote;

  static const List<_EyeNote> rightEyeNotes = [
    _EyeNote(
      range: "12-1",
      title: "Cerebrum and motor area",
      points: [
        "5 sense area",
        "Ego",
        "Pressure",
        "Acquired mental speech",
        "Mental ability",
        "Forehead and temple",
      ],
    ),
    _EyeNote(
      range: "1-2",
      title: "Face and jaw area",
      points: [
        "Forehead and temple",
        "Eye",
        "Upper jaw",
        "Nose",
        "Tongue",
        "Mouth",
        "Lower jaw",
      ],
    ),
    _EyeNote(
      range: "2-3",
      title: "Throat area",
      points: [
        "Tonsils",
        "Larynx",
        "Pharynx",
        "Thyroid",
        "Vocal cord",
        "Trachea",
        "Esophagus",
      ],
    ),
    _EyeNote(
      range: "3-4",
      title: "Upper back area",
      points: [
        "Esophagus",
        "Scapula",
        "Upper back",
        "Middle back",
      ],
    ),
    _EyeNote(
      range: "4-5",
      title: "Lower back and bladder",
      points: [
        "Lower back",
        "Bladder",
      ],
    ),
    _EyeNote(
      range: "5-6",
      title: "Pelvic and kidney area",
      points: [
        "Vagina",
        "Uterus",
        "Prostate",
        "Perineum",
        "Pubis",
        "Adrenal",
        "Kidney",
      ],
    ),
    _EyeNote(
      range: "6-7",
      title: "Lower abdomen and leg area",
      points: [
        "Thigh",
        "Knee",
        "Foot",
        "Groin",
        "Peritoneum",
        "Abdominal wall",
        "Pelvis",
        "Testes",
        "Ovary",
      ],
    ),
    _EyeNote(
      range: "7-8",
      title: "Upper abdomen",
      points: [
        "Upper abdomen",
        "Diaphragm",
        "Liver",
        "Gall bladder",
      ],
    ),
    _EyeNote(
      range: "8-9",
      title: "Arm and thorax",
      points: [
        "Hand",
        "Arm",
        "Thorax",
        "Pleura",
      ],
    ),
    _EyeNote(
      range: "9-10",
      title: "Lung area",
      points: [
        "Lungs",
        "Bronchus",
      ],
    ),
    _EyeNote(
      range: "10-11",
      title: "Mastoid and shoulder",
      points: [
        "Mastoid",
        "Ear",
        "Neck",
        "Shoulder",
      ],
    ),
    _EyeNote(
      range: "11-12",
      title: "Medulla and nervous area",
      points: [
        "Medulla",
        "Sensory and locomotion",
        "Inherent mental and sex impulse",
      ],
    ),
  ];

  static const List<_EyeNote> leftEyeNotes = [
    _EyeNote(
      range: "12-1",
      title: "Sensory and mental equilibrium",
      points: [
        "Sensory locomotor",
        "Animation life",
        "Inherent mental equilibrium",
        "Dizziness centre",
        "Medulla",
      ],
    ),
    _EyeNote(
      range: "1-2",
      title: "Mastoid and shoulder",
      points: [
        "Mastoid",
        "Ear",
        "Neck",
        "Shoulder",
      ],
    ),
    _EyeNote(
      range: "2-3",
      title: "Lungs and heart area",
      points: [
        "Lungs",
        "Bronchus",
        "Heart",
        "Pleura",
        "Thorax",
      ],
    ),
    _EyeNote(
      range: "3-4",
      title: "Pleura and ribs",
      points: [
        "Pleura",
        "Thorax",
        "Ribs",
      ],
    ),
    _EyeNote(
      range: "4-5",
      title: "Arm and upper abdomen",
      points: [
        "Arms",
        "Hands",
        "Spleen",
        "Diaphragm",
        "Upper abdomen",
      ],
    ),
    _EyeNote(
      range: "5-6",
      title: "Pelvis and leg area",
      points: [
        "Ovary",
        "Testes",
        "Pelvis",
        "Peritoneum",
        "Abdominal wall",
        "Groin",
        "Thigh",
        "Knee",
        "Foot",
      ],
    ),
    _EyeNote(
      range: "6-7",
      title: "Kidney and pelvic organs",
      points: [
        "Kidney",
        "Adrenal",
        "Scrotum",
        "Perineum",
        "Anus",
        "Rectum",
        "Vagina",
        "Uterus",
        "Prostate",
      ],
    ),
    _EyeNote(
      range: "7-8",
      title: "Bladder and back",
      points: [
        "Bladder",
        "Lower back",
        "Middle back",
      ],
    ),
    _EyeNote(
      range: "8-9",
      title: "Upper back and trachea",
      points: [
        "Upper back",
        "Scapula",
        "Esophagus",
        "Trachea",
      ],
    ),
    _EyeNote(
      range: "9-10",
      title: "Throat area",
      points: [
        "Vocal cords",
        "Thyroid",
        "Pharynx",
        "Larynx",
        "Tonsils",
      ],
    ),
    _EyeNote(
      range: "10-11",
      title: "Jaw and face area",
      points: [
        "Lower jaw",
        "Tongue",
        "Mouth",
        "Nose",
        "Upper jaw",
        "Eyes",
      ],
    ),
    _EyeNote(
      range: "11-12",
      title: "Mental and sense area",
      points: [
        "Temple",
        "Forehead",
        "Mental ability",
        "Acquired mental speech",
        "Ego",
        "Pressure",
        "5 sense area",
      ],
    ),
  ];

  List<_EyeNote> get notes => widget.isRightEye ? rightEyeNotes : leftEyeNotes;

  void detectTap(Offset tap, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final dx = tap.dx - center.dx;
    final dy = tap.dy - center.dy;

    final angle = (atan2(dy, dx) * 180 / pi + 90) % 360;
    final sector = (angle / 30).floor().clamp(0, 11).toInt();

    setState(() {
      selectedNote = notes[sector];
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final chartSize = min(
          constraints.maxWidth * 0.78,
          constraints.maxHeight * 0.48,
        ).clamp(240.0, 330.0).toDouble();

        return Column(
          children: [
            const SizedBox(height: 18),
            Text(
              widget.isRightEye ? "Right Eye Notes" : "Left Eye Notes",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            GestureDetector(
              onTapUp: (details) {
                detectTap(details.localPosition, Size(chartSize, chartSize));
              },
              child: SizedBox(
                width: chartSize,
                height: chartSize,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    ClipOval(
                      child: Image.memory(
                        widget.imageBytes,
                        width: chartSize,
                        height: chartSize,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned.fill(
                      child: CustomPaint(painter: _NotesGridPainter()),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 14),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 180),
                child: selectedNote == null
                    ? _EmptyNoteCard(notes: notes)
                    : _SelectedNoteCard(note: selectedNote!),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _SelectedNoteCard extends StatelessWidget {
  final _EyeNote note;

  const _SelectedNoteCard({required this.note});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      key: ValueKey(note.range),
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFFD7E8D2)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${note.range}  ${note.title}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ...note.points.map(
              (point) => Padding(
                padding: const EdgeInsets.only(bottom: 7),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("- ", style: TextStyle(fontSize: 16)),
                    Expanded(
                      child: Text(
                        point,
                        style: const TextStyle(fontSize: 16, height: 1.25),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyNoteCard extends StatelessWidget {
  final List<_EyeNote> notes;

  const _EmptyNoteCard({required this.notes});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      key: const ValueKey("empty"),
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      itemCount: notes.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final note = notes[index];

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFD7E8D2)),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 48,
                child: Text(
                  note.range,
                  style: const TextStyle(
                    color: Color(0xFF2E7D32),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(child: Text(note.title)),
            ],
          ),
        );
      },
    );
  }
}

class _NotesGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) / 2;

    final paint = Paint()
      ..color = Colors.white.withOpacity(0.75)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.1;

    final borderPaint = Paint()
      ..color = const Color(0xFF2E7D32).withOpacity(0.85)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawCircle(center, radius - 1, borderPaint);

    for (int i = 0; i < 12; i++) {
      final angle = -pi / 2 + i * pi / 6;
      canvas.drawLine(
        center,
        Offset(
          center.dx + radius * cos(angle),
          center.dy + radius * sin(angle),
        ),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _EyeNote {
  final String range;
  final String title;
  final List<String> points;

  const _EyeNote({
    required this.range,
    required this.title,
    required this.points,
  });
}
