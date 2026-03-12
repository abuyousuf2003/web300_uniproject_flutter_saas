import 'package:flutter/material.dart';
import 'package:web300_socialgo/LandingPage/landingpage.dart';

void main() {
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



