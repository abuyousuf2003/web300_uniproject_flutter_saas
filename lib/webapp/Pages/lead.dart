// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart'; // Required for Clipboard
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:url_launcher/url_launcher.dart'; // Required for LinkedIn Links

// class LinkedInLeadGenScreen extends StatefulWidget {
//   const LinkedInLeadGenScreen({super.key});

//   @override
//   State<LinkedInLeadGenScreen> createState() => _LinkedInLeadGenScreenState();
// }

// class _LinkedInLeadGenScreenState extends State<LinkedInLeadGenScreen> {
//   // Controllers for the 9 targeting fields
//   final TextEditingController _jobTitleController = TextEditingController();
//   final TextEditingController _roleController = TextEditingController();
//   final TextEditingController _departmentController = TextEditingController();
//   final TextEditingController _locationController = TextEditingController();
//   final TextEditingController _industryController = TextEditingController();
//   final TextEditingController _companySizeController = TextEditingController();
//   final TextEditingController _revenueController = TextEditingController();
//   final TextEditingController _specialitiesController = TextEditingController();
//   final TextEditingController _platformController = TextEditingController();

//   bool _loading = false;
//   List<Map<String, dynamic>> _leads = [];

//   // Design Constants (Using hex to avoid initialization crashes)
//   final Color primaryColor = const Color(0xFFF54A00); 
//   final Color primaryLight = const Color(0xFFFFEEE5); 
//   final Color backgroundColor = const Color(0xFFF9FAFB);
//   final Color cardColor = Colors.white;

//   // n8n Webhook Integration
//   Future<void> _fetchLeads() async {
//     setState(() {
//       _loading = true;
//       _leads = [];
//     });

//     final body = {
//       "job_title": _jobTitleController.text,
//       "role": _roleController.text,
//       "department": _departmentController.text,
//       "location": _locationController.text,
//       "industry": _industryController.text,
//       "company_size": _companySizeController.text,
//       "revenue": _revenueController.text,
//       "specialities": _specialitiesController.text,
//       "platform": _platformController.text,
//       "submission_id": DateTime.now().millisecondsSinceEpoch.toString(),
//     };

//     try {
//       final response = await http.post(
//         Uri.parse("https://abuyousufmdjumman.n8nclouds.com/webhook/f9a40868-7359-47ee-bece-dc62d26237d3"),
//         headers: {"Content-Type": "application/json"},
//         body: jsonEncode(body),
//       );

//       if (response.statusCode == 200) {
//         final dynamic decodedData = jsonDecode(response.body);
//         setState(() {
//           if (decodedData is List) {
//             _leads = List<Map<String, dynamic>>.from(decodedData);
//           } else if (decodedData is Map) {
//             _leads = [Map<String, dynamic>.from(decodedData)];
//           }
//         });
//       }
//     } catch (e) {
//       debugPrint("Connection Error: $e");
//     } finally {
//       setState(() => _loading = false);
//     }
//   }

//   // Helper to launch LinkedIn URLs
//   Future<void> _launchURL(String? urlString) async {
//     if (urlString == null || urlString.isEmpty) {
//       _showToast("No URL available");
//       return;
//     }
//     final Uri url = Uri.parse(urlString);
//     if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
//       _showToast("Could not launch $urlString");
//     }
//   }

