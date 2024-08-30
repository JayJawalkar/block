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

  String groupValue = "Yes";
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
                    controller: crN,
                    decoration: const InputDecoration(
                      filled: true,
                      hintText: "Enter CLassRoom Number",
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
                      value: selectedDept,
                      hint: const Text('Select a department'),
                      items: options.map(
                        (String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        },
                      ).toList(),
                      onChanged: (String? newValue) {
                        setState(
                          () {
                            selectedDept = newValue;
                            selectedDeptId =
                                deptIdMap[selectedDept]; //Auto-select deptId
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 50),
                  TextField(
                    controller: crF,
                    keyboardType: TextInputType.datetime,
                    decoration: const InputDecoration(
                      filled: true,
                      hintText: "Enter Floor",
                      focusedBorder: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 50),
                  Container(
                    margin: const EdgeInsets.all(20),
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(color: Colors.white),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text(
                          "Select Building",
                          style: TextStyle(fontSize: 20),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: DropdownButton<String>(
                            value: selectedDept,
                            hint: const Text('Select a department'),
                            items: options.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedDept = newValue;
                                selectedDeptId = deptIdMap[
                                    selectedDept]; // Auto-select deptId
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 70),
                  FloatingActionButton.extended(
                    heroTag: "Block Submit",
                    onPressed: () async {
                      String id = randomAlphaNumeric(10);
                      Map<String, dynamic> employeeInfoMap = {
                        "ClassNo": crN.text,
                        "Dept": crD.text,
                        "Floor": crF.text,
                        "Id": id,
                      };
                      await DataBaseMethodsBlock()
                          .addBlockDetails(employeeInfoMap, id);
                    },
                    focusElevation: 20,
                    label: const Text("ADD"),
                    hoverElevation: 20,
                    icon: const Icon(Icons.group_add_sharp),
                  ),
                  const SizedBox(
                    height: 50,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}