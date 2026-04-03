import 'package:flutter/material.dart';

class AppSidebar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const AppSidebar({super.key, required this.selectedIndex, required this.onItemSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      color: const Color(0xFF141414),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(30.0),
            child: Text("CONTANT.IO", style: TextStyle(color: Colors.orange, fontSize: 22, fontWeight: FontWeight.bold)),
          ),
          _header("FEATURES"),
          _item(Icons.edit_note, "Topic to Post", 0),
          _item(Icons.person_search, "LinkedIn Lead Gen", 1),
          const SizedBox(height: 20),
          _header("SETTINGS"),
          _item(Icons.link, "Add LinkedIn Acc", 2),
          _item(Icons.credit_card, "Subscription", 3),
          _item(Icons.person_outline, "Profile Settings", 4),
          const Spacer(),
          _creditWidget(),
        ],
      ),
    );
  }

  Widget _header(String title) => Padding(
    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10), 
    child: Text(title, style: const TextStyle(fontSize: 11, color: Colors.grey))
  );

  Widget _item(IconData icon, String label, int index) {
    bool isSelected = selectedIndex == index;
    return ListTile(
      leading: Icon(icon, color: isSelected ? Colors.orange : Colors.grey),
      title: Text(label, style: TextStyle(color: isSelected ? Colors.white : Colors.grey)),
      onTap: () => onItemSelected(index),
      selected: isSelected,
      selectedTileColor: Colors.orange.withOpacity(0.05),
    );
  }

  Widget _creditWidget() => Container(
    margin: const EdgeInsets.all(20),
    padding: const EdgeInsets.all(15),
    decoration: BoxDecoration(color: const Color(0xFF1F1F1F), borderRadius: BorderRadius.circular(12)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("8.0k Credits Left", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
        const SizedBox(height: 8),
        LinearProgressIndicator(value: 0.8, backgroundColor: Colors.grey[800], color: Colors.orange),
      ],
    ),
  );
}