import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web300_socialgo/Authentication/Pages/Login.dart';
import 'package:web300_socialgo/Authentication/Pages/Utilities/wraper.dart';
import 'package:web300_socialgo/webapp/app.dart';

class FeatureOverview extends StatelessWidget {
   final VoidCallback? onGetStarted; 

  const FeatureOverview({super.key, this.onGetStarted});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 60),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 40),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.grey.shade200),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 40,
                    offset: const Offset(0, 20),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // -------- TAB BAR --------
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE2E8F0),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TabBar(
                        dividerColor: Colors.transparent,
                        indicator: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        labelColor: Colors.white,
                        unselectedLabelColor: const Color(0xFF4A5568),
                        labelStyle: GoogleFonts.dmSans(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                        tabs: const [
                          Tab(text: "Topic → Post"),
                          Tab(text: "Criteria → Leads"),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                 
                  SizedBox(
                    height: 600, // increased height for better image visibility
                    child: TabBarView(
                      children: [
                        _buildSection(context,
                          title: "AI-Powered LinkedIn Content System",
                          desc:
                              "Enter a topic and audience. AI + n8n instantly generates high-quality LinkedIn posts optimized for engagement.",
                          img:
                              "https://i.ibb.co.com/h1Yx68t5/image.png",
                        ),

                        _buildSection(context,
                          title: "Targeted LinkedIn Lead Engine",
                          desc:
                              "Define your criteria and instantly get real LinkedIn leads with verified emails for outreach.",
                          img:
                              "https://i.ibb.co.com/bgrJH2N3/image.png",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context,{



    required String title,
    required String desc,
    required String img,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Row(
        children: [
          // LEFT TEXT
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.dmSans(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1A202C),
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  desc,
                  style: GoogleFonts.dmSans(
                    fontSize: 15,
                    height: 1.6,
                    color: const Color(0xFF4A5568),
                  ),
                ),
                const SizedBox(height: 28),
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
      if (onGetStarted != null) {
        onGetStarted!(); 
      }
    }
  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    "Try Now",
                    style: GoogleFonts.dmSans(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 60),

          // RIGHT IMAGE (FIXED)
          Expanded(
            child: Container(
              height: 420,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 30,
                    offset: const Offset(0, 15),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  img,
                  fit: BoxFit.contain, // FIX: prevents cropping
                  alignment: Alignment.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}