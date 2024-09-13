import 'dart:convert';
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:exam_block/pages/details_add_multi.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<List<dynamic>> _csvData = [];

  Future<void> pickCsvFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv'],
    );

    if (result != null) {
      File file = File(result.files.single.path!);

      try {
        // Attempt to read the file as UTF-8
        final input = file.openRead();
        final fields = await input
            .transform(utf8.decoder) // Try reading as UTF-8
            .transform(const CsvToListConverter())
            .toList();

        setState(() {
          _csvData = fields;
        });
      } catch (e) {
        // If UTF-8 decoding fails, try using latin1 decoder (ISO-8859-1)
        if (e is FileSystemException) {
          try {
            final input = file.openRead();
            final fields = await input
                .transform(latin1.decoder) // Try reading as Latin-1
                .transform(const CsvToListConverter())
                .toList();

            setState(() {
              _csvData = fields;
            });
          } catch (e) {
            // Handle error if all decoding attempts fail
            print('Failed to read CSV file: $e');
          }
        } else {
          print('Unknown error: $e');
        }
      }
    } else {
      // User canceled the picker
      print('No file selected');
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(width: 100),
                    const Text(
                      "Add Time Table (.csv)",
                      style: TextStyle(fontSize: 25),
                    ),
                    FloatingActionButton.extended(
                      heroTag: "Button 1",
                      onPressed: () async {
                        await pickCsvFile(); // Call the CSV file picker here
                      },
                      focusElevation: 20,
                      label: const Text("ADD"),
                      hoverElevation: 20,
                      icon: const Icon(Icons.add),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 80),
              _csvData.isNotEmpty
                  ? buildCsvTable()
                  : const Text("No CSV file loaded."),
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

  Widget buildCsvTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: _csvData[0]
            .map<DataColumn>((header) => DataColumn(
                  label: Text(header.toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ))
            .toList(),
        rows: _csvData
            .sublist(1)
            .map<DataRow>((row) => DataRow(
                  cells: row
                      .map<DataCell>(
                        (cell) => DataCell(
                          Text(
                            cell.toString(),
                          ),
                        ),
                      )
                      .toList(),
                ))
            .toList(),
      ),
    );
  }
}
