import "package:flutter/material.dart";
import "package:web300_socialgo/LandingPage/sections/before_after.dart";
import "package:web300_socialgo/LandingPage/sections/feature_overview.dart";
import "package:web300_socialgo/LandingPage/sections/free_tier_feature.dart";
import "package:web300_socialgo/LandingPage/sections/hero.dart";
import "package:web300_socialgo/LandingPage/sections/navbar.dart";
import "package:web300_socialgo/LandingPage/sections/pricing_sector.dart";

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});




  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


 

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      
      body: Container(

        decoration: BoxDecoration(
  gradient: RadialGradient(
    center: Alignment(0.8, -0.5), // Position the "glow"
    radius: 1.5,
    colors: [Color(0xFFFFF5EE), Colors.white],
  ),
),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
// Navbar
SizedBox(
  width: double.maxFinite,
  height: 60,
  child: Navbar()),

  HeroSection(),
  FeatureOverview(),
  ComparisonSection(),
 FeaturesDiscovery(),
PricingSection()





            ],
          ),
        ),
      )
    
    );
  }
}
