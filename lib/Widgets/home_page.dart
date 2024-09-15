import 'dart:convert';
import 'package:exam_block/pages/details_add_multi.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> _jsonData = [];

  // Function to pick and parse JSON file
  Future<void> _pickAndReadJson() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['json'],
    );

    // Check if the user has picked a file
    if (result != null && result.files.single.bytes != null) {
      String content = String.fromCharCodes(result.files.single.bytes!);

      // Ensure valid JSON format and handle null values in data
      try {
        List<dynamic> parsedJson = json.decode(content);

        // Check if each parsed item is a map, and handle nulls
        setState(() {
          _jsonData = parsedJson.map((item) {
            return (item as Map<String, dynamic>).map((key, value) {
              return MapEntry(key,
                  value ?? ''); // Replace null with empty string or fallback
            });
          }).toList();
        });
      } catch (e) {
        // Handle any error that may occur during parsing
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error parsing JSON: $e")),
        );
      }
    } else {
      // Handle case where no file is picked
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No file selected or file is empty")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  "Home Page",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 80),
              Container(
                width: double.maxFinite,
                height: 100,
                decoration: const BoxDecoration(color: Colors.grey),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(width: 20),
                    const Text(
                      "Add Teacher and Block Details",
                      style: TextStyle(fontSize: 25),
                    ),
                    const SizedBox(width: 20),
                    FloatingActionButton.extended(
                      heroTag: "Button 2",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MultiDetailPage(),
                          ),
                        );
                      },
                      focusElevation: 20,
                      label: const Text("ADD"),
                      hoverElevation: 20,
                      icon: const Icon(Icons.add),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Container(
                width: double.maxFinite,
                height: 100,
                decoration: const BoxDecoration(color: Colors.grey),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(width: 20),
                    const Text(
                      "Add Time Table .json",
                      style: TextStyle(fontSize: 25),
                    ),
                    const SizedBox(width: 20),
                    FloatingActionButton.extended(
                      heroTag: "Button 1",
                      onPressed: _pickAndReadJson, // Trigger JSON picker
                      focusElevation: 20,
                      label: const Text("ADD"),
                      hoverElevation: 20,
                      icon: const Icon(Icons.add),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              if (_jsonData.isNotEmpty) _buildDataTable(), // Show the table
              const SizedBox(height: 80),
              const SizedBox(height: 50),
              FloatingActionButton.extended(
                focusColor: Colors.white,
                hoverColor: Colors.white,
                heroTag: "LOGOUT",
                onPressed: () {
                  Navigator.pop(context);
                },
                focusElevation: 20,
                label: const Text("LOGOUT"),
                hoverElevation: 20,
                icon: const Icon(Icons.add_chart),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget to display the JSON data in table format
  Widget _buildDataTable() {
    if (_jsonData.isEmpty) return const SizedBox.shrink();

    // Assuming all objects in the JSON list have the same keys
    List<String> columns = _jsonData.first.keys.toList();

    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: columns
                .map(
                  (key) => DataColumn(
                    label: Text(key),
                  ),
                )
                .toList(),
            rows: _jsonData.map((data) {
              return DataRow(
                cells: columns
                    .map(
                      (key) => DataCell(
                        Text(data[key]?.toString() ?? ''),
                      ),
                    )
                    .toList(),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
