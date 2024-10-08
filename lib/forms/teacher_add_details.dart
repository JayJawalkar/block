import 'package:exam_block/screens/teacher_details_screen.dart';
import 'package:exam_block/service/common.dart';
import 'package:exam_block/service/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      "${DateFormat('yyyyMMdd').format(DateTime.now())}+${randomAlphaNumeric(5)}";

  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Add New Teacher Details",
                    style: TextStyle(fontSize: 16.sp),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.all(16.sp),
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          fillColor: Colors.white,
                          hoverColor: Colors.white,
                          filled: true,
                          hintText: "Enter Teacher Name",
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the teacher\'s name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20.sp),

                      Container(
                        margin: EdgeInsets.all(16.sp),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: DropdownButton<String>(
                          value: selectedDept,
                          hint: Text(
                            'Select a department',
                            style: TextStyle(fontSize: 10.sp),
                          ),
                          items: options.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedDept = newValue;
                              selectedDeptId =
                                  deptIdMap[selectedDept]; // Auto-select deptId
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 8.sp),

                      // Display the auto-selected department ID
                      if (selectedDeptId != null)
                        Container(
                          margin: EdgeInsets.all(8.sp),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            "Department ID: $selectedDeptId",
                            style: TextStyle(
                                fontSize: 12.sp, fontWeight: FontWeight.bold),
                          ),
                        ),

                      const SizedBox(height: 20),

                      FloatingActionButton.extended(
                        backgroundColor: Colors.white,
                        focusColor: Colors.white,
                        hoverColor: Colors.white,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const TeacherDetailsScreen(),
                            ),
                          );
                        },
                        label: const Text("Show"),
                        icon: const Icon(Icons.groups),
                        heroTag: "Garam Hai",
                      ),
                      const SizedBox(height: 20),
                      FloatingActionButton.extended(
                        backgroundColor: Colors.white,
                        focusColor: Colors.white,
                        hoverColor: Colors.white,
                        label: const Text(
                          " Add ",
                        ),
                        icon: const Icon(Icons.group_add_sharp),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            if (selectedDept == null ||
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
                              "Dept": selectedDept,
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
      ),
    );
  }
}
