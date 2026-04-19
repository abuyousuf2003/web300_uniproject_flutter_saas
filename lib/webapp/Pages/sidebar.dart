import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppSidebar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const AppSidebar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Container(
      width: 260,
      color: const Color(0xFF141414),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔹 Branding
          const Padding(
            padding: EdgeInsets.all(30.0),
            child: Text(
              "SocialGo",
              style: TextStyle(
                color: Colors.orange,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // 🔹 Menu
          Expanded(
            child: ListView(
              children: [
                _header("FEATURES"),
                _item(Icons.edit_note, "Topic to Post", 0),
                _item(Icons.person_search, "LinkedIn Lead Gen", 1),

                const SizedBox(height: 20),

                _header("SETTINGS"),
                _item(Icons.link, "Add LinkedIn Acc", 2),
                _item(Icons.credit_card, "Subscription", 3),
                _item(Icons.person_outline, "Profile Settings", 4),
              ],
            ),
          ),

       
          const Divider(color: Colors.white10),

          if (user != null) _userInfo(user),

          _logoutButton(context),

          _creditWidget(),
        ],
      ),
    );
  }

  //  Section header
  Widget _header(String title) => Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Text(
          title,
          style: const TextStyle(fontSize: 11, color: Colors.grey),
        ),
      );

  //  Menu item
  Widget _item(IconData icon, String label, int index) {
    bool isSelected = selectedIndex == index;

    return ListTile(
      leading: Icon(icon, color: isSelected ? Colors.orange : Colors.grey),
      title: Text(
        label,
        style: TextStyle(color: isSelected ? Colors.white : Colors.grey),
      ),
      onTap: () => onItemSelected(index),
      selected: isSelected,
      selectedTileColor: Colors.orange.withOpacity(0.05),
    );
  }

  //  User info
  Widget _userInfo(User user) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 16,
            backgroundColor: Colors.orange,
            child: Icon(Icons.person, size: 18, color: Colors.white),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              user.email ?? "User",
              style: const TextStyle(color: Colors.white, fontSize: 12),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  //  Logout button
Widget _logoutButton(BuildContext context) {
  return ListTile(
    leading: const Icon(Icons.logout, color: Colors.red),
    title: const Text(
      "Logout",
      style: TextStyle(color: Colors.red),
    ),
    onTap: () async {
      print("Logout clicked");

      // 🔹 Close any open dialogs / overlays safely
      FocusScope.of(context).unfocus();

      // 🔹 Show confirmation
      final confirm = await showDialog<bool>(
        context: context,
        barrierDismissible: true,
        builder: (context) => AlertDialog(
          title: const Text("Logout"),
          content: const Text("Are you sure you want to logout?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text("Logout"),
            ),
          ],
        ),
      );

      print("Dialog result: $confirm");

      // 🔹 Actually logout
      if (confirm == true) {
        await FirebaseAuth.instance.signOut();
        print("Logout success");
      }
    },
  );
}

  // 🔹 Credits widget
  Widget _creditWidget() => Container(
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "8.0k Credits Left",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: 0.8,
              backgroundColor: Colors.grey,
              color: Colors.orange,
            ),
          ],
        ),
      );
}