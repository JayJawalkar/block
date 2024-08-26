import 'package:exam_block/screens/teacher_details_screen.dart';
import 'package:exam_block/service/database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:random_string/random_string.dart';

class TeacherAddDetails extends StatefulWidget {
  const TeacherAddDetails({super.key});

  @override
  State<TeacherAddDetails> createState() => _TeacherAddDetailsState();
}

class _TeacherAddDetailsState extends State<TeacherAddDetails> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController deptController = TextEditingController();
  final TextEditingController deptIdController = TextEditingController();

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
                    TextFormField(
                      controller: deptController,
                      decoration: const InputDecoration(
                        filled: true,
                        hintText: "Enter Department Name",
                        focusedBorder: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the department name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: deptIdController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        filled: true,
                        hintText: "Enter Department Id",
                        focusedBorder: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the department ID';
                        }
                        return null;
                      },
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
                        String id = randomAlphaNumeric(10);
                        Map<String, dynamic> employeeInfoMap = {
                          "Name": nameController.text,
                          "Dept": deptController.text,
                          "Id": id,
                          "DeptId": deptIdController.text
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
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          },
                        );
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
