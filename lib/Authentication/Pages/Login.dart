// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// import 'package:web300_socialgo/Authentication/Pages/SignUp.dart';
// import 'package:web300_socialgo/Authentication/Pages/Utilities/google_login.dart';
// import 'package:web300_socialgo/webapp/app.dart';

// class LoginPage extends StatefulWidget {
//   final VoidCallback? onBack;

//   const LoginPage({super.key, this.onBack});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }
// class _LoginPageState extends State<LoginPage> {
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   bool _isLoading = false;
//   bool _obscurePassword = true; 

//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   Future<void> _handleGoogleSignIn() async {
//     // Note: Ensure your google_login.dart contains the actual Google Sign-In logic
//     setState(() => _isLoading = true);
//     try {
//       // Placeholder for your utility call
//       // await AuthService().signInWithGoogle(); 
//     } catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("Google Login failed: $e")),
//         );
//       }
//     } finally {
//       if (mounted) setState(() => _isLoading = false);
//     }
//   }


// Future<void> _handleEmailLogin() async {
//   final email = _emailController.text.trim();
//   final password = _passwordController.text.trim();

//   if (email.isEmpty || password.isEmpty) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text("Please fill in all fields")),
//     );
//     return;
//   }

//   setState(() => _isLoading = true);

//   try {
//     await FirebaseAuth.instance.signInWithEmailAndPassword(
//       email: email,
//       password: password,
//     );

 

//   } on FirebaseAuthException catch (e) {
//   print("ERROR CODE: ${e.code}");
//   print("ERROR MESSAGE: ${e.message}");

//   ScaffoldMessenger.of(context).showSnackBar(
//     SnackBar(content: Text(e.code)),
//   );
// }}









//   // Future<void> _handleEmailLogin() async {
//   //   final email = _emailController.text.trim();
//   //   final password = _passwordController.text.trim();

//   //   if (email.isEmpty || password.isEmpty) {
//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       const SnackBar(content: Text("Please fill in all fields")),
//   //     );
//   //     return;
//   //   }

//   //   setState(() => _isLoading = true);
//   //   try {
//   //     await FirebaseAuth.instance.signInWithEmailAndPassword(
//   //       email: email,
//   //       password: password,
//   //     );
      
//   //     if (!mounted) return;
      
//   //     Navigator.pushReplacement(
//   //       context,
//   //       MaterialPageRoute(builder: (context) => DashboardPage()),
//   //     );
//   //   } on FirebaseAuthException catch (e) {
//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       SnackBar(
//   //         content: Text(e.message ?? "Login failed"), 
//   //         backgroundColor: Colors.redAccent
//   //       ),
//   //     );
//   //   } finally {
//   //     if (mounted) setState(() => _isLoading = false);
//   //   }
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF8FAFC),
//       body: Center(
//         child: SingleChildScrollView(
//           child: Container(
//             width: 420,
//             padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 50),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(16),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.04),
//                   blurRadius: 24,
//                   offset: const Offset(0, 8),
//                 ),
//               ],
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 // 1. BRANDING
//                 _buildBranding(),
//                 const SizedBox(height: 32),

//                 // 2. HEADER
//                 Text(
//                   "Sign in to Contant.io",
//                   style: GoogleFonts.dmSans(
//                     fontSize: 22,
//                     fontWeight: FontWeight.w700,
//                     color: const Color(0xFF1A1C1E),
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   "Welcome back! Please sign in to continue",
//                   textAlign: TextAlign.center,
//                   style: GoogleFonts.dmSans(
//                     color: Colors.grey[600],
//                     fontSize: 15,
//                   ),
//                 ),
//                 const SizedBox(height: 32),

//                 // 3. GOOGLE BUTTON
//                 _buildGoogleButton(),

//                 const SizedBox(height: 24),
                
//                 // 4. DIVIDER
//                 _buildDivider(),
//                 const SizedBox(height: 24),

