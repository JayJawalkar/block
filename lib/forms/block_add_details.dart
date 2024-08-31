import 'package:exam_block/screens/block_details_screen.dart';
import 'package:exam_block/service/common.dart';
import 'package:exam_block/service/database.dart';
import 'package:flutter/material.dart';
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.arrow_back),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(color: Colors.grey),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Add New Block Details",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(color: Colors.grey),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  TextField(
                    keyboardType: const TextInputType.numberWithOptions(),
                    controller: crN,
                    decoration: const InputDecoration(
                      filled: true,
                      hintText: "Enter Classroom Number",
                      focusedBorder: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 50),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: DropdownButton<String>(
                      value: selectedBuilding,
                      hint: const Text('Select a Building'),
                      items: buildingOptions.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedBuilding = newValue;
                          selectedFloor =
                              null; 
                        });
                      },
                    ),
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
                        hint: const Text('Select a Floor'),
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
                    focusElevation: 20,
                    label: const Text("ADD"),
                    hoverElevation: 20,
                    icon: const Icon(Icons.group_add_sharp),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FloatingActionButton.extended(
                    heroTag: "Block Navigate",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BlockDetailsScreen(),
                        ),
                      );
                    },
                    label: const Text("Show"),
                    icon: const Icon(Icons.group_add_sharp),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
