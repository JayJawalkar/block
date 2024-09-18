// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:math';
import 'package:exam_block/pages/details_add_multi.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/gestures.dart';
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

    if (result != null && result.files.single.bytes != null) {
      String content = String.fromCharCodes(result.files.single.bytes!);

      try {
        List<dynamic> parsedJson = json.decode(content);

        // Filter out null entries and handle potential missing keys
        setState(() {
          _jsonData = parsedJson
              .where((item) => item != null)
              .map((item) => (item as Map<String, dynamic>))
              .toList();
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error parsing JSON: $e")),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("No file selected or file is empty"),
        ),
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
              Center(
                child: Text(
                  "Home Page",
                  style: TextStyle(
                    fontSize: max(70, MediaQuery.of(context).size.width / 1000),
                  ),
                ),
              ),
              const SizedBox(height: 80),
              _buildAddDetailsSection(),
              const SizedBox(height: 40),
              _buildAddJsonSection(),
              const SizedBox(height: 40),
              if (_jsonData.isNotEmpty) _buildDataTable(), // Show the table
              const SizedBox(height: 40),
              _buildLogoutButton(),
              const SizedBox(height: 40),
              _buildAllocateButton()
            ],
          ),
        ),
      ),
    );
  }

  // Widget to display the JSON data in a table format
  Widget _buildDataTable() {
    if (_jsonData.isEmpty) return const SizedBox.shrink();

    // Get all unique columns from the JSON data
    Set<String> columns = {};
    for (var data in _jsonData) {
      columns.addAll(data.keys);
    }

    // Sort columns to have a consistent order (optional)
    List<String> sortedColumns = columns.toList()..sort();

    return Column(
      children: [
        SingleChildScrollView(
          dragStartBehavior: DragStartBehavior.start,
          padding: const EdgeInsets.all(15),
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: sortedColumns
                .map(
                  (key) => DataColumn(
                    label: Text(key),
                  ),
                )
                .toList(),
            rows: _jsonData.map((data) {
              return DataRow(
                cells: sortedColumns.map((key) {
                  return DataCell(
                    Text(data[key]?.toString() ?? ''),
                  );
                }).toList(),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  // Widget to build the "Add Teacher and Block Details" section
  Widget _buildAddDetailsSection() {
    return SizedBox(
      width: double.maxFinite,
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(width: 20),
          Text(
            "Add Teacher and Block Details",
            style: TextStyle(
              fontSize: max(35, MediaQuery.of(context).size.width / 1000),
            ),
          ),
          const SizedBox(width: 20),
          FloatingActionButton.extended(
            hoverElevation: 20,
            focusElevation: 20,
            backgroundColor: Colors.white,
            focusColor: Colors.white,
            hoverColor: Colors.white,
            heroTag: "Button 2",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MultiDetailPage(),
                ),
              );
            },
            label: const Text("ADD"),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }

  // Widget to build the "Add Time Table .json" section
  Widget _buildAddJsonSection() {
    return SizedBox(
      width: double.maxFinite,
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(width: 20),
          Text(
            "Add Time Table .json",
            style: TextStyle(
              fontSize: max(35, MediaQuery.of(context).size.width / 1000),
            ),
          ),
          const SizedBox(width: 20),
          FloatingActionButton.extended(
            hoverElevation: 20,
            focusElevation: 20,
            backgroundColor: Colors.white,
            focusColor: Colors.white,
            hoverColor: Colors.white,
            heroTag: "Button 1",
            onPressed: _pickAndReadJson, // Trigger JSON picker
            label: const Text("ADD"),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }

  // Widget to build the Logout button
  Widget _buildLogoutButton() {
    return FloatingActionButton.extended(
      hoverElevation: 20,
      focusElevation: 20,
      backgroundColor: Colors.white,
      focusColor: Colors.white,
      hoverColor: Colors.white,
      heroTag: "LOGOUT",
      onPressed: () {
        Navigator.pop(context);
      },
      label: const Text("LOGOUT"),
      icon: const Icon(Icons.add_chart),
    );
  }

  Widget _buildAllocateButton() {
    return FloatingActionButton.extended(
      hoverElevation: 20,
      focusElevation: 20,
      backgroundColor: Colors.white,
      focusColor: Colors.white,
      hoverColor: Colors.white,
      heroTag: "Allocate",
      onPressed: () {},
      label: const Text("Allocate"),
      icon: const Icon(Icons.add_chart),
    );
  }
}
