

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Navbar extends StatelessWidget implements PreferredSizeWidget {
  const Navbar({super.key});

  Widget _navLink(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          foregroundColor: const Color(0xFF4A5568), // Soft dark grey
        ),
        child: Text(
          title,
          style: GoogleFonts.dmSans(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      
        border: Border(
          bottom: BorderSide(color: Color(0xFFF1F1F1), width: 1),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
           
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.eco, color: Colors.orange, size: 28),
                const SizedBox(width: 10),
                Text(
                  "social.go",
                  style: GoogleFonts.dmSans(
                    fontWeight: FontWeight.bold,
                    fontSize: 22, // Increased for visibility
                    color: const Color(0xFF1A202C),
                    letterSpacing: -0.5,
                  ),
                ),
              ],
            ),

            // --- Nav Links ---
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _navLink("Features"),
                _navLink("Pricing"),
                _navLink("Proofs"),
                _navLink("FAQ"),
              ],
            ),

           
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(2)),
                ),
              ),
              child: Text(
                "Get Started",
                style: GoogleFonts.dmSans(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}