//   void _showToast(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text(message), behavior: SnackBarBehavior.floating, width: 280),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: backgroundColor,
//       body: Row(
//         children: [
//           // Left Sidebar: Form
//           Container(
//             width: 320,
//             decoration: BoxDecoration(
//               color: cardColor,
//               border: Border(right: BorderSide(color: Colors.grey.shade200)),
//             ),
//             child: Column(
//               children: [
//                 _buildSidebarHeader(),
//                 Expanded(
//                   child: ListView(
//                     padding: const EdgeInsets.symmetric(horizontal: 20),
//                     children: [
//                       _buildSectionTitle("Targeting Criteria"),
//                       _buildTextField(_jobTitleController, "Job Title", Icons.work_outline),
//                       _buildTextField(_roleController, "Role", Icons.person_search_outlined),
//                       _buildTextField(_departmentController, "Department", Icons.business_outlined),
//                       _buildTextField(_locationController, "Location", Icons.location_on_outlined),
//                       _buildTextField(_industryController, "Industry", Icons.factory_outlined),
//                       _buildTextField(_companySizeController, "Company Size", Icons.groups_outlined),
//                       _buildTextField(_revenueController, "Revenue", Icons.monetization_on_outlined),
//                       _buildTextField(_specialitiesController, "Specialities", Icons.star_border),
//                       _buildTextField(_platformController, "Platform", Icons.computer_outlined),
//                       const SizedBox(height: 24),
//                       _buildSearchButton(),
//                       const SizedBox(height: 40),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           // Right Main Area: Results
//           Expanded(
//             child: _loading 
//               ? Center(child: CircularProgressIndicator(color: primaryColor))
//               : _leads.isEmpty 
//                 ? _buildEmptyState() 
//                 : _buildResultsArea(),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSidebarHeader() {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
//       child: Row(
//         children: [
//           Icon(Icons.bolt, color: primaryColor, size: 28),
//           const SizedBox(width: 12),
//           const Text("Social Leads", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//         ],
//       ),
//     );
//   }

//   Widget _buildSectionTitle(String title) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 12, top: 10),
//       child: Text(title.toUpperCase(), style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Colors.grey.shade500, letterSpacing: 1.1)),
//     );
//   }

//   Widget _buildTextField(TextEditingController controller, String label, IconData icon) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 6),
//       child: TextField(
//         controller: controller,
//         style: const TextStyle(fontSize: 14),
//         decoration: InputDecoration(
//           isDense: true,
//           prefixIcon: Icon(icon, size: 18, color: Colors.grey.shade400),
//           hintText: label,
//           filled: true,
//           fillColor: const Color(0xFFF3F4F6),
//           border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
//         ),
//       ),
//     );
//   }

//   Widget _buildSearchButton() {
//     return SizedBox(
//       width: double.infinity, height: 50,
//       child: ElevatedButton(
//         onPressed: _loading ? null : _fetchLeads,
//         style: ElevatedButton.styleFrom(backgroundColor: primaryColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), elevation: 0),
//         child: const Text("Find Leads", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
//       ),
//     );
//   }

//   Widget _buildResultsArea() {
//     return ListView(
//       padding: const EdgeInsets.all(40),
//       children: [
//         Text("Search Results (${_leads.length})", style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
//         const SizedBox(height: 24),
//         ..._leads.map((lead) => _buildLeadCard(lead)).toList(),
//       ],
//     );
//   }

//   Widget _buildLeadCard(Map<String, dynamic> lead) {
//     final String email = lead['email'] ?? 'N/A';
//     final String? linkedInUrl = lead['linkedinurl']; // Ensure n8n sends this key

