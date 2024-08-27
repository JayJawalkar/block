import 'package:exam_block/screens/teacher_details_screen.dart';
import 'package:exam_block/service/common.dart';
import 'package:exam_block/service/database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:random_string/random_string.dart';
import 'package:intl/intl.dart';

class TeacherAddDetails extends StatefulWidget {
  const TeacherAddDetails({super.key});

  @override
  State<TeacherAddDetails> createState() => _TeacherAddDetailsState();
}

class _TeacherAddDetailsState extends State<TeacherAddDetails> {
  final _formKey = GlobalKey<FormState>();

  String id =
      "${DateFormat('yyyyMMddHHmmss').format(DateTime.now())}+${randomAlphaNumeric(5)}";

  final TextEditingController nameController = TextEditingController();

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
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(color: Colors.grey),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Add New Teacher Details",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(color: Colors.grey),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        filled: true,
                        hintText: "Enter Teacher Name",
                        focusedBorder: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the teacher\'s name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(8),
                      child: DropdownButton<String>(
                        value: selectedOption,
                        hint: const Text('Select a department'),
                        items: options.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedOption = newValue;
                            selectedDeptId =
                                deptIdMap[selectedOption]; // Auto-select deptId
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Display the auto-selected department ID
                    if (selectedDeptId != null)
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          "Department ID: $selectedDeptId",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),

                    const SizedBox(height: 20),
                    FloatingActionButton.extended(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TeacherDetailsScreen(),
                          ),
                        );
                      },
                      label: const Text("Show"),
                      icon: const Icon(Icons.groups),
                      heroTag: "Garam Hai",
                    ),
                    const SizedBox(height: 20),
                    FloatingActionButton.extended(
                      label: const Text(" Add "),
                      icon: const Icon(Icons.group_add_sharp),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          if (selectedOption == null ||
                              selectedDeptId == null) {
                            Fluttertoast.showToast(
                              msg: "Please select a department",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
                            return;
                          }

                          Map<String, dynamic> employeeInfoMap = {
                            "Name": nameController.text,
                            "Dept": selectedOption,
                            "Id": id,
                            "DeptId": selectedDeptId
                          };

                          await DataBaseMethods()
                              .addEmployeeDetails(employeeInfoMap, id)
                              .then(
                            (value) {
                              Fluttertoast.showToast(
                                msg: "Added",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.green,
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );
                            },
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
