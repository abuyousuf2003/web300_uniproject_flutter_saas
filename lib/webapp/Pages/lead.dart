import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

// Native imports
import 'dart:io' show Platform, File, Process;
import 'package:path_provider/path_provider.dart';
import 'package:csv/csv.dart';

// Web-specific import (handled safely)
import 'dart:html' as html if (dart.library.io) 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: LinkedInLeadGen(), debugShowCheckedModeBanner: false));

class Lead {
  final String name, email, linkedin, industry, location;

  Lead({
    required this.name,
    required this.email,
    required this.linkedin,
    required this.industry,
    required this.location,
  });

  factory Lead.fromJson(Map<String, dynamic> json) => Lead(
        name: json['name'] ?? 'Unknown',
        email: json['email'] ?? 'N/A',
        linkedin: json['linkedinurl'] ?? '',
        industry: json['industry'] ?? 'N/A',
        location: json['location'] ?? 'N/A',
      );
}

class LinkedInLeadGen extends StatefulWidget {
  const LinkedInLeadGen({super.key});
  @override
  State<LinkedInLeadGen> createState() => _LinkedInLeadGenState();
}

class _LinkedInLeadGenState extends State<LinkedInLeadGen> {
  final List<String> _countries = [
    "United States", "Canada", "United Kingdom", "Australia", "Germany", "France", "India",
    "Singapore", "Netherlands", "United Arab Emirates", "Brazil", "Spain", "Italy", "Mexico",
    "Japan", "Sweden", "Switzerland", "Norway", "Ireland", "New Zealand", "South Africa",
    "Poland", "Belgium", "Denmark", "Israel"
  ]..sort();

  final List<String> _companySizes = ["1-10", "11-50", "51-200", "201-500", "501-1000", "1001-5000", "5001-10000", "10001+"];
  final List<String> _seniorityOptions = ["c_suite", "vp", "director", "manager", "senior", "entry", "owner", "partner"];

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _keywordController = TextEditingController();
  final TextEditingController _countController = TextEditingController(text: "10");

  List<String> _jobTitles = [];
  List<String> _companyKeywords = [];
  List<String> _selectedCompanySizes = [];
  List<String> _selectedSeniority = [];
  String _selectedCountry = "United States";
  bool _hasEmail = true;
  bool _hasPhone = false;
  bool _isLoading = false;
  List<Lead> _leads = [];

  // ✅ UNIVERSAL SAVE LOGIC (WEB + WINDOWS + MOBILE)
  Future<void> _universalDownload(String content, String fileName) async {
    if (_leads.isEmpty) return;

    if (kIsWeb) {
      // WEB LOGIC
      final bytes = utf8.encode(content);
      final blob = html.Blob([bytes]);
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.AnchorElement(href: url)
        ..setAttribute("download", fileName)
        ..click();
      html.Url.revokeObjectUrl(url);
      _showSnack("Download started in browser");
    } else {
      // NATIVE LOGIC (Windows/Android/iOS)
      try {
        String? path;
        if (Platform.isWindows) {
          final userProfile = Platform.environment['USERPROFILE'];
          if (userProfile != null) path = "$userProfile\\Downloads\\$fileName";
        }

        if (path == null) {
          final dir = await getApplicationDocumentsDirectory();
          path = "${dir.path}/$fileName";
        }

        final file = File(path);
        await file.writeAsString(content);

        if (Platform.isWindows) {
          await Process.run('explorer.exe', ['/select,', path]);
        }
        _showSnack("File saved to: $path");
      } catch (e) {
        _showSnack("Error saving file: $e", isError: true);
      }
    }
  }

