import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ComparisonSection extends StatelessWidget {
  const ComparisonSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 20),
      child: Column(
        children: [
          // 1. HEADER
          Text(
            "Tired of spending hours writing\nyour next LinkedIn post?",
            textAlign: TextAlign.center,
            style: GoogleFonts.dmSans(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1A202C),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "Contantio brings your ideas to life in just a few clicks.",
            textAlign: TextAlign.center,
            style: GoogleFonts.dmSans(
              fontSize: 18,
              color: const Color(0xFF4A5568),
            ),
          ),
          const SizedBox(height: 60),

          // 2. COMPARISON CARDS
          Wrap(
            spacing: 30,
            runSpacing: 30,
            alignment: WrapAlignment.center,
            children: [
              // Before Card
              _buildComparisonCard(
                title: "Before...",
                titleColor: const Color(0xFF1A202C),
                items: [
                  "I don't have any ideas for content.",
                  "I spend hours writing my posts.",
                  "I don't have any results.",
                  "I can't seem to keep up.",
                  "I can't analyze my content.",
                ],
                isSuccess: false,
              ),
              // After Card
              _buildComparisonCard(
                title: "With Contantio",
                titleColor: Colors.orange,
                items: [
                  "Write Unlimited Posts Using Your API for Free",
                  "Create LinkedIn posts in just a few clicks",
                  "Adapt your posts to your audience and writing style",
                  "Schedule your posts for upcoming weeks",
                  "Analyze your post metrics in one place",
                ],
                isSuccess: true,
              ),
            ],
          ),
          
          const SizedBox(height: 60),

          // 3. CTA BUTTON
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 22),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: Text(
              "Try Contantio →",
              style: GoogleFonts.dmSans(fontWeight: FontWeight.bold, fontSize: 16),
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
        border: Border.all(color: isSuccess ? Colors.orange.withOpacity(0.2) : Colors.grey.shade200),
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
          color: isSuccess ? const Color(0xFFFFF7F2) : const Color(0xFFFFF5F5),
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