import 'package:exam_block/screens/exam_details_screen.dart';
import 'package:exam_block/service/common.dart';
import 'package:exam_block/service/database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:random_string/random_string.dart';

class ExamDetails extends StatefulWidget {
  const ExamDetails({super.key});

  @override
  State<ExamDetails> createState() => _ExamDetailsState();
}

class _ExamDetailsState extends State<ExamDetails> {
  String id = randomAlphaNumeric(5);
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController codeController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(50),
          decoration: const BoxDecoration(
            color: Colors.grey,
          ),
          child: Column(
            children: [
              const SizedBox(height: 10),
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
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.grey,
                ),
                child: const Center(
                  child: Text(
                    "Exam Details",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 131, 131, 131),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        filled: true,
                        hintText: "Enter Subject Name",
                        focusedBorder: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 50),
                    TextField(
                      controller: codeController,
                      decoration: const InputDecoration(
                        filled: true,
                        hintText: "Enter Subject Code",
                        focusedBorder: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 50),
                    GestureDetector(
                      onTap: () => _selectDate(context),
                      child: AbsorbPointer(
                        child: TextField(
                          decoration: InputDecoration(
                            filled: true,
                            hintText: selectedDate != null
                                ? "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}"
                                : "Select Date",
                            focusedBorder: const OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    GestureDetector(
                      onTap: () => _selectTime(context),
                      child: AbsorbPointer(
                        child: TextField(
                          decoration: InputDecoration(
                            filled: true,
                            hintText: selectedTime != null
                                ? "${selectedTime!.hour}:${selectedTime!.minute}"
                                : "Select Time",
                            focusedBorder: const OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 70),
                    FloatingActionButton.extended(
                      heroTag: "Button 1",
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          if (selectedDate == null || selectedTime == null) {
                            Fluttertoast.showToast(
                              msg: "Please select date and time",
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
                            "Exam": nameController.text,
                            "SubjectCode": codeController,
                            "Date": selectedDate,
                            "Time": selectedTime,
                            "Id": id,
                          };

                          await DataBaseMethodsExam()
                              .addExamDetails(employeeInfoMap, id)
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
                      focusElevation: 20,
                      label: const Text("ADD"),
                      hoverElevation: 20,
                      icon: const Icon(Icons.login_rounded),
                    ),
                    const SizedBox(height: 20),
                    FloatingActionButton.extended(
                      heroTag: "Show ExamDetails",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ExamDetailsScreen(),
                          ),
                        );
                      },
                      label: const Text("Show"),
                      icon: const Icon(Icons.import_contacts),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
