import 'package:flutter/material.dart';
import 'package:web300_socialgo/webapp/Pages/lead.dart';
import 'package:web300_socialgo/webapp/Pages/postgen.dart';
import 'package:web300_socialgo/webapp/Pages/settings.dart';

import 'Pages/sidebar.dart';



class MainLayout extends StatefulWidget {
  const MainLayout({super.key});
  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const PostGenScreen(),
    const LinkedInLeadGenScreen() ,
    const LinkedInAccountScreen(),
    const SubscriptionScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          AppSidebar(
            selectedIndex: _currentIndex,
            onItemSelected: (index) => setState(() => _currentIndex = index),
          ),
          Expanded(child: _screens[_currentIndex]),
        ],
      ),
    );
  }
}