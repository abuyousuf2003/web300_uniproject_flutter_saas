import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

// Change return type to Future<User?>
Future<User?> signInWithGoogle() async {
  try {
    // 1. Start the Google Login UI
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) return null; // User canceled

    // 2. Get auth details (Tokens)
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    // 3. Create a credential for Firebase
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // 4. Sign in to Firebase with that credential
    final UserCredential userCredential = 
        await FirebaseAuth.instance.signInWithCredential(credential);
    
    return userCredential.user; // Return the user object
  } catch (e) {
    print("Google Sign-In Error: $e");
    return null;
  }
}