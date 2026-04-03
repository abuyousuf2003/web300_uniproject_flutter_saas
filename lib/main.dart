import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:web300_socialgo/webapp/Pages/postgen.dart';
import 'package:web300_socialgo/webapp/app.dart'; // Ensure this points to your MainLayout
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Social Go',
      theme: ThemeData(
        useMaterial3: true,
        // FIXED SYNTAX BELOW
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0A66C2),
          brightness: Brightness.dark, // Keep it dark to match your sidebar vibe
        ),
        scaffoldBackgroundColor: const Color(0xFF0D0D0D),
      ),
      // home: const MainLayout(), 
   home:   MainLayout(),
    );
  }
}