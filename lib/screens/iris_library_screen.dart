import 'package:flutter/material.dart';

class IrisLibraryScreen extends StatelessWidget {
  const IrisLibraryScreen({super.key});

  static const List<_LibraryItem> items = [
    _LibraryItem(
      title: "Psora Spots",
      images: ["assets/library/docx_psora_spots.jpeg"],
      description:
          "Psora spots appear as large, dark patches in the iris. They are generally considered inherited chemical deposits transmitted from parents. When these spots are surrounded by a thin white line, it suggests irritation in the related tissue. Psora spots should be differentiated from drug spots, which are also chemical in origin but are usually smaller, scattered, and vary in color. Drug spots are most commonly observed in the digestive and glandular zones of the iris. When such chemical influences are passed to the next generation, they may appear as psora spots.",
    ),
    _LibraryItem(
      title: "Lesions, Lacunae, and Crypts",
      images: ["assets/library/docx_lesions_lacunae_crypts.jpeg"],
      description:
          "Lesions, lacunae, and crypts indicate weaknesses within the body that may be either acquired or inherited. These markings vary in size, shape, and intensity of darkness. Lesions can occur in open or closed forms.\n\nAn open lesion is open at one end and suggests that circulation, nutrient exchange, and metabolic processes in that region are functioning at a slower rate. Closed lesions, which are closed at both ends, are referred to as lacunae.\n\nCrypts are small, closed lesions that are usually very dark in appearance. Often, a fine line surrounds the lesion, indicating the formation of scar tissue that strengthens the encapsulation of the affected area.",
    ),
    _LibraryItem(
      title: "Radii Solaris",
      images: ["assets/library/docx_radii_solaris.jpeg"],
      description:
          "Radii solaris are elongated, dark lines that extend outward like the spokes of a wheel. They usually originate from the autonomic nerve wreath. These lines are considered signs of a toxic and sluggish bowel. They are often most prominent in the transverse colon region and may radiate toward the upper areas of the iris.\n\nThese spoke-like lines act as channels through which toxic materials are directed to tissues and organs where the lines terminate. The severity of the toxic condition can be evaluated by observing the depth and darkness of these lines. Their presence indicates the need for detoxification and cleansing of the bowel and body. Radii solaris may also sometimes be observed in cases of parasitic infestation.",
    ),
    _LibraryItem(
      title: "Nerve Rings",
      images: [
        "assets/library/docx_nerve_rings_1.jpeg",
        "assets/library/docx_nerve_rings_2.jpeg",
      ],
      description:
          "Nerve rings, also known as neuromuscular cramp rings, indicate excessive nervous tension. They form due to the buckling of iris fibers. These markings appear as concentric circles or partial arcs created when the fibers become pinched or cramped.\n\nTheir intensity may range from white in acute conditions to darker shades in chronic conditions. This sign suggests that nervous stress in the body is being transferred to the muscular system, leading to anxiety and the accumulation of muscular tension. When nerve rings are present in the stomach area of the iris, there is a strong possibility of nervous indigestion.",
    ),
    _LibraryItem(
      title: "Scurf Rim",
      images: [
        "assets/library/docx_scurf_rim_1.jpeg",
        "assets/library/docx_scurf_rim_2.jpeg",
      ],
      description:
          "The integumentary system, which includes the skin, hair, and nails, is represented at the outermost edge of the iris in zone 7. A darkened band or area observed in this region is known as the scurf rim.\n\nIt may completely surround the iris or appear only in certain portions of the periphery. The band may be thin or may extend deeper toward the interior of the iris. This sign indicates an underactive skin and reduced elimination through the skin.",
    ),
    _LibraryItem(
      title: "Lymphatic Rosary",
      images: [
        "assets/library/docx_lymphatic_rosary_1.jpeg",
        "assets/library/docx_lymphatic_rosary_2.jpeg",
      ],
      description:
          "The lymphatic rosary appears in zone 6 when the lymphatic system becomes overloaded with waste materials, resulting in congestion. In the iris, it is visible as small, cloud-like spots located at varying distances toward the interior, though they are usually found near the periphery.\n\nThese spots resemble a string of pearls or a rosary. White spots indicate acute activity or inflammation, whereas yellowish to light brown spots suggest that the condition has been present for a longer duration.",
    ),
    _LibraryItem(
      title: "Sodium Ring",
      images: ["assets/library/docx_sodium_ring.jpeg"],
      description:
          "The sodium ring appears as a solid white band encircling the iris at the periphery in zone 7. It develops due to deposits formed in the tissues of the cornea, producing an opaque appearance at the border between the cornea and the sclera.\n\nThis sign indicates a chemical imbalance within the body. It is also referred to as a cholesterol ring because it is associated with elevated cholesterol and triglyceride levels. Additionally, it is commonly linked with conditions such as hardening of the arteries and high blood pressure.",
    ),
    _LibraryItem(
      title: "Arcus Senilis",
      images: ["assets/library/docx_arcus_senilis.jpeg"],
      description:
          "Arcus senilis is a sign commonly associated with aging and is typically observed in the upper portion of the iris in zone 7, particularly in the brain and peripheral area. It is considered an indication of cerebral anemia.\n\nThis marking appears as a white arc that often has slightly blurred or fuzzy edges. Its presence can give the iris an almond-shaped or oval appearance.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Iris Content Library")),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          return _LibraryCard(item: items[index], number: index + 1);
        },
      ),
    );
  }
}

class _LibraryCard extends StatelessWidget {
  final _LibraryItem item;
  final int number;

  const _LibraryCard({required this.item, required this.number});

  @override
  Widget build(BuildContext context) {
    return Container(
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
      clipBehavior: Clip.antiAlias,
      child: ExpansionTile(
        tilePadding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
        childrenPadding: const EdgeInsets.fromLTRB(14, 0, 14, 16),
        leading: CircleAvatar(
          backgroundColor: const Color(0xFFE8F5E9),
          foregroundColor: const Color(0xFF2E7D32),
          child: Text("$number"),
        ),
        title: Text(
          item.title,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
        subtitle: const Text("Tap to read theory"),
        children: [
          if (item.images.isNotEmpty) ...[
            for (final image in item.images) ...[
              Container(
                height: 230,
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F8E9),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFFD7E8D2)),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    image,
                    fit: BoxFit.contain,
                    alignment: Alignment.center,
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],
            const SizedBox(height: 2),
          ],
          Text(
            item.description,
            style: TextStyle(
              color: Colors.grey[800],
              fontSize: 15,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}

class _LibraryItem {
  final String title;
  final List<String> images;
  final String description;

  const _LibraryItem({
    required this.title,
    required this.images,
    required this.description,
  });
}
