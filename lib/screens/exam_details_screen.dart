import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam_block/service/common.dart';
import 'package:exam_block/service/database.dart';
import 'package:flutter/material.dart';

class ExamDetailsScreen extends StatefulWidget {
  const ExamDetailsScreen({super.key});

  @override
  State<ExamDetailsScreen> createState() => _ExamDetailsScreenState();
}

class _ExamDetailsScreenState extends State<ExamDetailsScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController codeController = TextEditingController();

  Stream? ExamStream;

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

  getOntheLoad() async {
    ExamStream = await DataBaseMethodsBlock().getBlockDetails();
    setState(() {});
  }

  @override
  void initState() {
    getOntheLoad();
    super.initState();
  }

  Widget allExamDetails() {
    return StreamBuilder(
        stream: ExamStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 20.0),
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Container(
                            margin: const EdgeInsets.only(
                                left: 20, top: 10, bottom: 10, right: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      // ignore: prefer_interpolation_to_compose_strings
                                      "Exam :" + ds['Exam'],
                                      style: const TextStyle(
                                        color: Colors.orange,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                    const Spacer(),
                                    GestureDetector(
                                      onTap: () {
                                        nameController.text = ds["Exam"];
                                        codeController.text = ds["SubjectCode"];
                                        selectedDate = ds["Date"];
                                        selectedTime = ds["Time"];
                                        EditExamDetails(ds["Id"]);
                                      },
                                      child: const Icon(
                                        Icons.edit,
                                        color: Colors.blue,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 7,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        DataBaseMethodsExam()
                                            .deleteExamDetails(ds["Id"]);
                                      },
                                      child: const Icon(Icons.delete,
                                          color: Colors.orange),
                                    ),
                                  ],
                                ),
                                Text(
                                  // ignore: prefer_interpolation_to_compose_strings
                                  "Subject Code : " + ds['SubjectCode'],
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  // ignore: prefer_interpolation_to_compose_strings
                                  "Date : " + ds['Date'],
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  // ignore: prefer_interpolation_to_compose_strings
                                  "Time : " + ds['Time'],
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  })
              : Container();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          margin: const EdgeInsets.only(top: 12),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Exam',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              Text(
                'Details',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
        child: Column(
          children: [
            Expanded(child: allExamDetails()),
          ],
        ),
      ),
    );
  }

  Future EditExamDetails(String id) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Container(
            margin: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.cancel),
                    ),
                    const SizedBox(width: 50.0),
                    const Text(
                      'Edit',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    const Text(
                      'Details',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                const Text(
                  'Exam',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 5, top: 2),
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: nameController,
                    decoration: const InputDecoration(border: InputBorder.none),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: codeController,
                  decoration: const InputDecoration(
                    filled: true,
                    hintText: "Enter Subject Code",
                    focusedBorder: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
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
                const SizedBox(height: 30.0),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      Map<String, dynamic> updateBlockInfo = {
                        "Exam": nameController.text,
                        "SubjectCode": codeController.text,
                        "Date": selectedDate,
                        "Time": selectedTime,
                        "Id": id,
                      };
                      await DataBaseMethodsExam()
                          .updateExamDetails(id, updateBlockInfo)
                          .then((value) {
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context);
                      });
                    },
                    child: const Text("Update"),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
