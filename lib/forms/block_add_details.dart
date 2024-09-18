import 'dart:math';

import 'package:exam_block/screens/block_details_screen.dart';
import 'package:exam_block/service/common.dart';
import 'package:exam_block/service/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:random_string/random_string.dart';

class BlockAddDetails extends StatefulWidget {
  const BlockAddDetails({super.key});

  @override
  State<BlockAddDetails> createState() => _BlockAddDetailsState();
}

class _BlockAddDetailsState extends State<BlockAddDetails> {
  TextEditingController crN = TextEditingController();
  TextEditingController crD = TextEditingController();
  TextEditingController crF = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Add New Block Details",
                  style: TextStyle(fontSize: 16.sp),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    keyboardType: const TextInputType.numberWithOptions(),
                    controller: crN,
                    decoration: const InputDecoration(
                      filled: true,
                      hintText: "Enter Classroom Number",
                      focusedBorder: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                DropdownButton<String>(
                  value: selectedBuilding,
                  hint: const Text(
                    'Select a Building',
                  ),
                  items: buildingOptions.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedBuilding = newValue;
                      selectedFloor = null;
                    });
                  },
                ),
                const SizedBox(height: 20),
                if (selectedBuilding != null)
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: DropdownButton<String>(
                      value: selectedFloor,
                      hint: const Text(
                        'Select a Floor',
                      ),
                      items: floorOptionsMap[selectedBuilding]!
                          .map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedFloor = newValue;
                        });
                      },
                    ),
                  ),
                const SizedBox(height: 20),
                FloatingActionButton.extended(
                  hoverElevation: 20,
                  focusElevation: 20,
                  backgroundColor: Colors.white,
                  focusColor: Colors.white,
                  hoverColor: Colors.white,
                  heroTag: "Block Submit",
                  onPressed: () async {
                    String id = randomAlphaNumeric(10);
                    Map<String, dynamic> blockInfoMap = {
                      "ClassNo": crN.text,
                      "Building": selectedBuilding,
                      "Floor": selectedFloor,
                      "Id": id,
                    };
                    await DataBaseMethodsBlock()
                        .addBlockDetails(blockInfoMap, id);
                  },
                  label: Text(
                    "ADD",
                    style: TextStyle(fontSize: 6.sp),
                  ),
                  icon: Icon(Icons.group_add_sharp, size: 9.sp),
                ),
                SizedBox(
                  height: 20.sp,
                ),
                FloatingActionButton.extended(
                  hoverElevation: 20,
                  focusElevation: 20,
                  backgroundColor: Colors.white,
                  focusColor: Colors.white,
                  hoverColor: Colors.white,
                  heroTag: "Block Navigate",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BlockDetailsScreen(),
                      ),
                    );
                  },
                  label: Text(
                    "SHOW",
                    style: TextStyle(fontSize: 6.sp),
                  ),
                  icon: Icon(
                    Icons.group_add_sharp,
                    size: 9.sp,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
