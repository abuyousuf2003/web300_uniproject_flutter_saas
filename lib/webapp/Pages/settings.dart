import 'package:flutter/material.dart';

// 1. LinkedIn Account Logic
class LinkedInAccountScreen extends StatelessWidget {
  const LinkedInAccountScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return _wrapper("LinkedIn Automation", [
      const Text("Connect your LinkedIn account to enable automated posting and profile engagement."),
      const SizedBox(height: 20),
      ListTile(tileColor: Colors.black, title: const Text("Abu Yousuf Md Jumman"), subtitle: const Text("Status: Connected"), trailing: const Icon(Icons.check_circle, color: Colors.green)),
    ]);
  }
}

// 2. Subscription Logic
class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return _wrapper("Subscription", [
      const Card(color: Colors.orange, child: ListTile(title: Text("Pro Plan", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)), subtitle: Text("Renewing on April 20, 2026", style: TextStyle(color: Colors.black54)))),
      const SizedBox(height: 20),
      TextButton(onPressed: () {}, child: const Text("Cancel Subscription", style: TextStyle(color: Colors.red))),
    ]);
  }
}

// 3. Profile Logic
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return _wrapper("Profile Settings", [
      const CircleAvatar(radius: 40, backgroundColor: Colors.orange, child: Icon(Icons.person, size: 40)),
      const SizedBox(height: 20),
      const TextField(decoration: InputDecoration(labelText: "Full Name")),
    ]);
  }
}

Widget _wrapper(String title, List<Widget> children) => Padding(
  padding: const EdgeInsets.all(40),
  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
    const SizedBox(height: 30),
    ...children
  ]),
);