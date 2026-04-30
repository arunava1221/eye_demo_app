import 'package:flutter/material.dart';
import 'upload_eye_screen.dart';

class IntroductionScreen extends StatelessWidget {
  const IntroductionScreen({super.key});

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
                const _SectionTitle("About"),
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
                        "Doctor Naturecure is a one-stop destination for learning resources related to naturopathy and yoga. IRIGYAAN supports this educational vision by helping students study iris mapping through structured visuals and interactive practice.",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 15.5, height: 1.5),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                _InfoPanel(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/sgt_academic_excellence.jpeg",
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        "IRIGYAAN is proudly backed by Shree Guru Gobind Singh Tricentenary University, Gurgaon, helping maintain strong educational quality and academic reliability.",
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
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const UploadEyeScreen(),
                        ),
                      );
                    },
                    child: const Text("Continue"),
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
