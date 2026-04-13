import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';
import 'package:firebase_auth/firebase_auth.dart';




import 'package:web300_socialgo/webapp/app.dart';

class FeaturesDiscovery extends StatefulWidget {
  final VoidCallback? onGetStarted; 

  const FeaturesDiscovery({super.key, this.onGetStarted});
 

  @override
  State<FeaturesDiscovery> createState() => _FeaturesDiscoveryState();
}

class _FeaturesDiscoveryState extends State<FeaturesDiscovery> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.asset(
      'assets/videos/demo.mp4',
    )..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildVideo() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: Container(
        color: Colors.black,
        height: 340,
        child: _controller.value.isInitialized
            ? Stack(
                alignment: Alignment.center,
                children: [
                  AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  ),

                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _controller.value.isPlaying
                            ? _controller.pause()
                            : _controller.play();
                      });
                    },
                    child: Icon(
                      _controller.value.isPlaying
                          ? Icons.pause_circle_filled
                          : Icons.play_circle_fill,
                      color: Colors.white,
                      size: 70,
                    ),
                  ),
                ],
              )
            : const Center(
                child: CircularProgressIndicator(color: Colors.orange),
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

       
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 80),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: GoogleFonts.dmSans(
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF1A202C),
                        ),
                        children: [
                          const TextSpan(text: "From Content to "),
                          TextSpan(
                            text: "Clients",
                            style: TextStyle(color: Colors.orange),
                          ),
                          const TextSpan(text: "\nAll in One Workflow"),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "SocialGo helps you generate high-quality LinkedIn content\n"
                      "and directly connect with your ideal audience through\n"
                      "targeted lead generation. No fluff. Just execution.",
                      style: GoogleFonts.dmSans(
                        fontSize: 16,
                        color: const Color(0xFF4A5568),
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // If logged in, go to App
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MainLayout()),
      );
    } else {
      // If NOT logged in, tell the parent (wraper) to show Login
      if (widget.onGetStarted != null) {
        widget.onGetStarted!(); 
      }
    }
  },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 28,
                          vertical: 20,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        "Start Using SocialGo",
                        style: GoogleFonts.dmSans(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 40),

              // -------- REAL VIDEO (INLINE) --------
              Expanded(
                child: _buildVideo(),
              ),
            ],
          ),
        ),

        // -------- FEATURES --------
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
          child: Column(
            children: [
              Text(
                "Built for Execution, Not Complexity",
                textAlign: TextAlign.center,
                style: GoogleFonts.dmSans(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1A202C),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                "Two powerful systems that help you create content and close clients faster.",
                style: GoogleFonts.dmSans(
                  color: const Color(0xFF4A5568),
                ),
              ),
              const SizedBox(height: 60),

              Row(
                children: [

                  // FEATURE 1
                  Expanded(
                    child: _featureCard(
                      icon: Icons.edit_note,
                      color: Colors.orange,
                      title: "AI-Powered LinkedIn Content System",
                      desc:
                          "Turn simple ideas into high-performing LinkedIn posts using AI automation powered by n8n. Built to save time and maintain consistency.",
                      features: [
                        "Input topic + target audience",
                        "AI generates complete ready-to-post content",
                        "Optimized for LinkedIn tone & engagement",
                        "Consistent posting without creative burnout",
                        "Built on automated workflows (n8n backend)",
                      ],
                    ),
                  ),

                  const SizedBox(width: 30),

                  // FEATURE 2
                  Expanded(
                    child: _featureCard(
                      icon: Icons.person_search,
                      color: Colors.green,
                      title: "Targeted LinkedIn Lead Engine",
                      desc:
                          "Find and extract high-quality leads based on your exact targeting criteria. Built for direct outreach and faster conversions.",
                      features: [
                        "Filter by industry, role, and location",
                        "Get real LinkedIn profiles",
                        "Access verified emails for outreach",
                        "Reduce manual prospecting time",
                        "Ready-to-use leads for immediate action",
                      ],
                    ),
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
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 30,
            offset: const Offset(0, 10),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 26),
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: GoogleFonts.dmSans(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            desc,
            style: GoogleFonts.dmSans(
              fontSize: 14,
              color: Colors.blueGrey,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 20),

          ...features.map(
            (f) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.check_circle_outline,
                      color: color, size: 16),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      f,
                      style: GoogleFonts.dmSans(
                        fontSize: 13,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}