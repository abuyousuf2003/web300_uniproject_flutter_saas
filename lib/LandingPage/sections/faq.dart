import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FAQSection extends StatelessWidget {
  const FAQSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      child: Column(
        children: [
          // SECTION HEADER
          Text(
            "FAQ's",
            style: GoogleFonts.dmSans(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1A202C),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Top questions about Contantlo",
            style: GoogleFonts.dmSans(
              fontSize: 16,
              color: const Color(0xFF718096),
            ),
          ),
          const SizedBox(height: 50),

          // FAQ LIST
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              children: [
                _buildFaqItem(
                    context,
                    "What is the difference between ChatGPT and Contantlo?"),
                _buildFaqItem(
                    context,
                    "How often should I post on LinkedIn to see results?"),
                _buildFaqItem(
                    context,
                    "What is the best time to post on LinkedIn?"),
                _buildFaqItem(
                    context,
                    "Should I pay for LinkedIn Premium?"),
                _buildFaqItem(
                    context,
                    "How is Contantlo better than a ghostwriter?"),
                _buildFaqItem(
                    context,
                    "How many credits are used per post?"),
                _buildFaqItem(
                    context,
                    "Can I buy more credits after purchasing the lifetime deal?"),
                _buildFaqItem(
                    context,
                    "Why do I see errors after adding my own OpenAI API key?"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFaqItem(BuildContext context, String question) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          shape: const Border(),
          iconColor: Colors.grey,
          collapsedIconColor: Colors.grey,
          title: Text(
            question,
            style: GoogleFonts.dmSans(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF2D3748),
            ),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
              child: Text(
                "Contantlo is specifically fine-tuned for LinkedIn's algorithm and professional tone, unlike general-purpose AI tools.",
                style: GoogleFonts.dmSans(
                  fontSize: 14,
                  color: const Color(0xFF718096),
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}