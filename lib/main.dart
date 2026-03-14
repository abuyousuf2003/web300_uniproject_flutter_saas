import 'package:flutter/material.dart';
import 'package:web300_socialgo/LandingPage/landingpage.dart';
import 'package:firebase_core/firebase_core.dart'; // Fixes 'Firebase'
import 'firebase_options.dart'; // Fixes 'DefaultFirebaseOptions'

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Social Go',
      theme: ThemeData(
        
        colorScheme: .fromSeed(seedColor: const Color(0xFF0A66C2)),
      ),
      home: const MyHomePage(),
    );
  }
}