//                 // 5. EMAIL FIELD
//                 _buildLabel("Email address"),
//                 const SizedBox(height: 8),
//                 TextField(
//                   controller: _emailController,
//                   keyboardType: TextInputType.emailAddress,
//                   decoration: _inputDecoration("Enter your email address"),
//                 ),
//                 const SizedBox(height: 24),

//                 // 6. PASSWORD FIELD
//                 _buildLabel("Password"),
//                 const SizedBox(height: 8),
//                 TextField(
//                   controller: _passwordController,
//                   obscureText: _obscurePassword,
//                   decoration: _inputDecoration("Enter your password").copyWith(
//                     suffixIcon: IconButton(
//                       icon: Icon(
//                         _obscurePassword ? Icons.visibility_off : Icons.visibility,
//                         color: Colors.grey,
//                         size: 20,
//                       ),
//                       onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 32),

//                 // 7. LOGIN BUTTON
//                 _buildLoginButton(),

//                 const SizedBox(height: 40),

//                 // 8. FOOTER
//                 _buildFooter(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }



//   Widget _buildBranding() {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//       decoration: BoxDecoration(
//         color: Colors.black,
//         borderRadius: BorderRadius.circular(4),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           const Icon(Icons.eco, color: Colors.orange, size: 18),
//           const SizedBox(width: 6),
//           Text(
//             "contant.io",
//             style: GoogleFonts.dmSans(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildGoogleButton() {
//     return InkWell(
//       onTap: _isLoading ? null : _handleGoogleSignIn,
//       borderRadius: BorderRadius.circular(8),
//       child: Container(
//         height: 44,
//         width: double.infinity,
//         decoration: BoxDecoration(
//           border: Border.all(color: Colors.grey.shade300),
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.network(
//               'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_Logo.png/640px-Google_Logo.png',
//               height: 18,
//               errorBuilder: (context, error, stackTrace) => const Icon(Icons.g_mobiledata, color: Colors.blue),
//             ),
//             const SizedBox(width: 12),
//             Text(
//               "Continue with Google",
//               style: GoogleFonts.dmSans(
//                 fontSize: 15,
//                 fontWeight: FontWeight.w500,
//                 color: const Color(0xFF1A1C1E),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildDivider() {
//     return Row(children: [
//       Expanded(child: Divider(color: Colors.grey.shade200)),
//       Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         child: Text("or", style: GoogleFonts.dmSans(color: Colors.grey[400], fontSize: 14)),
//       ),
//       Expanded(child: Divider(color: Colors.grey.shade200)),
//     ]);
//   }

//   Widget _buildLoginButton() {
//     return SizedBox(
//       width: double.infinity,
//       height: 48,
//       child: ElevatedButton(
//         onPressed: _isLoading ? null : _handleEmailLogin,
                

//         style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.orange,
//           elevation: 0,
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//         ),
//         child: _isLoading
//             ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
//             : Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text("Continue", style: GoogleFonts.dmSans(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16)),
//                   const SizedBox(width: 8),
//                   const Icon(Icons.play_arrow_rounded, size: 16, color: Colors.white),
//                 ],
//               ),
//       ),
//     );
//   }

//   Widget _buildFooter() {
//     return Column(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text("Don't have an account? ", style: GoogleFonts.dmSans(color: Colors.grey[600], fontSize: 14)),
//             GestureDetector(
//               onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) =>  SignUpPage())),
//               child: Text(
//                 "Sign up",
//                 style: GoogleFonts.dmSans(color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 14),
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 24),
//         Divider(color: Colors.grey.shade100),
//         const SizedBox(height: 12),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text("Secured by ", style: GoogleFonts.dmSans(color: Colors.grey[400], fontSize: 12)),
//             const Icon(Icons.verified_user, size: 12, color: Colors.grey),
//             Text(" Firebase", style: GoogleFonts.dmSans(color: Colors.grey[600], fontWeight: FontWeight.bold, fontSize: 12)),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildLabel(String text) {
//     return Align(
//       alignment: Alignment.centerLeft,
//       child: Text(
//         text,
//         style: GoogleFonts.dmSans(
//           fontSize: 14,
//           fontWeight: FontWeight.bold,
//           color: const Color(0xFF1A1C1E),
//         ),
//       ),
//     );
//   }

