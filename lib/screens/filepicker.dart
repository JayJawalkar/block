// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class FilePicker1 extends StatefulWidget {
  const FilePicker1({super.key});

  @override
  _FilePicker1State createState() => _FilePicker1State();
}

class _FilePicker1State extends State<FilePicker1> {
  String? jsonContent;

  Future<void> pickFile() async {
    // Pick a JSON file from the local system
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['json'],
    );

    if (result != null) {
      // Get the selected file
      File file = File(result.files.single.path!);

      // Read the file as string
      String fileContent = await file.readAsString();

      // Parse the JSON content
      setState(() {
        jsonContent = jsonDecode(fileContent).toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick and Read JSON File'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: pickFile,
                  child: const Text('Pick JSON File'),
                ),
                const SizedBox(height: 20),
                jsonContent != null
                    ? Text('File Content: $jsonContent')
                    : const Text('No file selected'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
