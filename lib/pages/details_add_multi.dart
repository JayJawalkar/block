import 'dart:math';

import 'package:exam_block/forms/block_add_details.dart';
import 'package:exam_block/forms/teacher_add_details.dart';
import 'package:flutter/material.dart';

class MultiDetailPage extends StatefulWidget {
  const MultiDetailPage({super.key});

  @override
  State<MultiDetailPage> createState() => _MultiDetailPageState();
}

class _MultiDetailPageState extends State<MultiDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context, build(context));
                  },
                  child: const Icon(Icons.arrow_back),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Center(
                      child: Text(
                        "Select Details To Add",
                        style: TextStyle(
                          fontSize:
                              max(70, MediaQuery.of(context).size.width / 1000),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 100,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(
                  width: 20,
                ),
                Text(
                  "Add New Teacher Details",
                  style: TextStyle(
                    fontSize: max(30, MediaQuery.of(context).size.width / 1000),
                  ),
                ),
                FloatingActionButton.extended(
                  backgroundColor: Colors.white,
                  focusColor: Colors.white,
                  hoverColor: Colors.white,
                  heroTag: "New Teacher",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TeacherAddDetails(),
                      ),
                    );
                  },
                  focusElevation: 20,
                  label: const Text("ADD"),
                  hoverElevation: 20,
                  icon: const Icon(Icons.add_chart),
                ),
              ],
            ),
            const SizedBox(height: 100),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(
                  width: 30,
                ),
                Text(
                  "Add New Block Details",
                  style: TextStyle(
                    fontSize: max(30, MediaQuery.of(context).size.width / 1000),
                  ),
                ),
                FloatingActionButton.extended(
                  backgroundColor: Colors.white,
                  focusColor: Colors.white,
                  hoverColor: Colors.white,
                  heroTag: "New Block",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BlockAddDetails(),
                      ),
                    );
                  },
                  focusElevation: 20,
                  label: const Text("ADD"),
                  hoverElevation: 20,
                  icon: const Icon(Icons.add_chart),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