//     return Container(
//       margin: const EdgeInsets.only(bottom: 16),
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: Colors.grey.shade100),
//         boxShadow: const [BoxShadow(color: Color(0x0A000000), blurRadius: 10, offset: Offset(0, 4))],
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             width: 50, height: 50,
//             decoration: BoxDecoration(color: primaryLight, borderRadius: BorderRadius.circular(12)),
//             child: Center(child: Text(lead['name']?[0]?.toUpperCase() ?? 'L', style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold, fontSize: 18))),
//           ),
//           const SizedBox(width: 20),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(lead['name'] ?? 'Unknown Lead', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                 const SizedBox(height: 4),
//                 Row(
//                   children: [
//                     Icon(Icons.location_on_outlined, size: 14, color: Colors.grey.shade500),
//                     const SizedBox(width: 4),
//                     Text(lead['location'] ?? 'Global', style: TextStyle(color: Colors.grey.shade600)),
//                     const SizedBox(width: 12),
//                     Icon(Icons.business_center_outlined, size: 14, color: Colors.grey.shade500),
//                     const SizedBox(width: 4),
//                     Text(lead['industry'] ?? 'Industry', style: TextStyle(color: Colors.grey.shade600)),
//                   ],
//                 ),
//                 const SizedBox(height: 12),
//                 // COPYABLE EMAIL FIELD
//                 GestureDetector(
//                   onTap: () {
//                     Clipboard.setData(ClipboardData(text: email));
//                     _showToast("Email copied to clipboard");
//                   },
//                   child: MouseRegion(
//                     cursor: SystemMouseCursors.click,
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//                       decoration: BoxDecoration(color: Colors.grey.shade50, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.shade200)),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Icon(Icons.copy_rounded, size: 14, color: primaryColor),
//                           const SizedBox(width: 8),
//                           Text(email, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           // LINKEDIN ACTION BUTTON
//           ElevatedButton.icon(
//             onPressed: () => _launchURL(linkedInUrl),
//             icon: const Icon(Icons.open_in_new, size: 14),
//             label: const Text("LinkedIn"),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: const Color(0xFF0A66C2), 
//               foregroundColor: Colors.white, 
//               elevation: 0, 
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildEmptyState() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(Icons.person_search_outlined, size: 80, color: Colors.grey.shade200),
//           const SizedBox(height: 16),
//           const Text("Ready to find leads?", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//           Text("Fill out the forms on the left to begin.", style: TextStyle(color: Colors.grey.shade500)),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class LinkedInLeadGenScreen extends StatefulWidget {
  const LinkedInLeadGenScreen({super.key});

  @override
  State<LinkedInLeadGenScreen> createState() => _LinkedInLeadGenScreenState();
}

class _LinkedInLeadGenScreenState extends State<LinkedInLeadGenScreen> {
  // Controllers
  final TextEditingController _jobTitleController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();
  final TextEditingController _departmentController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _industryController = TextEditingController();
  final TextEditingController _companySizeController = TextEditingController();
  final TextEditingController _revenueController = TextEditingController();
  final TextEditingController _specialitiesController = TextEditingController();
  final TextEditingController _platformController = TextEditingController();

  bool _loading = false;
  List<Map<String, dynamic>> _leads = [];

  // Theme
  final Color primaryColor = const Color(0xFFF54A00);
  final Color primaryLight = const Color(0x33F54A00);

  final Color backgroundColor = const Color(0xFF0F0F10);
  final Color cardColor = const Color(0xFF161616);
  final Color sidebarColor = const Color(0xFF121212);
  final Color fieldColor = const Color(0xFF1E1E1E);
  final Color textPrimary = Colors.white;
  final Color textSecondary = const Color(0xFF9CA3AF);

  Future<void> _fetchLeads() async {
    setState(() {
      _loading = true;
      _leads = [];
    });

    final body = {
      "job_title": _jobTitleController.text,
      "role": _roleController.text,
      "department": _departmentController.text,
      "location": _locationController.text,
      "industry": _industryController.text,
      "company_size": _companySizeController.text,
      "revenue": _revenueController.text,
      "specialities": _specialitiesController.text,
      "platform": _platformController.text,
      "submission_id": DateTime.now().millisecondsSinceEpoch.toString(),
    };

    try {
      final response = await http.post(
        Uri.parse("https://abuyousufmdjumman.n8nclouds.com/webhook/f9a40868-7359-47ee-bece-dc62d26237d3"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);

        setState(() {
          if (decoded is List) {
            _leads = List<Map<String, dynamic>>.from(decoded);
          } else {
            _leads = [Map<String, dynamic>.from(decoded)];
          }
        });
      }
    } finally {
      setState(() => _loading = false);
    }
  }

