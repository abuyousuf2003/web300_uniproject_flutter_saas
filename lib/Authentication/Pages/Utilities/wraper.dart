import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:web300_socialgo/Authentication/Pages/Login.dart';
import 'package:web300_socialgo/LandingPage/landingpage.dart';
// import 'package:web300_socialgo/Authentication/Pages/SignUp.dart';

import 'package:web300_socialgo/webapp/app.dart';


class wraper extends StatefulWidget {
  @override
  State<wraper> createState() => _wraperClass();
}

class _wraperClass extends State<wraper> {
  bool showLogin = false; // controls landing → login

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {

          // 🔹 loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

        
          if (snapshot.hasData) {
            return const MainLayout();
          }

         
          if (showLogin) {
            return LoginPage(
              onBack: () => setState(() => showLogin = false),
            );
          }

          return MyHomePage(
            onGetStarted: () => setState(() => showLogin = true),
          );
        },
      ),
    );
  }
}