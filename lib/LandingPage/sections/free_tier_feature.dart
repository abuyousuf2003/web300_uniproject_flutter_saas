import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FeaturesDiscovery extends StatelessWidget {
  const FeaturesDiscovery({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // --- SECTION 1: FREE TIER CTA ---
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 80),
          child: Row(
            children: [
              // Left: Text Content
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: GoogleFonts.dmSans(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF1A202C),
                        ),
                        children: [
                          const TextSpan(text: "Start generating for "),
                          TextSpan(
                            text: "free",
                            style: GoogleFonts.dmSans(color: Colors.orange),
                          ),
                          const TextSpan(text: " with\nContantlo."),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Write free posts daily without paying us anything. Create\n"
                      "posts from any topic, news, image, or PDF — 100% free. Just\n"
                      "connect your API and start writing unlimited posts\neffortlessly.",
                      style: GoogleFonts.dmSans(
                        fontSize: 16,
                        color: const Color(0xFF4A5568),
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Text("Try Contantlo Today", style: GoogleFonts.dmSans(fontWeight: FontWeight.bold, color: Colors.white)),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 40),
              // Right: Video Placeholder
              Expanded(
                flex: 1,
                child: Container(
                  height: 350,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(color: Colors.orange.withOpacity(0.2), blurRadius: 40, spreadRadius: -10),
                    ],
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // You can replace this Icon with an Image.network from imgBB as a thumbnail
                      const Icon(Icons.play_circle_fill, color: Colors.white, size: 80),
                      Positioned(
                        bottom: 20,
                        child: Text("Product Walkthrough Video", style: GoogleFonts.dmSans(color: Colors.white70)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        // --- SECTION 2: FEATURE GRID ---
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 60),
          child: Column(
            children: [
              Text(
                "Manage Your LinkedIn Brand,\nEffortlessly.",
                textAlign: TextAlign.center,
                style: GoogleFonts.dmSans(fontSize: 36, fontWeight: FontWeight.bold, color: const Color(0xFF1A202C)),
              ),
              const SizedBox(height: 12),
              Text("All Features Built to Help you grow your Brand.", style: GoogleFonts.dmSans(color: const Color(0xFF4A5568))),
              const SizedBox(height: 60),
              
              // 3x2 Grid
              Wrap(
                spacing: 24,
                runSpacing: 24,
                children: [
                  _featureCard(
                    icon: Icons.edit_note,
                    color: Colors.blue,
                    title: "AI Content Writer",
                    desc: "Generate high-quality LinkedIn posts from any source material instantly.",
                    features: ["Topic to Post", "Image to Post", "PDF to Post", "Article to Post", "YT Video to Post"],
                  ),
                  _featureCard(
                    icon: Icons.psychology,
                    color: Colors.pink,
                    title: "AI Post Personalization",
                    desc: "Input your personal details, and our AI will write more authentic, humanized posts.",
                    features: ["Captures your unique voice.", "Authenticity engine.", "Deeper audience connection."],
                  ),
                  _featureCard(
                    icon: Icons.lightbulb_outline,
                    color: Colors.teal,
                    title: "Personalized AI Topic Generator",
                    desc: "Never run out of ideas. Get tailored content suggestions based on your industry.",
                    features: ["Market trend analysis.", "Competitor content inspiration."],
                  ),
                  _featureCard(
                    icon: Icons.calendar_month,
                    color: Colors.orange,
                    title: "LinkedIn Post Scheduling",
                    desc: "Plan your content calendar for consistent and timely delivery globally.",
                    features: ["Schedule Image & Text Posts", "Schedule Video Posts", "Schedule Carousel Posts"],
                  ),
                  _featureCard(
                    icon: Icons.add_comment_outlined,
                    color: Colors.green,
                    title: "Post Follow Up Comment Scheduling",
                    desc: "Automatically post your link or call-to-action in the first comment.",
                    features: ["Boost post visibility instantly.", "Scheduled CTA placement."],
                  ),
                  _featureCard(
                    icon: Icons.bar_chart,
                    color: Colors.yellow.shade700,
                    title: "LinkedIn Posts Analytics",
                    desc: "Deep dive into your performance data to optimize your strategy.",
                    features: ["Understand what's working.", "Identify content that falls flat."],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _featureCard({
    required IconData icon,
    required Color color,
    required String title,
    required String desc,
    required List<String> features,
  }) {
    return Container(
      width: 350,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 20, offset: const Offset(0, 10))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 20),
          Text(title, style: GoogleFonts.dmSans(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 12),
          Text(desc, style: GoogleFonts.dmSans(color: Colors.blueGrey, fontSize: 14, height: 1.5)),
          const SizedBox(height: 20),
          ...features.map((f) => Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  children: [
                    Icon(Icons.check_circle_outline, color: color.withOpacity(0.7), size: 16),
                    const SizedBox(width: 8),
                    Text(f, style: GoogleFonts.dmSans(fontSize: 13, color: Colors.grey[700])),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