  void _showSnack(String msg, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: isError ? Colors.redAccent : Colors.green),
    );
  }

  Future<void> _downloadCSV() async {
    List<List<String>> rows = [["Name", "Email", "LinkedIn", "Industry", "Location"]];
    for (var lead in _leads) {
      rows.add([lead.name, lead.email, lead.linkedin, lead.industry, lead.location]);
    }
    String csvData = const ListToCsvConverter().convert(rows);
    await _universalDownload(csvData, "leads.csv");
  }

  Future<void> _downloadHTML() async {
    StringBuffer htmlBuffer = StringBuffer();
    htmlBuffer.write("""
      <html><head><style>
        body { font-family: sans-serif; padding: 20px; background: #f4f4f4; }
        table { width: 100%; border-collapse: collapse; background: white; }
        th, td { padding: 12px; border: 1px solid #ddd; text-align: left; }
        th { background: #F54A00; color: white; }
        a { color: #0077B5; text-decoration: none; font-weight: bold; }
      </style></head><body>
      <h2>Leads Export</h2><table><tr><th>Name</th><th>Email</th><th>Industry</th><th>LinkedIn</th></tr>
    """);
    for (var lead in _leads) {
      htmlBuffer.write("<tr><td>${lead.name}</td><td>${lead.email}</td><td>${lead.industry}</td><td><a href='${lead.linkedin}'>Profile</a></td></tr>");
    }
    htmlBuffer.write("</table></body></html>");
    await _universalDownload(htmlBuffer.toString(), "leads.html");
  }

  Future<void> _launchAgent() async {
    if (_titleController.text.trim().isNotEmpty) {
      if (!_jobTitles.contains(_titleController.text.trim())) {
        _jobTitles.add(_titleController.text.trim());
      }
      _titleController.clear();
    }
    if (_keywordController.text.trim().isNotEmpty) {
      if (!_companyKeywords.contains(_keywordController.text.trim())) {
        _companyKeywords.add(_keywordController.text.trim());
      }
      _keywordController.clear();
    }

    setState(() => _isLoading = true);

    final payload = {
      "companyKeywordIncludes": _companyKeywords,
      "companySizeIncludes": _selectedCompanySizes,
      "personTitleIncludes": _jobTitles,
      "seniorityIncludes": _selectedSeniority,
      "personLocationCountryIncludes": [_selectedCountry],
      "hasEmail": _hasEmail,
      "hasPhone": _hasPhone,
      "totalResults": int.tryParse(_countController.text) ?? 10,
      "dontSaveProgress": false,
      "resetProgress": false,
      "includeTitleVariants": false,
    };

    try {
      final response = await http.post(
        Uri.parse("https://abuyousufmdjumman.n8nclouds.com/webhook/f9a40868-7359-47ee-bece-dc62d26237d3"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(payload),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() => _leads = data.map((e) => Lead.fromJson(e)).toList());
      }
    } catch (e) {
      _showSnack("Network Error: $e", isError: true);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Row(children: [
            Container(
              width: 380,
              color: const Color(0xFF0D0D0E),
              padding: const EdgeInsets.all(24),
              child: SingleChildScrollView(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text("B2B LEAD PRO", style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 30),
                  _label("Job Titles"),
                  _buildListInput(_titleController, _jobTitles, "e.g. CEO, Founder"),
                  const SizedBox(height: 20),
                  _label("Keywords"),
                  _buildListInput(_keywordController, _companyKeywords, "e.g. SaaS"),
                  const SizedBox(height: 25),
                  _label("Target Country"),
                  _buildDropdown(_countries, _selectedCountry, (val) => setState(() => _selectedCountry = val!)),
                  const SizedBox(height: 25),
                  _label("Company Size"),
                  _buildMultiSelect(_companySizes, _selectedCompanySizes),
                  const SizedBox(height: 25),
                  _label("Seniority"),
                  _buildMultiSelect(_seniorityOptions, _selectedSeniority),
                  const SizedBox(height: 25),
                  _label("Data Verification"),
                  Row(children: [
                    _toggle("Verified Email", _hasEmail, (v) => setState(() => _hasEmail = v)),
                    const SizedBox(width: 10),
                    _toggle("With Phone", _hasPhone, (v) => setState(() => _hasPhone = v)),
                  ]),
                  const SizedBox(height: 20),
                  _label("Fetch Limit"),
                  _inputField(_countController, "10"),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity, height: 55,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _launchAgent,
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFF54A00), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                      child: _isLoading ? const CircularProgressIndicator(color: Colors.white) : const Text("LAUNCH AGENT", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                    ),
                  )
                ]),
              ),
            ),
            Expanded(child: _buildResultsList()),
          ]),
          Positioned(
            top: 20, right: 20,
            child: Row(
              children: [
                ElevatedButton.icon(
                  onPressed: _downloadCSV,
                  icon: const Icon(Icons.table_rows, size: 16),
                  label: const Text("CSV"),
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFF54A00)),
                ),
                const SizedBox(width: 10),
                ElevatedButton.icon(
                  onPressed: _downloadHTML,
                  icon: const Icon(Icons.html, size: 16),
                  label: const Text("HTML"),
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF333333)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  // UI HELPERS
  Widget _label(String text) => Padding(padding: const EdgeInsets.only(bottom: 8), child: Text(text.toUpperCase(), style: const TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.bold)));

  Widget _buildListInput(TextEditingController controller, List<String> list, String hint) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      TextField(
        controller: controller,
        onSubmitted: (val) { if (val.trim().isNotEmpty) { setState(() => list.add(val.trim())); controller.clear(); } },
        style: const TextStyle(color: Colors.white, fontSize: 13),
        decoration: InputDecoration(hintText: hint, hintStyle: const TextStyle(color: Colors.white12), filled: true, fillColor: Colors.black26, border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none)),
      ),
      if (list.isNotEmpty) Wrap(spacing: 6, children: list.map((t) => Chip(label: Text(t, style: const TextStyle(fontSize: 10, color: Colors.white)), backgroundColor: const Color(0xFFF54A00).withOpacity(0.2), onDeleted: () => setState(() => list.remove(t)))).toList()),
    ]);
  }

  Widget _buildDropdown(List<String> items, String current, Function(String?) onChange) {
    return Container(padding: const EdgeInsets.symmetric(horizontal: 12), decoration: BoxDecoration(color: Colors.black26, borderRadius: BorderRadius.circular(8)), child: DropdownButton<String>(value: current, isExpanded: true, dropdownColor: const Color(0xFF161616), underline: Container(), items: items.map((e) => DropdownMenuItem(value: e, child: Text(e, style: const TextStyle(color: Colors.white, fontSize: 13)))).toList(), onChanged: onChange));
  }

  Widget _buildMultiSelect(List<String> options, List<String> target) {
    return Wrap(spacing: 6, children: options.map((s) => ChoiceChip(label: Text(s, style: TextStyle(color: target.contains(s) ? Colors.white : Colors.white38, fontSize: 10)), selected: target.contains(s), selectedColor: const Color(0xFFF54A00), backgroundColor: Colors.black26, onSelected: (val) => setState(() => val ? target.add(s) : target.remove(s)))).toList());
  }

  Widget _toggle(String label, bool val, Function(bool) fn) {
    return FilterChip(label: Text(label, style: const TextStyle(fontSize: 10, color: Colors.white)), selected: val, selectedColor: const Color(0xFFF54A00), onSelected: fn, showCheckmark: false, backgroundColor: Colors.black26);
  }

  Widget _inputField(TextEditingController c, String h) => TextField(controller: c, style: const TextStyle(color: Colors.white, fontSize: 13), decoration: InputDecoration(hintText: h, filled: true, fillColor: Colors.black26, border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none)));

  Widget _buildResultsList() {
    if (_leads.isEmpty) return const Center(child: Text("No leads found.", style: TextStyle(color: Colors.white10)));
    return Column(children: [
      Container(padding: const EdgeInsets.all(24), alignment: Alignment.centerLeft, child: Text("FOUND ${_leads.length} LEADS", style: const TextStyle(color: Color(0xFFF54A00), fontWeight: FontWeight.bold, fontSize: 12))),
      Expanded(child: ListView.builder(padding: const EdgeInsets.symmetric(horizontal: 24), itemCount: _leads.length, itemBuilder: (c, i) => Container(margin: const EdgeInsets.only(bottom: 12), decoration: BoxDecoration(color: const Color(0xFF161616), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.white10)), child: ListTile(leading: const CircleAvatar(backgroundColor: Color(0xFF222222), child: Icon(Icons.person, color: Colors.white, size: 20)), title: Text(_leads[i].name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)), subtitle: Text(_leads[i].email, style: const TextStyle(color: Color(0xFFF54A00), fontSize: 12)), trailing: IconButton(icon: const Icon(Icons.open_in_new, color: Colors.blue, size: 20), onPressed: () => launchUrl(Uri.parse(_leads[i].linkedin))))))),
    ]);
  }
}

// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:url_launcher/url_launcher.dart';

// void main() => runApp(const MaterialApp(home: LinkedInLeadGen(), debugShowCheckedModeBanner: false));

// class Lead {
//   final String name, email, linkedin, industry;
//   Lead({required this.name, required this.email, required this.linkedin, required this.industry});

//   factory Lead.fromJson(Map<String, dynamic> json) => Lead(
//     name: json['name'] ?? 'Unknown',
//     email: json['email'] ?? 'N/A',
//     linkedin: json['linkedinurl'] ?? '',
//     industry: json['industry'] ?? 'N/A',
//   );
// }

// class LinkedInLeadGen extends StatefulWidget {
//   const LinkedInLeadGen({super.key});
//   @override
//   State<LinkedInLeadGen> createState() => _LinkedInLeadGenState();
// }

// class _LinkedInLeadGenState extends State<LinkedInLeadGen> {
//   // --- CONFIGURATION ---
//   final List<String> _countries = [
//     "United States", "Canada", "United Kingdom", "Australia", "Germany", "France", "India", 
//     "Singapore", "Netherlands", "United Arab Emirates", "Brazil", "Spain", "Italy", "Mexico", 
//     "Japan", "Sweden", "Switzerland", "Norway", "Ireland", "New Zealand", "South Africa", 
//     "Poland", "Belgium", "Denmark", "Israel"
//   ]..sort();

