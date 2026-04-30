import 'package:flutter/material.dart';
import 'upload_eye_screen.dart';

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({super.key});

  @override
  State<IntroductionScreen> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _hasReachedBottom = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_updateScrollProgress);
    WidgetsBinding.instance.addPostFrameCallback((_) => _updateScrollProgress());
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_updateScrollProgress)
      ..dispose();
    super.dispose();
  }

  void _updateScrollProgress() {
    if (!_scrollController.hasClients) return;

    final position = _scrollController.position;
    final reachedBottom = position.maxScrollExtent <= 0 ||
        position.pixels >= position.maxScrollExtent - 24;

    if (reachedBottom != _hasReachedBottom) {
      setState(() {
        _hasReachedBottom = reachedBottom;
      });
    }
  }

  void _continueToUpload() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const UploadEyeScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Introduction")),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFE8F5E9),
              Color(0xFFF1F8E9),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            controller: _scrollController,
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Image.asset(
                      "assets/images/app_logo.jpeg",
                      width: 180,
                      height: 180,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                const Text(
                  "IRIGYAAN",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 18),
                const Text(
                  "Iris assessment is a traditional concept studied in naturopathy, which involves observing the patterns, colors, and structural features of the iris. It is considered an important subject for understanding iris anatomy, zone mapping, and pattern recognition as part of academic learning.",
                  style: TextStyle(fontSize: 16, height: 1.5),
                ),
                const SizedBox(height: 16),
                const Text(
                  "IRIGYAAN is developed as an assistive educational application to support this learning process. By providing structured iris charts, visual references, and interactive tools, the application helps students explore iris zones, understand patterns, and build conceptual clarity in a more systematic and accessible manner.",
                  style: TextStyle(fontSize: 16, height: 1.5),
                ),
                const SizedBox(height: 28),
                const _SectionTitle("About IRIGYAAN"),
                const SizedBox(height: 14),
                _InfoPanel(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/doctor_nature_cure_logo.jpeg",
                        height: 92,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 18),
                      Image.asset(
                        "assets/images/doctor_nature_cure_tagline.jpeg",
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 18),
                      Image.asset(
                        "assets/images/initiative_dr_shashank.jpeg",
                        height: 28,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 18),
                      const Text(
                        "Revolutionizing iris analysis education through innovative technology and expert guidance.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 17,
                          height: 1.4,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1B5E20),
                        ),
                      ),
                      const SizedBox(height: 14),
                      const _BodyText(
                        "IRIGYAAN is an assistive educational application designed to simplify the learning of iris mapping and pattern understanding for students of naturopathy and related fields. The application aims to bridge the gap between theoretical knowledge and practical understanding by providing interactive visual tools, structured iris charts, and a dedicated library of iris features.",
                      ),
                      const SizedBox(height: 12),
                      const _BodyText(
                        "By integrating technology with traditional learning methods, IRIGYAAN enables students to explore iris zones, understand spatial relationships, and develop conceptual clarity in a more engaging and accessible manner.",
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                _InfoPanel(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const _PanelHeading("Our Mission"),
                      const SizedBox(height: 10),
                      const _BodyText(
                        "IRIGYAAN is dedicated to making professional iris analysis accessible to everyone. We combine digital technology with comprehensive learning resources to provide an advanced iridology education platform.",
                      ),
                      const SizedBox(height: 12),
                      const _BodyText(
                        "Our app empowers practitioners, students, and enthusiasts to master the art and science of iris reading through interactive, hands-on learning experiences backed by academic excellence.",
                      ),
                      const SizedBox(height: 20),
                      const _PanelHeading("Our Vision"),
                      const SizedBox(height: 10),
                      const _BodyText(
                        "To become a leading platform for iris analysis education, combining traditional iridology wisdom with modern technological innovations.",
                      ),
                      const SizedBox(height: 12),
                      const _BodyText(
                        "We envision a future where accurate iris analysis is accessible to healthcare professionals worldwide, contributing to holistic health and wellness practices.",
                      ),
                      const SizedBox(height: 20),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: const [
                          _ValueChip(
                            title: "Precision",
                            description:
                                "Advanced tools for accurate iris mapping",
                          ),
                          _ValueChip(
                            title: "Excellence",
                            description:
                                "Backed by academic and expert knowledge",
                          ),
                          _ValueChip(
                            title: "Community",
                            description:
                                "Building skilled iridology practitioners",
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                _InfoPanel(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      _PanelHeading("Meet Our Founders"),
                      SizedBox(height: 6),
                      _BodyText(
                        "The visionary team behind IRIGYAAN.",
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(height: 16),
                      _FounderTile(
                        name: "Dr. Palak Khargonkar",
                        role: "Co-Founder",
                        details: "BNYS, MSc. Yoga\nFNYS, SGT University",
                      ),
                      _FounderTile(
                        name: "Ms. Arti Sharma",
                        role: "Co-Founder",
                        details: "FNYS\nSGT University",
                      ),
                      _FounderTile(
                        name: "Mrs. Prashansa Taneja",
                        role: "Co-Founder",
                        details: "SOET\nSGT University",
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                _InfoPanel(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const _PanelHeading("Academic Excellence"),
                      const SizedBox(height: 14),
                      Image.asset(
                        "assets/images/sgt_academic_excellence.jpeg",
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 16),
                      const _BodyText(
                        "IRIGYAAN is proudly backed by Shree Guru Gobind Singh Tricentenary University, Gurgaon, ensuring our platform maintains the highest standards of educational quality and scientific accuracy.",
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                _InfoPanel(
                  child: Column(
                    children: const [
                      _PanelHeading("Ready to Start Your Journey?"),
                      SizedBox(height: 10),
                      Text(
                        "Unlock the power of professional iris analysis with IRIGYAAN's interactive learning platform.",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 15.5, height: 1.5),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _hasReachedBottom ? _continueToUpload : null,
                    child: Text(
                      _hasReachedBottom
                          ? "Continue"
                          : "Scroll to bottom to continue",
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class _PanelHeading extends StatelessWidget {
  const _PanelHeading(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 19,
        fontWeight: FontWeight.w700,
        color: Color(0xFF101828),
      ),
    );
  }
}

class _BodyText extends StatelessWidget {
  const _BodyText(this.text, {this.textAlign = TextAlign.center});

  final String text;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: const TextStyle(
        fontSize: 15.5,
        height: 1.5,
        color: Color(0xFF344054),
      ),
    );
  }
}

class _ValueChip extends StatelessWidget {
  const _ValueChip({
    required this.title,
    required this.description,
  });

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 148,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFA5D6A7)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1B5E20),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            description,
            style: const TextStyle(
              fontSize: 12.5,
              height: 1.3,
              color: Color(0xFF344054),
            ),
          ),
        ],
      ),
    );
  }
}

class _FounderTile extends StatelessWidget {
  const _FounderTile({
    required this.name,
    required this.role,
    required this.details,
  });

  final String name;
  final String role;
  final String details;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FBF8),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFDDEEDC)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFF101828),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            role,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF2E7D32),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            details,
            style: const TextStyle(
              fontSize: 14,
              height: 1.35,
              color: Color(0xFF475467),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoPanel extends StatelessWidget {
  const _InfoPanel({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.82),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFC8E6C9)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: child,
    );
  }
}