  Future<void> _launchURL(String? url) async {
    if (url == null || url.isEmpty) return;
    final uri = Uri.parse(url);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  void _showToast(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Row(
        children: [
          // SIDEBAR
          Container(
            width: 320,
            color: sidebarColor,
            child: Column(
              children: [
                _buildSidebarHeader(),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    children: [
                      _buildSectionTitle("Targeting Criteria"),
                      _buildTextField(_jobTitleController, "Job Title", Icons.work_outline),
                      _buildTextField(_roleController, "Role", Icons.person),
                      _buildTextField(_departmentController, "Department", Icons.business),
                      _buildTextField(_locationController, "Location", Icons.location_on),
                      _buildTextField(_industryController, "Industry", Icons.factory),
                      _buildTextField(_companySizeController, "Company Size", Icons.groups),
                      _buildTextField(_revenueController, "Revenue", Icons.monetization_on),
                      _buildTextField(_specialitiesController, "Specialities", Icons.star_border),
                      _buildTextField(_platformController, "Platform", Icons.computer),
                      const SizedBox(height: 20),
                      _buildSearchButton(),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // MAIN AREA
          Expanded(
            child: _loading
                ? Center(child: CircularProgressIndicator(color: primaryColor))
                : _leads.isEmpty
                    ? _buildEmptyState()
                    : _buildResults(),
          ),
        ],
      ),
    );
  }

  // ---------------- SIDEBAR ----------------

  Widget _buildSidebarHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          Icon(Icons.bolt, color: primaryColor),
          const SizedBox(width: 10),
          Text(
            "Social Leads",
            style: TextStyle(
              color: textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          color: textSecondary,
          fontSize: 11,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String hint, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: controller,
        style: TextStyle(color: textPrimary),
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: textSecondary, size: 18),
          hintText: hint,
          hintStyle: TextStyle(color: textSecondary),
          filled: true,
          fillColor: fieldColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildSearchButton() {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        onPressed: _loading ? null : _fetchLeads,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          "Find Leads",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }



  Widget _buildResults() {
    return ListView(
      padding: const EdgeInsets.all(30),
      children: [
        Text(
          "Results (${_leads.length})",
          style: TextStyle(
            color: textPrimary,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        ..._leads.map((e) => _buildLeadCard(e)).toList(),
      ],
    );
  }

  Widget _buildLeadCard(Map<String, dynamic> lead) {
    final String email = lead['email'] ?? 'N/A';
    final String? linkedInUrl = lead['linkedinurl'];

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: primaryLight,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                (lead['name'] ?? 'L')[0].toUpperCase(),
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),

          const SizedBox(width: 16),

          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  lead['name'] ?? 'Unknown Lead',
                  style: TextStyle(
                    color: textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(Icons.location_on_outlined,
                        size: 14, color: textSecondary),
                    const SizedBox(width: 4),
                    Text(
                      lead['location'] ?? 'Global',
                      style: TextStyle(color: textSecondary),
                    ),
                    const SizedBox(width: 10),
                    Icon(Icons.business_center_outlined,
                        size: 14, color: textSecondary),
                    const SizedBox(width: 4),
                    Text(
                      lead['industry'] ?? 'Industry',
                      style: TextStyle(color: textSecondary),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Email copy
                GestureDetector(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: email));
                    _showToast("Email copied");
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: fieldColor,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.white10),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.copy, size: 14, color: primaryColor),
                        const SizedBox(width: 6),
                        Text(
                          email,
                          style: TextStyle(
                            color: textPrimary,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          // LinkedIn button
          ElevatedButton.icon(
            onPressed: () => _launchURL(linkedInUrl),
            icon: const Icon(Icons.open_in_new, size: 14),
            label: const Text("LinkedIn"),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0A66C2),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Text(
        "Start searching leads",
        style: TextStyle(color: textSecondary),
      ),
    );
  }
}