//   final List<String> _companySizes = ["1-10", "11-50", "51-200", "201-500", "501-1000", "1001-5000", "5001-10000", "10001+"];
//   final List<String> _seniorityOptions = ["c_suite", "vp", "director", "manager", "senior", "entry", "owner", "partner"];

//   // --- CONTROLLERS ---
//   final TextEditingController _titleController = TextEditingController();
//   final TextEditingController _keywordController = TextEditingController();
//   final TextEditingController _countController = TextEditingController(text: "10");
  
//   // --- STATE ---
//   List<String> _jobTitles = [];
//   List<String> _companyKeywords = [];
//   List<String> _selectedCompanySizes = [];
//   List<String> _selectedSeniority = [];
//   String _selectedCountry = "United States";
//   bool _hasEmail = true;
//   bool _hasPhone = false;
//   bool _isLoading = false;
//   List<Lead> _leads = [];

//   // --- WEBHOOK EXECUTION ---
//   Future<void> _launchAgent() async {
//     // 1. FORCED SYNC: Capture any un-submitted text in the controllers
//     if (_titleController.text.trim().isNotEmpty) {
//       if (!_jobTitles.contains(_titleController.text.trim())) {
//         _jobTitles.add(_titleController.text.trim());
//       }
//       _titleController.clear();
//     }
//     if (_keywordController.text.trim().isNotEmpty) {
//       if (!_companyKeywords.contains(_keywordController.text.trim())) {
//         _companyKeywords.add(_keywordController.text.trim());
//       }
//       _keywordController.clear();
//     }

//     setState(() => _isLoading = true);
    
