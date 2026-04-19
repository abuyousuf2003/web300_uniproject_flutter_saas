import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PostGenScreen extends StatefulWidget {
  const PostGenScreen({super.key});

  @override
  State<PostGenScreen> createState() => _PostGenScreenState();
}

class _PostGenScreenState extends State<PostGenScreen> {
  final TextEditingController _topicController = TextEditingController();
  final TextEditingController _audienceController = TextEditingController();

  String _generatedPost = "Your generated post will appear here...";
  bool _isLoading = false;

  Future<void> _savePostToFirebase(String postText, String topic) async {
    final String uid = FirebaseAuth.instance.currentUser?.uid ?? "guest_user_123";

    try {
      await FirebaseFirestore.instance.collection('generated_posts').add({
        'userId': uid,
        'topic': topic,
        'postText': postText,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      debugPrint("❌ Firestore Save Error: $e");
    }
  }

  Future<void> generatePost() async {
    if (_topicController.text.isEmpty) return;

    setState(() => _isLoading = true);

    try {
      final url = Uri.parse(
        'https://abuyousufmdjumman.n8nclouds.com/webhook-test/993e94b5-bbd7-4a79-88e3-c3cfffcccc2c'
      );

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'topic': _topicController.text,
          'audience': _audienceController.text,
          'action': 'generate_linkedin_post',
        }),
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        String result = (data['myField'] ?? response.body)
            .toString()
            .replaceAll(r'\n', '\n');

        setState(() => _generatedPost = result);
        await _savePostToFirebase(result, _topicController.text);

        // ✅ simple success message (no limits)
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.orange,
            content: Text(
              "Post generated successfully",
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
        );
      }
    } catch (e) {
      setState(() => _generatedPost = "Error: $e");
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Row(
            children: [
              Expanded(flex: 5, child: _buildInputPanel()),
              const SizedBox(width: 25),
              Expanded(
                flex: 5,
                child: _buildActiveOutputPanel(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputPanel() {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(color: const Color(0xFF171717), borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Social Go AI", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 10),
          const SizedBox(height: 25),
          _textField(_topicController, "Topic...", 4),
          const SizedBox(height: 20),
          _textField(_audienceController, "Target Audience...", 2),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              onPressed: _isLoading ? null : generatePost,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.black)
                  : const Text(
                      "Generate Post",
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveOutputPanel() {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(color: const Color(0xFF171717), borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("AI Output", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),

              IconButton(
                icon: const Icon(Icons.copy, color: Colors.orange, size: 20),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: _generatedPost));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Copied to clipboard"),
                      backgroundColor: Colors.orange,
                    ),
                  );
                },
              ),
            ],
          ),
          const Divider(color: Colors.white10, height: 30),
          Expanded(
            child: SingleChildScrollView(
              child: SelectableText(
                _generatedPost,
                style: const TextStyle(color: Colors.white70, fontSize: 15, height: 1.5),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _textField(TextEditingController controller, String hint, int lines) =>
      TextField(
        controller: controller,
        maxLines: lines,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white24),
          filled: true,
          fillColor: const Color(0xFF0F0F0F),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
        ),
      );
}

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:flutter/services.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class PostGenScreen extends StatefulWidget {
//   const PostGenScreen({super.key});

//   @override
//   State<PostGenScreen> createState() => _PostGenScreenState();
// }

// class _PostGenScreenState extends State<PostGenScreen> {
//   final TextEditingController _topicController = TextEditingController();
//   final TextEditingController _audienceController = TextEditingController();

//   String _generatedPost = "Your generated post will appear here...";
//   bool _isLoading = false;
//   final int _dailyLimit = 50;

//   // 🔹 Check how many posts are left in the last 24 hours
//  Future<int> _getRemainingPosts() async {
//   final String uid = FirebaseAuth.instance.currentUser?.uid ?? "guest_user_123";
  
//   // Use a sliding 24-hour window
//   DateTime twentyFourHoursAgo = DateTime.now().subtract(const Duration(hours: 24));

//   try {
//     // 1. Small delay to ensure the local cache registers the latest 'add' operation
//     await Future.delayed(const Duration(milliseconds: 500));

//     // 2. Query with 'get()' fetches from server + local cache
//     QuerySnapshot snapshot = await FirebaseFirestore.instance
//         .collection('generated_posts')
//         .where('userId', isEqualTo: uid)
//         .where('createdAt', isGreaterThan: twentyFourHoursAgo)
//         .get(const GetOptions(source: Source.serverAndCache));

//     int used = snapshot.docs.length;
//     int remaining = (5 - used).clamp(0, 5);
    
//     debugPrint("📊 Quota Sync: Found $used posts in last 24h. Remaining: $remaining");
//     return remaining;
    
//   } catch (e) {
//     debugPrint("Quota Check Error: $e");
//     // Return 5 during development so you aren't locked out by index builds
//     return 5; 
//   }
// }

//   Future<void> _savePostToFirebase(String postText, String topic) async {
//     final String uid = FirebaseAuth.instance.currentUser?.uid ?? "guest_user_123"; 

//     try {
//       await FirebaseFirestore.instance.collection('generated_posts').add({
//         'userId': uid,
//         'topic': topic,
//         'postText': postText,
//         'createdAt': FieldValue.serverTimestamp(),
//       });
//     } catch (e) {
//       debugPrint("❌ Firestore Save Error: $e");
//     }
//   }

//   Future<void> generatePost() async {
//     if (_topicController.text.isEmpty) return;

//     setState(() => _isLoading = true);

//     // 1. Verify Quota
//     int remaining = await _getRemainingPosts();
    
//     if (remaining <= 0) {
//       setState(() {
//         _isLoading = false;
//         _generatedPost = "⚠️ Daily Limit Reached!\nYou have 0 posts left. Try again tomorrow.";
//       });
//       return;
//     }

//     // 2. Execute Generation
//     try {
//       final url = Uri.parse(
//         'https://abuyousufmdjumman.n8nclouds.com/webhook-test/993e94b5-bbd7-4a79-88e3-c3cfffcccc2c'
//         // 'https://abuyousufmdjumman.n8nclouds.com/webhook/993e94b5-bbd7-4a79-88e3-c3cfffcccc2c'
        
//         );
//       final response = await http.post(
//         url,
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({
//           'topic': _topicController.text,
//           'audience': _audienceController.text,
//           'action': 'generate_linkedin_post',
//         }),
//       ).timeout(const Duration(seconds: 30));

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         String result = (data['myField'] ?? response.body).toString().replaceAll(r'\n', '\n');
        
//         setState(() => _generatedPost = result);
//         await _savePostToFirebase(result, _topicController.text);

//         // 3. Show Popup with remaining credits
//         int newRemaining = remaining - 1;
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             backgroundColor: Colors.orange,
//             content: Text(
//               "Success! You have $newRemaining ${newRemaining == 1 ? 'post' : 'posts'} left for today.",
//               style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//             ),
//           ),
//         );
//       }
//     } catch (e) {
//       setState(() => _generatedPost = "Error: $e");
//     } finally {
//       if (mounted) setState(() => _isLoading = false);
//     }
//   }

//   void _showFullPostDialog(String? topic, String? text) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         backgroundColor: const Color(0xFF171717),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//         title: Text(topic ?? "Post Preview", style: const TextStyle(color: Colors.orange)),
//         content: SizedBox(width: 500, child: SingleChildScrollView(child: SelectableText(text ?? "", style: const TextStyle(color: Colors.white70, height: 1.5)))),
//         actions: [
//           TextButton(onPressed: () => Navigator.pop(context), child: const Text("Close", style: TextStyle(color: Colors.grey))),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF0D0D0D),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(30),
//           child: Row(
//             children: [
//               Expanded(flex: 5, child: _buildInputPanel()),
//               const SizedBox(width: 25),
//               Expanded(
//                 flex: 5,
//                 child: Column(
//                   children: [
//                     Expanded(flex: 6, child: _buildActiveOutputPanel()),
//                     const SizedBox(height: 20),
//                     Expanded(flex: 4, child: _buildHistoryPanel()),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildInputPanel() {
//     return Container(
//       padding: const EdgeInsets.all(25),
//       decoration: BoxDecoration(color: const Color(0xFF171717), borderRadius: BorderRadius.circular(20)),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text("Social Go AI", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white)),
//           const SizedBox(height: 10),
//           const Text("Free Tier: 5 Posts / Day", style: TextStyle(color: Colors.orange, fontSize: 12)),
//           const SizedBox(height: 25),
//           _textField(_topicController, "Topic...", 4),
//           const SizedBox(height: 20),
//           _textField(_audienceController, "Target Audience...", 2),
//           const Spacer(),
//           SizedBox(
//             width: double.infinity,
//             height: 55,
//             child: ElevatedButton(
//               onPressed: _isLoading ? null : generatePost,
//               style: ElevatedButton.styleFrom(backgroundColor: Colors.orange, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
//               child: _isLoading ? const CircularProgressIndicator(color: Colors.black) : const Text("Generate Post", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildActiveOutputPanel() {
//     return Container(
//       padding: const EdgeInsets.all(25),
//       decoration: BoxDecoration(color: const Color(0xFF171717), borderRadius: BorderRadius.circular(20)),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text("AI Output", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
//           const Divider(color: Colors.white10, height: 30),
//           Expanded(child: SingleChildScrollView(child: SelectableText(_generatedPost, style: const TextStyle(color: Colors.white70, fontSize: 15, height: 1.5)))),
//         ],
//       ),
//     );
//   }

//   Widget _buildHistoryPanel() {
//     final String currentUid = FirebaseAuth.instance.currentUser?.uid ?? "guest_user_123";

//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(color: const Color(0xFF171717), borderRadius: BorderRadius.circular(24)),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text("Recent Activity", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
//           const SizedBox(height: 15),
//           Expanded(
//             child: StreamBuilder<QuerySnapshot>(
//               stream: FirebaseFirestore.instance
//                   .collection('generated_posts')
//                   .where('userId', isEqualTo: currentUid)
//                   .orderBy('createdAt', descending: true)
//                   .limit(3)
//                   .snapshots(),
//               builder: (context, snapshot) {
//                 if (snapshot.hasError) return const Text("Error loading history", style: TextStyle(color: Colors.red));
//                 if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
                
//                 final docs = snapshot.data!.docs;
//                 return ListView.builder(
//                   itemCount: docs.length,
//                   itemBuilder: (context, index) {
//                     var data = docs[index].data() as Map<String, dynamic>;
//                     return Card(
//                       color: const Color(0xFF222222),
//                       margin: const EdgeInsets.only(bottom: 8),
//                       child: ListTile(
//                         title: Text(data['topic'] ?? "", style: const TextStyle(color: Colors.orange, fontSize: 12)),
//                         trailing: IconButton(icon: const Icon(Icons.visibility, size: 18, color: Colors.white38), onPressed: () => _showFullPostDialog(data['topic'], data['postText'])),
//                         onTap: () => setState(() => _generatedPost = data['postText']),
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _textField(TextEditingController controller, String hint, int lines) => TextField(
//     controller: controller,
//     maxLines: lines,
//     style: const TextStyle(color: Colors.white),
//     decoration: InputDecoration(
//       hintText: hint,
//       hintStyle: const TextStyle(color: Colors.white24),
//       filled: true,
//       fillColor: const Color(0xFF0F0F0F),
//       border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
//     ),
//   );
// }