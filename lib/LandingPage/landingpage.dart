import "package:flutter/material.dart";
import "package:web300_socialgo/LandingPage/sections/before_after.dart";
import "package:web300_socialgo/LandingPage/sections/faq.dart";
import "package:web300_socialgo/LandingPage/sections/feature_overview.dart";
import "package:web300_socialgo/LandingPage/sections/footer.dart";
import "package:web300_socialgo/LandingPage/sections/free_tier_feature.dart";
import "package:web300_socialgo/LandingPage/sections/hero.dart";
import "package:web300_socialgo/LandingPage/sections/navbar.dart";
import "package:web300_socialgo/LandingPage/sections/pricing_sector.dart";

class MyHomePage extends StatefulWidget {
 final VoidCallback? onGetStarted;

  const MyHomePage({super.key, this.onGetStarted});


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ScrollController _scrollController = ScrollController();

  final GlobalKey featuresKey = GlobalKey();
  final GlobalKey pricingKey = GlobalKey();
  final GlobalKey faqKey = GlobalKey();

  void scrollTo(GlobalKey key) {
  final context = key.currentContext;
  if (context != null) {
    Scrollable.ensureVisible(
      context,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0.8, -0.5),
            radius: 1.5,
            colors: [Color(0xFFFFF5EE), Colors.white],
          ),
        ),
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [

              // NAVBAR
             SizedBox(
  width: double.maxFinite,
  height: 60,
  child: Navbar(
    onGetStarted: widget.onGetStarted, 
  ),
),

              HeroSection(onGetStarted: widget.onGetStarted,),

              // FEATURES SECTION
              Container(
                key: featuresKey,
                child: FeatureOverview(onGetStarted: widget.onGetStarted,),
              ),

              ComparisonSection(onGetStarted: widget.onGetStarted,),

              FeaturesDiscovery(),

              // PRICING
              Container(
                key: pricingKey,
                child: PricingSection(),
              ),

              // FAQ
              Container(
                key: faqKey,
                child: FAQSection(),
              ),

              FooterSection(),
            ],
          ),
        ),
      ),
    );
  }
}