//     // 2. BUILD PAYLOAD: Exactly matching your requested JSON format
//     final payload = {
//       "companyKeywordIncludes": _companyKeywords,
//       "companySizeIncludes": _selectedCompanySizes,
//       "personTitleIncludes": _jobTitles,
//       "seniorityIncludes": _selectedSeniority,
//       "personLocationCountryIncludes": [_selectedCountry],
//       "hasEmail": _hasEmail,
//       "hasPhone": _hasPhone,
//       "totalResults": int.tryParse(_countController.text) ?? 10,
//       "dontSaveProgress": false,
//       "resetProgress": false,
//       "includeTitleVariants": false,
//     };

//     try {
//       final response = await http.post(
//         Uri.parse(
//           "https://abuyousufmdjumman.n8nclouds.com/webhook/f9a40868-7359-47ee-bece-dc62d26237d3"
          
//           // "https://abuyousufmdjumman.n8nclouds.com/webhook-test/f9a40868-7359-47ee-bece-dc62d26237d3"
          
//           ),
//         headers: {"Content-Type": "application/json"},
//         body: jsonEncode(payload),
//       );

//       if (response.statusCode == 200) {
//         final List<dynamic> data = jsonDecode(response.body);
//         setState(() => _leads = data.map((e) => Lead.fromJson(e)).toList());
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e"), backgroundColor: Colors.redAccent));
//     } finally {
//       setState(() => _isLoading = false);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Row(children: [
//         // SIDEBAR (380px)
//         Container(
//           width: 380,
//           color: const Color(0xFF0D0D0E),
//           padding: const EdgeInsets.all(24),
//           child: SingleChildScrollView(
//             child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//               const Text("B2B LEAD PRO", style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
//               const SizedBox(height: 30),
              
//               _label("Job Titles (Add multiple)"),
//               _buildListInput(_titleController, _jobTitles, "e.g. CEO, Founder"),
              
//               const SizedBox(height: 20),
//               _label("Company Keywords"),
//               _buildListInput(_keywordController, _companyKeywords, "e.g. SaaS, Marketing"),
              
//               const SizedBox(height: 25),
//               _label("Target Country"),
//               _buildDropdown(_countries, _selectedCountry, (val) => setState(() => _selectedCountry = val!)),
              
//               const SizedBox(height: 25),
//               _label("Company Size"),
//               _buildMultiSelect(_companySizes, _selectedCompanySizes),
              
//               const SizedBox(height: 25),
//               _label("Seniority"),
//               _buildMultiSelect(_seniorityOptions, _selectedSeniority),
              
//               const SizedBox(height: 25),
//               _label("Data Verification"),
//               Row(children: [
//                 _toggle("Verified Email", _hasEmail, (v) => setState(() => _hasEmail = v)),
//                 const SizedBox(width: 10),
//                 _toggle("With Phone", _hasPhone, (v) => setState(() => _hasPhone = v)),
//               ]),
              
//               const SizedBox(height: 20),
//               _label("Fetch Limit"), _inputField(_countController, "10"),
              
//               const SizedBox(height: 40),
//               SizedBox(
//                 width: double.infinity, height: 55,
//                 child: ElevatedButton(
//                   onPressed: _isLoading ? null : _launchAgent,
//                   style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFF54A00), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
//                   child: _isLoading ? const CircularProgressIndicator(color: Colors.white) : const Text("LAUNCH AGENT", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
//                 ),
//               )
//             ]),
//           ),
//         ),
//         // MAIN CONTENT AREA
//         Expanded(child: _buildResultsList()),
//       ]),
//     );
//   }

//   // --- UI HELPER WIDGETS ---

//   Widget _label(String text) => Padding(padding: const EdgeInsets.only(bottom: 8), child: Text(text.toUpperCase(), style: const TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.bold)));

