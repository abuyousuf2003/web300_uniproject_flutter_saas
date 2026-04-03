import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LinkedInLeadGenScreen extends StatefulWidget {
  const LinkedInLeadGenScreen({super.key});

  @override
  State<LinkedInLeadGenScreen> createState() => _LinkedInLeadGenScreenState();
}

class _LinkedInLeadGenScreenState extends State<LinkedInLeadGenScreen> {
  // All 9 Controllers
  final TextEditingController _jobTitleController = TextEditingController();
  final TextEditingController _departmentController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _industryController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();
  final TextEditingController _companySizeController = TextEditingController();
  final TextEditingController _revenueController = TextEditingController();
  final TextEditingController _specialitiesController = TextEditingController();
  final TextEditingController _platformController = TextEditingController();

  bool _loading = false;
  List<Map<String, String>> _leads = [];

  // Updated Theme Colors
  final Color primaryColor = const Color(0xFFF54A00); // Your requested color: f54a00
  final Color backgroundColor = const Color(0xFFF9FAFB);
  final Color cardColor = Colors.white;

  Future<void> _fetchLeads() async {
    setState(() {
      _loading = true;
      _leads = [];
    });

    final body = {
      "job_title": _jobTitleController.text,
      "department": _departmentController.text,
      "location": _locationController.text,
      "industry": _industryController.text,
      "role": _roleController.text,
      "company_size": _companySizeController.text,
      "revenue": _revenueController.text,
      "specialities": _specialitiesController.text,
      "platform": _platformController.text,
      "submission_id": DateTime.now().millisecondsSinceEpoch.toString(),
    };

    try {
      final response = await http.post(
        Uri.parse("https://your-n8n-webhook-url.com/lead-gen"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _leads = List<Map<String, String>>.from(data['leads'] ?? []);
        });
      }
    } catch (e) {
      debugPrint("Error: $e");
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Row(
        children: [
          // Sidebar with all fields visible via ScrollView
          Container(
            width: 300,
            decoration: BoxDecoration(
              color: cardColor,
              border: Border(right: BorderSide(color: Colors.grey.shade200)),
            ),
            child: Column(
              children: [
                _buildSidebarHeader(),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    children: [
                      _buildSectionTitle("Targeting Criteria"),
                      _buildTextField(_jobTitleController, "Job Title", Icons.work_outline),
                      _buildTextField(_roleController, "Role", Icons.person_search_outlined),
                      _buildTextField(_departmentController, "Department", Icons.business_outlined),
                      _buildTextField(_locationController, "Location", Icons.location_on_outlined),
                      _buildTextField(_industryController, "Industry", Icons.factory_outlined),
                      _buildTextField(_companySizeController, "Company Size", Icons.groups_outlined),
                      _buildTextField(_revenueController, "Revenue", Icons.monetization_on_outlined),
                      _buildTextField(_specialitiesController, "Specialities", Icons.star_border),
                      _buildTextField(_platformController, "Platform", Icons.computer_outlined),
                      const SizedBox(height: 16),
                      _buildSearchButton(),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Results Panel
          Expanded(
            child: _leads.isEmpty && !_loading 
                ? _buildEmptyState() 
                : _buildResultsArea(),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebarHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(color: primaryColor, borderRadius: BorderRadius.circular(8)),
            child: const Icon(Icons.flash_on, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 10),
          const Text(
            "LeadGen AI",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Color(0xFF1F2937)),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, top: 4),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey.shade500, letterSpacing: 1.2),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: TextField(
        controller: controller,
        style: const TextStyle(fontSize: 13),
        decoration: InputDecoration(
          isDense: true, // Makes it compact to fit more fields
          prefixIcon: Icon(icon, size: 16, color: Colors.grey.shade400),
          hintText: label,
          filled: true,
          fillColor: const Color(0xFFF3F4F6),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: primaryColor.withOpacity(0.4), width: 1.5),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchButton() {
    return SizedBox(
      width: double.infinity,
      height: 44,
      child: ElevatedButton(
        onPressed: _loading ? null : _fetchLeads,
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: _loading
            ? const SizedBox(height: 18, width: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
            : const Text("Find Leads", style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildResultsArea() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Results", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey.shade800)),
              if (_leads.isNotEmpty)
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.file_download_outlined, size: 18),
                  label: const Text("Export"),
                  style: TextButton.styleFrom(foregroundColor: primaryColor),
                ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: _loading 
              ? Center(child: CircularProgressIndicator(color: primaryColor))
              : ListView.builder(
                  itemCount: _leads.length,
                  itemBuilder: (context, index) => _buildLeadCard(_leads[index]),
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeadCard(Map<String, String> lead) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: primaryColor.withOpacity(0.1),
            child: Text(lead['name']?[0] ?? 'L', style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(lead['name'] ?? 'Contact Name', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                Text("${lead['position']} at ${lead['company']}", style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.shade50,
              foregroundColor: Colors.blue.shade700,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 12),
            ),
            child: const Text("LinkedIn", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off_rounded, size: 64, color: Colors.grey.shade200),
          const SizedBox(height: 16),
          Text("No leads found", style: TextStyle(color: Colors.grey.shade400)),
        ],
      ),
    );
  }
}