//   InputDecoration _inputDecoration(String hint) {
//     return InputDecoration(
//       hintText: hint,
//       hintStyle: GoogleFonts.dmSans(color: Colors.grey[400], fontSize: 14),
//       contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//       filled: true,
//       fillColor: Colors.white,
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(8),
//         borderSide: BorderSide(color: Colors.grey.shade300),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(8),
//         borderSide: const BorderSide(color: Colors.orange, width: 1.5),
//       ),
//     );
//   }
// }





import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:web300_socialgo/Authentication/Pages/SignUp.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback? onBack;

  const LoginPage({super.key, this.onBack});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // EMAIL LOGIN
  Future<void> _handleEmailLogin() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all fields")),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.code)),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _goToSignUp() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SignUpPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),

      appBar: widget.onBack != null
          ? AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: widget.onBack,
              ),
            )
          : null,

      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 420,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 50),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildBranding(),
                const SizedBox(height: 32),

                Text(
                  "Sign in to contant.io",
                  style: GoogleFonts.dmSans(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1A1C1E),
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  "Welcome back! Please sign in to continue",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.dmSans(
                    color: Colors.grey[600],
                    fontSize: 15,
                  ),
                ),

                const SizedBox(height: 32),

                _buildGoogleButton(),
                const SizedBox(height: 24),
                _buildDivider(),
                const SizedBox(height: 24),

                _buildLabel("Email address"),
                const SizedBox(height: 8),
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: _inputDecoration("Enter your email address"),
                ),

                const SizedBox(height: 24),

                _buildLabel("Password"),
                const SizedBox(height: 8),
                TextField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: _inputDecoration("Enter your password").copyWith(
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        size: 20,
                        color: Colors.grey,
                      ),
                      onPressed: () => setState(
                        () => _obscurePassword = !_obscurePassword,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                _buildLoginButton(),
                const SizedBox(height: 40),

                _buildFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // UI COMPONENTS (same as your original)

  Widget _buildBranding() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.eco, color: Colors.orange, size: 18),
          const SizedBox(width: 6),
          Text(
            "contant.io",
            style: GoogleFonts.dmSans(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGoogleButton() {
    return Container(
      height: 44,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.g_mobiledata, color: Colors.blue),
          const SizedBox(width: 10),
          Text(
            "Continue with Google",
            style: GoogleFonts.dmSans(
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(child: Divider(color: Colors.grey.shade200)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text("or",
              style: GoogleFonts.dmSans(color: Colors.grey[400])),
        ),
        Expanded(child: Divider(color: Colors.grey.shade200)),
      ],
    );
  }

  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _handleEmailLogin,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: _isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text("Continue"),
                  SizedBox(width: 8),
                  Icon(Icons.play_arrow_rounded, size: 16),
                ],
              ),
      ),
    );
  }

  Widget _buildFooter() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Don't have an account? ",
                style: GoogleFonts.dmSans(color: Colors.grey[600])),
            GestureDetector(
              onTap: _goToSignUp,
              child: Text(
                "Sign up",
                style: GoogleFonts.dmSans(
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Divider(color: Colors.grey.shade100),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Secured by ",
                style: GoogleFonts.dmSans(
                    color: Colors.grey[400], fontSize: 12)),
            const Icon(Icons.verified_user, size: 12),
            Text(" Firebase",
                style: GoogleFonts.dmSans(
                    fontWeight: FontWeight.bold, fontSize: 12)),
          ],
        ),
      ],
    );
  }

  Widget _buildLabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: GoogleFonts.dmSans(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}