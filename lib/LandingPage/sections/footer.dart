import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.black, // Matches the dark theme in the design
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 80),
      child: Column(
        children: [
          // 1. TOP CONTENT: LOGO & TAGLINE
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1100),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Logo and Brand Name
                    Row(
                      children: [
                        const Icon(Icons.eco, color: Colors.orange, size: 28),
                        const SizedBox(width: 8),
                        Text(
                          "SocialGo",
                          style: GoogleFonts.dmSans(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    // Tagline
                    Text(
                      "Create engaging content in minutes with AI. Join thousands of creators who\ntrust SocialGo to amplify their professional voice.",
                      style: GoogleFonts.dmSans(
                        color: Colors.grey.shade500,
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 50),
          
          // 2. DIVIDER LINE
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1100),
            child: Divider(color: Colors.grey.shade800, thickness: 1),
          ),

          const SizedBox(height: 30),

          // 3. BOTTOM RAIL: COPYRIGHT & LINKS
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1100),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "© 2026 SociaGo. All rights reserved.",
                  style: GoogleFonts.dmSans(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
                Row(
                  children: [
                    _footerLink("Blog"),
                    const SizedBox(width: 25),
                    _footerLink("Privacy"),
                    const SizedBox(width: 25),
                    _footerLink("Terms"),
                    const SizedBox(width: 40),
                    // LinkedIn Icon
                    Icon(Icons.terminal_sharp, color: Colors.grey.shade600, size: 20), // Placeholder for LinkedIn icon
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _footerLink(String title) {
    return InkWell(
      onTap: () {},
      child: Text(
        title,
        style: GoogleFonts.dmSans(
          color: Colors.grey.shade400,
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}