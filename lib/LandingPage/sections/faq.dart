


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
          // HEADER
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
            "Top questions about SocialGo",
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

                // -------- CONTENT --------
                _buildFaqItem(
                  context,
                  "How does Contantlo help with content creation?",
                  "SocialGo generates high-performing LinkedIn posts based on your niche, tone, and goals. It removes guesswork and helps you stay consistent without spending hours thinking about what to write.",
                ),

                _buildFaqItem(
                  context,
                  "How often should I post content to grow?",
                  "Posting 3–5 times per week is enough to see growth. The key is consistency and value, not volume. SocialGo helps you maintain that consistency easily.",
                ),

                _buildFaqItem(
                  context,
                  "Will the content feel generic or AI-generated?",
                  "No. The system is designed to match your style and niche, so your posts feel natural and personal instead of robotic or generic.",
                ),

                // -------- LEADS --------
                _buildFaqItem(
                  context,
                  "How does the lead generation feature work?",
                  "You enter your targeting criteria like job title, industry, and location. The system then fetches relevant leads with useful data like email and LinkedIn profiles.",
                ),

                _buildFaqItem(
                  context,
                  "Are the leads accurate and usable?",
                  "Yes, the leads are filtered based on your inputs. While no system is 100% perfect, the results are highly relevant and ready for outreach.",
                ),

                _buildFaqItem(
                  context,
                  "Can I directly use these leads for outreach?",
                  "Absolutely. You can copy emails, open LinkedIn profiles, and start outreach immediately. It’s built to reduce manual research time.",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFaqItem(
      BuildContext context, String question, String answer) {
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
              padding:
                  const EdgeInsets.only(left: 16, right: 16, bottom: 20),
              child: Text(
                answer,
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