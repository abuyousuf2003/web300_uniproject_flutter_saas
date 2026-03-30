import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web300_socialgo/webapp/Pages/dashboard.dart';
import 'package:web300_socialgo/Authentication/Pages/SignUp.dart';
import 'package:web300_socialgo/Authentication/Pages/Utilities/google_login.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _handleGoogleSignIn() async {
    setState(() => _isLoading = true);
    try {
      final user = await signInWithGoogle();
      if (user != null && mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) =>  DashboardPage()),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Google Login failed: $e")),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _handleEmailLogin() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all fields")),
      );
      return;
    }
    setState(() => _isLoading = true);
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>  DashboardPage()),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? "Login failed"), backgroundColor: Colors.redAccent),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 420, // Slightly narrower for that sharp card look
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 50),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16), // Softer radius
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
                // 1. BRANDING (Matching the black logo box in image 2)
                Container(
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
                ),
                const SizedBox(height: 32),

                // 2. HEADER
                Text(
                  "Sign in to Contant.io",
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

                // 3. GOOGLE BUTTON (Custom built for exact match)
                InkWell(
                  onTap: _isLoading ? null : _handleGoogleSignIn,
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    height: 44,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Reliable Google "G" Logo
                        Image.network(
                          'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_Logo.png/640px-Google_Logo.png',
                          height: 18,
                          // Use local fallback if network fails
                          errorBuilder: (context, error, stackTrace) => const Icon(Icons.g_mobiledata, color: Colors.blue),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          "Continue with Google",
                          style: GoogleFonts.dmSans(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF1A1C1E),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),
                
                // 4. DIVIDER
                Row(children: [
                  Expanded(child: Divider(color: Colors.grey.shade200)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text("or", style: GoogleFonts.dmSans(color: Colors.grey[400], fontSize: 14)),
                  ),
                  Expanded(child: Divider(color: Colors.grey.shade200)),
                ]),
                const SizedBox(height: 24),

                // 5. EMAIL FIELD
                _buildLabel("Email address"),
                const SizedBox(height: 8),
                TextField(
                  controller: _emailController,
                  decoration: _inputDecoration("Enter your email address"),
                ),
                const SizedBox(height: 32),

                // 6. LOGIN BUTTON
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _handleEmailLogin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: _isLoading
                        ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Continue", style: GoogleFonts.dmSans(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16)),
                              const SizedBox(width: 8),
                              const Icon(Icons.play_arrow_rounded, size: 16, color: Colors.white),
                            ],
                          ),
                  ),
                ),
                const SizedBox(height: 40),

                // 7. FOOTER
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account? ", style: GoogleFonts.dmSans(color: Colors.grey[600], fontSize: 14)),
                        GestureDetector(
                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) =>  SignUpPage())),
                          child: Text(
                            "Sign up",
                            style: GoogleFonts.dmSans(color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 14),
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
                        Text("Secured by ", style: GoogleFonts.dmSans(color: Colors.grey[400], fontSize: 12)),
                        const Icon(Icons.verified_user, size: 12, color: Colors.grey),
                        Text(" Clerk", style: GoogleFonts.dmSans(color: Colors.grey[600], fontWeight: FontWeight.bold, fontSize: 12)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
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
          color: const Color(0xFF1A1C1E),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: GoogleFonts.dmSans(color: Colors.grey[400], fontSize: 14),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      filled: true,
      fillColor: Colors.white,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.orange, width: 1.5),
      ),
    );
  }
}