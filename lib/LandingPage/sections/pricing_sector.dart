import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web300_socialgo/Authentication/Pages/Utilities/wraper.dart';

class PricingSection extends StatelessWidget {
  const PricingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.black,
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

          Wrap(
            spacing: 20,
            runSpacing: 30,
            alignment: WrapAlignment.center,
            children: [
              _buildPricingCard(
                context: context,
                planName: "Free",
                price: "Free",
                features: [
                  "40k Credits on First Sign Up",
                  "1 Free Post Daily",
                  "Topic To Post",
                ],
              ),
              _buildPricingCard(
                context: context,
                planName: "Starter",
                price: "\$11",
                isPopular: true,
                features: [
                  "250k Ai Credits",
                  "Topic To Post",
                  "LinkedIn Lead gen",
                  "30 personalized posts/month",
                  "50 leads per month",
                ],
              ),
              _buildPricingCard(
                context: context,
                planName: "Pro",
                price: "\$19",
                features: [
                  "1000k Ai Credits",
                  "Topic To Post",
                  "LinkedIn Lead gen",
                  "100 personalized posts/month",
                  "250 leads per month",
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPricingCard({
    required BuildContext context,
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

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  wraper(),
                  ),
                );
              },
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