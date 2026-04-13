import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/services.dart';

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

  Future<void> generatePost() async {
    if (_topicController.text.isEmpty) return;

    setState(() {
      _isLoading = true;
      _generatedPost = "AI is thinking...";
    });

    try {
      final url = Uri.parse(
          // 'https://abuyousufmdjumman.n8nclouds.com/webhook/993e94b5-bbd7-4a79-88e3-c3cfffcccc2c'
          
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
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          // Use correct key from your webhook: 'myField'
          _generatedPost = (data['myField'] ?? response.body)
              .toString()
              .replaceAll(r'\n', '\n');
        });
      } else {
        setState(() => _generatedPost = "Error: ${response.statusCode}");
      }
    } catch (e) {
      setState(() => _generatedPost = "Failed to connect: $e");
    } finally {
      setState(() => _isLoading = false);
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
              /// LEFT PANEL
              Expanded(
                flex: 5,
                child: Container(
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: const Color(0xFF171717),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Generate LinkedIn Post",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 25),

                      // Topic Input
                      const Text("Topic", style: TextStyle(color: Colors.grey)),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _topicController,
                        maxLines: 4,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: "Write your idea here...",
                          hintStyle: const TextStyle(color: Colors.grey),
                          filled: true,
                          fillColor: const Color(0xFF0F0F0F),
                          contentPadding: const EdgeInsets.all(16),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Target Audience Input
                      const Text("Target Audience",
                          style: TextStyle(color: Colors.grey)),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _audienceController,
                        maxLines: 2,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: "e.g. real estate agents, SaaS founders...",
                          hintStyle: const TextStyle(color: Colors.grey),
                          filled: true,
                          fillColor: const Color(0xFF0F0F0F),
                          contentPadding: const EdgeInsets.all(16),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),

                      const Spacer(),

                      // Generate Button
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : generatePost,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: _isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.black,
                                )
                              : const Text(
                                  "Generate",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(width: 25),

              /// RIGHT PANEL
              Expanded(
                flex: 5,
                child: Container(
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: const Color(0xFF171717),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.auto_awesome, color: Colors.orange, size: 20),
                          SizedBox(width: 10),
                          Text(
                            "AI Output",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      const Divider(color: Colors.white10),
                      const SizedBox(height: 10),

                      // LinkedIn-style post card
                      Expanded(
                        child: SingleChildScrollView(
                          child: Card(
                            color: const Color(0xFF1A1A1A),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Dummy Profile Header
                                  Row(
                                    children: [
                                      const CircleAvatar(
                                        radius: 20,
                                        backgroundImage: NetworkImage(
                                            'https://randomuser.me/api/portraits/women/44.jpg'),
                                      ),
                                      const SizedBox(width: 10),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: const [
                                          Text('Jane Doe',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white)),
                                          Text('Marketing Specialist',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 12)),
                                        ],
                                      ),
                                      const Spacer(),
                                      const Icon(Icons.more_horiz,
                                          color: Colors.grey),
                                    ],
                                  ),
                                  const SizedBox(height: 15),

                                  // Post content
                                  SelectableText(
                                    _generatedPost,
                                    style: const TextStyle(
                                        color: Colors.white70,
                                        fontSize: 15,
                                        height: 1.5),
                                  ),
                                  const SizedBox(height: 15),

                                  // Audience label
                                  if (_audienceController.text.isNotEmpty)
                                    Text(
                                      "Audience: ${_audienceController.text}",
                                      style: const TextStyle(
                                          color: Colors.blueAccent, fontSize: 13),
                                    ),
                                  const SizedBox(height: 15),

                                  // Footer: Like / Comment / Share / Copy
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Row(
                                        children: const [
                                          Icon(Icons.thumb_up,
                                              color: Colors.grey, size: 18),
                                          SizedBox(width: 4),
                                          Text('Like',
                                              style: TextStyle(color: Colors.grey)),
                                        ],
                                      ),
                                      Row(
                                        children: const [
                                          Icon(Icons.comment,
                                              color: Colors.grey, size: 18),
                                          SizedBox(width: 4),
                                          Text('Comment',
                                              style: TextStyle(color: Colors.grey)),
                                        ],
                                      ),
                                      Row(
                                        children: const [
                                          Icon(Icons.share,
                                              color: Colors.grey, size: 18),
                                          SizedBox(width: 4),
                                          Text('Share',
                                              style: TextStyle(color: Colors.grey)),
                                        ],
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.copy,
                                            color: Colors.grey),
                                        onPressed: () {
                                          Clipboard.setData(
                                              ClipboardData(text: _generatedPost));
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  content:
                                                      Text('Copied to clipboard')));
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



