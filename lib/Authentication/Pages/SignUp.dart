// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class SignUpPage extends StatefulWidget {
//   final VoidCallback? onBack;

//   const SignUpPage({super.key, this.onBack});

//   @override
//   State<SignUpPage> createState() => _SignUpPageState();
// }

// class _SignUpPageState extends State<SignUpPage> {
//   final _firstNameController = TextEditingController();
//   final _lastNameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _confirmPasswordController = TextEditingController();

//   bool _isLoading = false;
//   bool _obscurePassword = true;

//   @override
//   void dispose() {
//     _firstNameController.dispose();
//     _lastNameController.dispose();
//     _emailController.dispose();
//     _passwordController.dispose();
//     _confirmPasswordController.dispose();
//     super.dispose();
//   }

//   Future<void> _handleSignup() async {
//     final firstName = _firstNameController.text.trim();
//     final lastName = _lastNameController.text.trim();
//     final email = _emailController.text.trim();
//     final password = _passwordController.text.trim();
//     final confirmPassword = _confirmPasswordController.text.trim();

//     // 🔴 VALIDATION
//     if (firstName.isEmpty ||
//         lastName.isEmpty ||
//         email.isEmpty ||
//         password.isEmpty ||
//         confirmPassword.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Please fill all fields")),
//       );
//       return;
//     }

//     if (password != confirmPassword) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Passwords do not match")),
//       );
//       return;
//     }

//     setState(() => _isLoading = true);

//     try {
//       // 🔹 CREATE USER (AUTH)
//       UserCredential userCredential =
//           await FirebaseAuth.instance.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );

//       final uid = userCredential.user!.uid;

//       // 🔹 SAVE EXTRA DATA (FIRESTORE)
//       await FirebaseFirestore.instance.collection('users').doc(uid).set({
//         'firstName': firstName,
//         'lastName': lastName,
//         'email': email,
//         'uid': uid,
//         'createdAt': Timestamp.now(),
//         'credits': 8000,
//       });

//       // ❗ NO NAVIGATION → wrapper handles redirect

//     } on FirebaseAuthException catch (e) {
//       String message = "Signup failed";

//       if (e.code == 'email-already-in-use') {
//         message = "Email already registered";
//       } else if (e.code == 'weak-password') {
//         message = "Password should be at least 6 characters";
//       } else if (e.code == 'invalid-email') {
//         message = "Invalid email format";
//       }

//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text(message)),
//       );
//     } finally {
//       if (mounted) setState(() => _isLoading = false);
//     }
//   }

//   InputDecoration _inputDecoration(String hint) {
//     return InputDecoration(
//       hintText: hint,
//       hintStyle: GoogleFonts.dmSans(color: Colors.grey[400]),
//       filled: true,
//       fillColor: Colors.white,
//       contentPadding:
//           const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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

//   Widget _buildLabel(String text) {
//     return Align(
//       alignment: Alignment.centerLeft,
//       child: Text(
//         text,
//         style: GoogleFonts.dmSans(
//           fontSize: 14,
//           fontWeight: FontWeight.bold,
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
//               color: Colors.white,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF8FAFC),

//       appBar: widget.onBack != null
//           ? AppBar(
//               backgroundColor: Colors.transparent,
//               elevation: 0,
//               leading: IconButton(
//                 icon: const Icon(Icons.arrow_back, color: Colors.black),
//                 onPressed: widget.onBack,
//               ),
//             )
//           : null,

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
//               children: [
//                 _buildBranding(),
//                 const SizedBox(height: 32),

//                 Text(
//                   "Create your account",
//                   style: GoogleFonts.dmSans(
//                     fontSize: 22,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),

//                 const SizedBox(height: 32),

//                 // 🔹 FIRST NAME
//                 _buildLabel("First Name"),
//                 const SizedBox(height: 8),
//                 TextField(
//                   controller: _firstNameController,
//                   decoration: _inputDecoration("Enter first name"),
//                 ),

//                 const SizedBox(height: 20),

//                 // 🔹 LAST NAME
//                 _buildLabel("Last Name"),
//                 const SizedBox(height: 8),
//                 TextField(
//                   controller: _lastNameController,
//                   decoration: _inputDecoration("Enter last name"),
//                 ),

//                 const SizedBox(height: 20),

//                 // 🔹 EMAIL
//                 _buildLabel("Email"),
//                 const SizedBox(height: 8),
//                 TextField(
//                   controller: _emailController,
//                   decoration: _inputDecoration("Enter email"),
//                 ),

//                 const SizedBox(height: 20),

