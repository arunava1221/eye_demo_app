import 'mode_selection_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import 'dart:typed_data';
import '../services/backend_service.dart';

class UploadEyeScreen extends StatefulWidget {
  const UploadEyeScreen({super.key});

  @override
  State<UploadEyeScreen> createState() => _UploadEyeScreenState();
}

class _UploadEyeScreenState extends State<UploadEyeScreen> {

  Uint8List? leftEye;
  Uint8List? rightEye;
  bool isSaving = false;
  static final List<String> sampleImages = List.generate(
    29,
    (index) => "assets/samples/sample_eye_${(index + 1).toString().padLeft(2, '0')}.jpeg",
  );

  Future pickImage(bool isLeft) async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked == null) return;

    final bytes = await picked.readAsBytes();

    setState(() {
      if (isLeft) leftEye = bytes;
      else rightEye = bytes;
    });
  }

  Future<void> pickSample(bool isLeft) async {
    final selectedAsset = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Choose ${isLeft ? 'Left' : 'Right'} Eye Sample",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 14),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.58,
                  child: GridView.builder(
                    itemCount: sampleImages.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) {
                      final asset = sampleImages[index];

                      return InkWell(
                        onTap: () => Navigator.pop(context, asset),
                        borderRadius: BorderRadius.circular(14),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.asset(asset, fit: BoxFit.cover),
                              Positioned(
                                top: 6,
                                left: 6,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.55),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    "${index + 1}",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
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
              ],
            ),
          ),
        );
      },
    );

    if (selectedAsset == null) return;

    final data = await rootBundle.load(selectedAsset);
    setState(() {
      if (isLeft) {
        leftEye = Uint8List.sublistView(data);
      } else {
        rightEye = Uint8List.sublistView(data);
      }
    });
  }

  Widget buildCard(String title, Uint8List? image, bool isLeft) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),

      child: Column(
        children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold)),

          const SizedBox(height: 10),

          image != null
              ? Container(
                  height: 130,
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F8E9),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: const Color(0xFFD7E8D2)),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.memory(image, fit: BoxFit.contain),
                  ),
                )
              : const Text("No Image"),

          const SizedBox(height: 10),

          Wrap(
            alignment: WrapAlignment.center,
            spacing: 10,
            runSpacing: 8,
            children: [
              ElevatedButton.icon(
                onPressed: () => pickImage(isLeft),
                icon: const Icon(Icons.upload),
                label: const Text("Upload"),
              ),
              const SizedBox(width: 10),
              OutlinedButton.icon(
                onPressed: () => pickSample(isLeft),
                icon: const Icon(Icons.collections),
                label: const Text("Use Sample"),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text("Upload Eyes")),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            buildCard("Left Eye", leftEye, true),
            buildCard("Right Eye", rightEye, false),

            const SizedBox(height: 20),

            if (leftEye != null && rightEye != null)
              ElevatedButton(
                onPressed: isSaving ? null : () async {
                  setState(() {
                    isSaving = true;
                  });

                  try {
                    await BackendService.saveIrisSession(
                      leftEye: leftEye!,
                      rightEye: rightEye!,
                    );
                  } catch (error) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Could not save session: $error"),
                        ),
                      );
                    }
                  } finally {
                    if (mounted) {
                      setState(() {
                        isSaving = false;
                      });
                    }
                  }

                  if (!context.mounted) return;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ModeSelectionScreen(
                        leftEye: leftEye!,
                        rightEye: rightEye!,
                      ),
                    ),
                  );
                },
                child: Text(isSaving ? "Saving..." : "Analyze Iris"),
              )

          ],
        ),
      ),
    );
  }
}
