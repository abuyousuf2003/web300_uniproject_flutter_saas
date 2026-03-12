import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PricingSection extends StatelessWidget {
  const PricingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.black, // Dark background as per reference image
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 20),
      child: Column(
        children: [
          Text(
            "Ready to grow your LinkedIn?",
            style: GoogleFonts.dmSans(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 60),
          
          // 1. WRAP FOR RESPONSIVE PRICING CARDS
          Wrap(
            spacing: 20,
            runSpacing: 30,
            alignment: WrapAlignment.center,
            children: [
              _buildPricingCard(
                planName: "Free",
                price: "Free",
                features: [
                  "40k Credits on First Sign Up",
                  "1 Free Post Daily",
                  "Topic To Post",
                  "Image To Post",
                  "60 Personalized Topics Generate/month",
                  "Save 40 Engagement Lists",
                  "Ai Comment Generator",
                ],
              ),
              _buildPricingCard(
                planName: "Starter",
                price: "\$11",
                isPopular: true, // Optional: highlight the middle card
                features: [
                  "250k Ai Credits",
                  "Topic To Post",
                  "Image To Post",
                  "PDF To Post",
                  "Article To Post",
                  "YouTube Video To Post",
                  "Schedule Post",
                  "30 personalized posts/month",
                  "Unlimited Personalized Topic Generation",
                  "Schedule Follow Up Comment On Posts",
                  "Company Page Post Scheduling",
                  "Save 300 Engagement Lists",
                  "Ai Comment Generator",
                ],
              ),
              _buildPricingCard(
                planName: "Pro",
                price: "\$19",
                features: [
                  "500k Ai Credits",
                  "Topic To Post",
                  "Image To Post",
                  "PDF To Post",
                  "Article To Post",
                  "YouTube Video To Post",
                  "Schedule Post",
                  "Unlimited personalized posts",
                  "Unlimited Personalized Topic Generation",
                  "Schedule Follow Up Comment On Posts",
                  "Company Page Post Scheduling",
                  "Save unlimited Engagement Lists",
                  "Ai Comment Generator",
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPricingCard({
    required String planName,
    required String price,
    required List<String> features,
    bool isPopular = false,
  }) {
    return Container(
      width: 320,
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isPopular ? Colors.orange : Colors.grey.withOpacity(0.3),
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            planName,
            style: GoogleFonts.dmSans(color: Colors.white, fontSize: 16),
          ),
          const SizedBox(height: 10),
          Text(
            price == "Free" ? price : "$price/mo",
            style: GoogleFonts.dmSans(
              color: Colors.orange,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 30),
          // FEATURE LIST
          ...features.map((feature) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.check, color: Colors.orange, size: 16),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        feature,
                        style: GoogleFonts.dmSans(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          const SizedBox(height: 30),
          // CTA BUTTON
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.symmetric(vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                price == "Free" ? "Get Started Free" : "Get Started",
                style: GoogleFonts.dmSans(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}