import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web300_socialgo/Authentication/Pages/Login.dart';
import 'package:web300_socialgo/Authentication/Pages/Utilities/wraper.dart';
import 'package:web300_socialgo/webapp/app.dart';

class ComparisonSection extends StatelessWidget {
  final VoidCallback? onGetStarted; 

  const ComparisonSection({super.key, this.onGetStarted});
 

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 20),
      child: Column(
        children: [

          // HEADER
          Text(
            "Still manually writing posts\nand searching for leads?",
            textAlign: TextAlign.center,
            style: GoogleFonts.dmSans(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1A202C),
            ),
          ),
          const SizedBox(height: 16),

          Text(
            "SocialGo automates your content creation and lead generation in one workflow.",
            textAlign: TextAlign.center,
            style: GoogleFonts.dmSans(
              fontSize: 18,
              color: const Color(0xFF4A5568),
            ),
          ),

          const SizedBox(height: 60),

          // COMPARISON CARDS
          Wrap(
            spacing: 30,
            runSpacing: 30,
            alignment: WrapAlignment.center,
            children: [

              // BEFORE
              _buildComparisonCard(
                title: "Before SocialGo",
                titleColor: const Color(0xFF1A202C),
                items: [
                  "Struggling to find content ideas every day",
                  "Spending hours writing and editing LinkedIn posts",
                  "Posting inconsistently due to lack of time",
                  "Manually searching for potential leads",
                  "No clear system to scale outreach",
                ],
                isSuccess: false,
              ),

              // AFTER
              _buildComparisonCard(
                title: "With SocialGo",
                titleColor: Colors.orange,
                items: [
                  "Generate post ideas + content instantly using AI",
                  "Turn one topic into a full LinkedIn post in seconds",
                  "Maintain consistent posting without effort",
                  "Find targeted leads based on industry & role",
                  "Get real LinkedIn profiles with verified emails",
                ],
                isSuccess: true,
              ),
            ],
          ),

          const SizedBox(height: 60),

          // CTA
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
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 22),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              "Start Automating Your Workflow →",
              style: GoogleFonts.dmSans(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComparisonCard({
    required String title,
    required Color titleColor,
    required List<String> items,
    required bool isSuccess,
  }) {
    return Container(
      width: 450,
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSuccess
              ? Colors.orange.withOpacity(0.2)
              : Colors.grey.shade200,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.dmSans(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: titleColor,
            ),
          ),
          const SizedBox(height: 25),

          ...items.map((item) => _buildListItem(item, isSuccess)).toList(),
        ],
      ),
    );
  }

  Widget _buildListItem(String text, bool isSuccess) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: isSuccess
              ? const Color(0xFFFFF7F2)
              : const Color(0xFFFFF5F5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(
              isSuccess ? Icons.check_circle : Icons.close,
              color: isSuccess ? Colors.orange : Colors.redAccent,
              size: 18,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                text,
                style: GoogleFonts.dmSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF4A5568),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}