//   Widget _buildListInput(TextEditingController controller, List<String> list, String hint) {
//     return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//       TextField(
//         controller: controller,
//         onSubmitted: (val) { if (val.trim().isNotEmpty) { setState(() => list.add(val.trim())); controller.clear(); } },
//         style: const TextStyle(color: Colors.white, fontSize: 13),
//         decoration: InputDecoration(
//           hintText: hint, 
//           hintStyle: const TextStyle(color: Colors.white12),
//           filled: true, 
//           fillColor: Colors.black26, 
//           suffixIcon: IconButton(icon: const Icon(Icons.add_circle, color: Color(0xFFF54A00)), onPressed: () { if (controller.text.trim().isNotEmpty) { setState(() => list.add(controller.text.trim())); controller.clear(); } }),
//           border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none)
//         ),
//       ),
//       if (list.isNotEmpty) const SizedBox(height: 10),
//       Wrap(spacing: 6, runSpacing: 6, children: list.map((t) => Chip(
//         label: Text(t, style: const TextStyle(fontSize: 10, color: Colors.white)),
//         backgroundColor: const Color(0xFFF54A00).withOpacity(0.2),
//         onDeleted: () => setState(() => list.remove(t)),
//         deleteIconColor: Colors.white54,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
//       )).toList()),
//     ]);
//   }

//   Widget _buildDropdown(List<String> items, String current, Function(String?) onChange) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 12),
//       decoration: BoxDecoration(color: Colors.black26, borderRadius: BorderRadius.circular(8)),
//       child: DropdownButton<String>(
//         value: current, isExpanded: true, dropdownColor: const Color(0xFF161616), underline: Container(),
//         items: items.map((e) => DropdownMenuItem(value: e, child: Text(e, style: const TextStyle(color: Colors.white, fontSize: 13)))).toList(),
//         onChanged: onChange,
//       ),
//     );
//   }

//   Widget _buildMultiSelect(List<String> options, List<String> target) {
//     return Wrap(spacing: 6, runSpacing: 6, children: options.map((s) {
//       bool isSelected = target.contains(s);
//       return ChoiceChip(
//         label: Text(s, style: TextStyle(color: isSelected ? Colors.white : Colors.white38, fontSize: 10)),
//         selected: isSelected, selectedColor: const Color(0xFFF54A00), backgroundColor: Colors.black26,
//         onSelected: (val) => setState(() => val ? target.add(s) : target.remove(s)),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
//       );
//     }).toList());
//   }

//   Widget _toggle(String label, bool val, Function(bool) fn) {
//     return FilterChip(
//       label: Text(label, style: const TextStyle(fontSize: 10, color: Colors.white)),
//       selected: val, selectedColor: const Color(0xFFF54A00), onSelected: fn, showCheckmark: false,
//       backgroundColor: Colors.black26, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
//     );
//   }

//   Widget _inputField(TextEditingController c, String h) => TextField(controller: c, style: const TextStyle(color: Colors.white, fontSize: 13), decoration: InputDecoration(hintText: h, filled: true, fillColor: Colors.black26, border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none)));

//   Widget _buildResultsList() {
//     if (_leads.isEmpty) return const Center(child: Text("Ready to scrape. Enter details and launch.", style: TextStyle(color: Colors.white10)));
//     return Column(children: [
//       Container(padding: const EdgeInsets.all(24), alignment: Alignment.centerLeft, child: Text("FOUND ${_leads.length} LEADS", style: const TextStyle(color: Color(0xFFF54A00), fontWeight: FontWeight.bold, fontSize: 12))),
//       Expanded(
//         child: ListView.builder(
//           padding: const EdgeInsets.symmetric(horizontal: 24),
//           itemCount: _leads.length,
//           itemBuilder: (c, i) => Container(
//             margin: const EdgeInsets.only(bottom: 12),
//             decoration: BoxDecoration(color: const Color(0xFF161616), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.white10)),
//             child: ListTile(
//               leading: const CircleAvatar(backgroundColor: Color(0xFF222222), child: Icon(Icons.person, color: Colors.white, size: 20)),
//               title: Text(_leads[i].name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
//               subtitle: Text(_leads[i].email, style: const TextStyle(color: Color(0xFFF54A00), fontSize: 12)),
//               trailing: IconButton(icon: const Icon(Icons.open_in_new, color: Colors.blue, size: 20), onPressed: () => launchUrl(Uri.parse(_leads[i].linkedin))),
//             ),
//           ),
//         ),
//       ),
//     ]);
//   }
// }