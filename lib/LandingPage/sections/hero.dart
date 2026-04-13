import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web300_socialgo/Authentication/Pages/Login.dart';
import 'package:web300_socialgo/Authentication/Pages/Utilities/wraper.dart';
import 'package:web300_socialgo/webapp/app.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback? onGetStarted;

 
  const HeroSection({super.key, this.onGetStarted});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 1. MAIN HEADING
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: GoogleFonts.dmSans(
                fontSize: 62,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF1A202C),
                height: 1.1,
                letterSpacing: -1.5,
              ),
              children: [
                const TextSpan(text: "The Only Tool to Help You Stay\nConsistent on "),
                TextSpan(
                  text: "LinkedIn",
                  style: GoogleFonts.dmSans(color: Colors.orange),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // 2. SUB-HEADING
          Text(
            "Write personalized LinkedIn posts, Get Unlimited Leads from \n Linkedin that help to close deals",
            textAlign: TextAlign.center,
            style: GoogleFonts.dmSans(
              fontSize: 20,
              color: const Color(0xFF4A5568),
              height: 1.6,
            ),
          ),
          const SizedBox(height: 40),

          // 3. CALL TO ACTION BUTTON
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
              padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 25),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              "Start Closing, It's Free",
              style: GoogleFonts.dmSans(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 40),

          
          _buildSocialProof(),
        ],
      ),
    );
  }

  Widget _buildSocialProof() {

    final List<String> profileImages = [
    'https://i.ibb.co.com/d0NMBGMJ/dewan.jpg',
    'https://i.ibb.co.com/JW1V0PRB/rifat.jpg',
    'https://i.ibb.co.com/CK4nq3ws/rokib.jpg',
    'https://i.ibb.co.com/FLYxK8Ck/unnamed-1.jpg',
  ];
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        
        SizedBox(
          width: 110,
          height: 40,
          child: Stack(
            children: List.generate(profileImages.length, (index) {
              return Positioned(
                left: index * 22.0, // This creates the overlap
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: CircleAvatar(
                    radius: 18,
                    backgroundImage: NetworkImage(
                      profileImages[index],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
        const SizedBox(width: 12),
        // Star Rating & Text
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: List.generate(
                5,
                (index) => const Icon(Icons.star, color: Colors.orange, size: 18),
              ),
            ),
            Text(
              "Loved by 100+",
              style: GoogleFonts.dmSans(
                fontWeight: FontWeight.w600,
                color: const Color(0xFF4A5568),
                fontSize: 14,
              ),
            ),
          ],
        ),
      ],
    );
  }
}