//                 // 🔹 PASSWORD
//                 _buildLabel("Password"),
//                 const SizedBox(height: 8),
//                 TextField(
//                   controller: _passwordController,
//                   obscureText: _obscurePassword,
//                   decoration: _inputDecoration("Enter password").copyWith(
//                     suffixIcon: IconButton(
//                       icon: Icon(
//                         _obscurePassword
//                             ? Icons.visibility_off
//                             : Icons.visibility,
//                       ),
//                       onPressed: () {
//                         setState(() {
//                           _obscurePassword = !_obscurePassword;
//                         });
//                       },
//                     ),
//                   ),
//                 ),

//                 const SizedBox(height: 20),

//                 // 🔹 CONFIRM PASSWORD
//                 _buildLabel("Confirm Password"),
//                 const SizedBox(height: 8),
//                 TextField(
//                   controller: _confirmPasswordController,
//                   obscureText: _obscurePassword,
//                   decoration:
//                       _inputDecoration("Confirm password"),
//                 ),

//                 const SizedBox(height: 30),

//                 // 🔹 BUTTON
//                 SizedBox(
//                   width: double.infinity,
//                   height: 48,
//                   child: ElevatedButton(
//                     onPressed: _isLoading ? null : _handleSignup,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.orange,
//                     ),
//                     child: _isLoading
//                         ? const CircularProgressIndicator(
//                             color: Colors.white,
//                           )
//                         : const Text(
//                             "Create Account",
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                   ),
//                 ),

//                 const SizedBox(height: 20),

//                 // 🔹 FOOTER
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text("Already have an account? ",
//                         style: GoogleFonts.dmSans(color: Colors.grey)),
//                     GestureDetector(
//                       onTap: () => Navigator.pop(context),
//                       child: Text(
//                         "Sign in",
//                         style: GoogleFonts.dmSans(
//                           color: Colors.orange,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpPage extends StatefulWidget {
  final VoidCallback? onBack;

  const SignUpPage({super.key, this.onBack});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignup() async {
    final firstName = _firstNameController.text.trim();
    final lastName = _lastNameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (firstName.isEmpty ||
        lastName.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields")),
      );
      return;
    }

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Passwords do not match")),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      // 1. CREATE USER
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final uid = userCredential.user!.uid;

      // 2. SAVE USER DATA
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'uid': uid,
        'createdAt': Timestamp.now(),
        'credits': 8000,
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Account created successfully")),
        );

        // ✅ IMPORTANT FIX:
        // DO NOT navigate here — wrapper handles auth state automatically
      }
    } on FirebaseAuthException catch (e) {
      String message = "Signup failed";

      if (e.code == 'email-already-in-use') {
        message = "Email already registered";
      } else if (e.code == 'weak-password') {
        message = "Password should be at least 6 characters";
      } else if (e.code == 'invalid-email') {
        message = "Invalid email format";
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: GoogleFonts.dmSans(color: Colors.grey[400]),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),
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
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
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
            padding: const EdgeInsets.symmetric(
              horizontal: 40,
              vertical: 50,
            ),
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
              children: [
                _buildBranding(),
                const SizedBox(height: 32),

                Text(
                  "Create your account",
                  style: GoogleFonts.dmSans(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 32),

                _buildLabel("First Name"),
                const SizedBox(height: 8),
                TextField(
                  controller: _firstNameController,
                  decoration: _inputDecoration("Enter first name"),
                ),

                const SizedBox(height: 20),

                _buildLabel("Last Name"),
                const SizedBox(height: 8),
                TextField(
                  controller: _lastNameController,
                  decoration: _inputDecoration("Enter last name"),
                ),

                const SizedBox(height: 20),

                _buildLabel("Email"),
                const SizedBox(height: 8),
                TextField(
                  controller: _emailController,
                  decoration: _inputDecoration("Enter email"),
                ),

                const SizedBox(height: 20),

                _buildLabel("Password"),
                const SizedBox(height: 8),
                TextField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: _inputDecoration("Enter password").copyWith(
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () => setState(
                        () => _obscurePassword = !_obscurePassword,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                _buildLabel("Confirm Password"),
                const SizedBox(height: 8),
                TextField(
                  controller: _confirmPasswordController,
                  obscureText: _obscurePassword,
                  decoration: _inputDecoration("Confirm password"),
                ),

                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _handleSignup,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text(
                            "Create Account",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: GoogleFonts.dmSans(color: Colors.grey),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Text(
                        "Sign in",
                        style: GoogleFonts.dmSans(
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
}