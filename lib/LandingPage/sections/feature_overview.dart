import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FeatureOverview extends StatelessWidget {
  const FeatureOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0, // Highlight "PDF to Post"
      child: Padding(
        // This adds the spacing on both sides (80) and top/bottom (60)
        padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 60),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200), // Limits how wide the card can get
            child: Container(
              padding: const EdgeInsets.only(top: 20, bottom: 40),
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
                mainAxisSize: MainAxisSize.min,
                children: [
                  // 1. THE TAB BAR
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE2E8F0),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TabBar(
                        isScrollable: true,
                        dividerColor: Colors.transparent,
                        indicatorSize: TabBarIndicatorSize.tab,
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
                          Tab(text: "Topic to Post"),
                          Tab(text: "Youtube video to Post"),
                          Tab(text: "Query to lead"),
                         
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // 2. THE DASHBOARD IMAGE (Mockup)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          'https://i.ibb.co.com/vxb0JYHk/Gemini-Generated-Image-errs2ierrs2ierrs.png', // YOUR IMGBB LINK
                          fit: BoxFit.contain,
                        ),
                      ),
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
}