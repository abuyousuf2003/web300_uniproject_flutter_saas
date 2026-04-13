// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:web300_socialgo/Authentication/Pages/Login.dart';
// import 'package:web300_socialgo/Authentication/Pages/Utilities/wraper.dart';
// import 'package:web300_socialgo/webapp/app.dart';

// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class Navbar extends StatelessWidget implements PreferredSizeWidget {
//   final VoidCallback? onGetStarted;

//   const Navbar({super.key, this.onGetStarted});

//   Widget _navLink(String title) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 8.0),
//       child: TextButton(
//         onPressed: () {
          
//         },
//         child: Text(
//           title,
//           style: GoogleFonts.dmSans(
//             fontSize: 16,
//             fontWeight: FontWeight.w500,
//             color: const Color(0xFF4A5568),
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   Size get preferredSize => const Size.fromHeight(80);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//         color: Colors.white,
//         border: Border(
//           bottom: BorderSide(color: Color(0xFFF1F1F1), width: 1),
//         ),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [

//             // LOGO
//             Row(
//               children: const [
//                 Icon(Icons.eco, color: Colors.orange, size: 28),
//                 SizedBox(width: 10),
//                 Text(
//                   "social.go",
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 22,
//                     color: Color(0xFF1A202C),
//                   ),
//                 ),
//               ],
//             ),

//             // LINKS
//             Row(
//               children: [
//                 _navLink("Features"),
//                 _navLink("Pricing"),
//                 _navLink("Proofs"),
//                 _navLink("FAQ"),
//               ],
//             ),

//             // GET STARTED BUTTON
//             ElevatedButton(
//               onPressed: onGetStarted,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.orange,
//                 foregroundColor: Colors.white,
//                 elevation: 0,
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 24,
//                   vertical: 18,
//                 ),
//                 shape: const RoundedRectangleBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(2)),
//                 ),
//               ),
//               child: const Text(
//                 "Get Started",
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 15,
//                 ),
//               ),
//             ),

//           ],
//         ),
//       ),
//     );
//   }
// }




import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:web300_socialgo/webapp/app.dart';


class Navbar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onGetStarted; 

  const Navbar({super.key, this.onGetStarted});

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
  // Reduce vertical padding to something more standard like 10 or 12
  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12), 
  shape: const RoundedRectangleBorder(
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