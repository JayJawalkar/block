import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam_block/service/database.dart';
import 'package:flutter/material.dart';

class TeacherDetailsScreen extends StatefulWidget {
  const TeacherDetailsScreen({super.key});

  @override
  State<TeacherDetailsScreen> createState() => _TeacherDetailsScreenState();
}

class _TeacherDetailsScreenState extends State<TeacherDetailsScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController agecontroller = TextEditingController();
  TextEditingController addresscontroller = TextEditingController();
  Stream? EmployeeStream;

  getOntheLoad() async {
    EmployeeStream = await DataBaseMethods().getEmployeeDetails();
    setState(() {});
  }

  @override
  void initState() {
    getOntheLoad();
    super.initState();
  }

  Widget allEmployeeDetails() {
    return StreamBuilder(
        stream: EmployeeStream,
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
                                  // mainAxisAlignment:
                                  //     MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      // ignore: prefer_interpolation_to_compose_strings
                                      "Name :" + ds['Name'],
                                      style: const TextStyle(
                                        color: Colors.orange,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                    const Spacer(),
                                    GestureDetector(
                                      onTap: () {
                                        nameController.text = ds["Name"];
                                        agecontroller.text = ds["Dept"];
                                        addresscontroller.text = ds["DeptId"];
                                        EditEmployeeDetails(ds["Id"]);
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
                                        DataBaseMethods()
                                            .deleteEmployeeDetails(ds["Id"]);
                                      },
                                      child: const Icon(Icons.delete,
                                          color: Colors.orange),
                                    ),
                                  ],
                                ),
                                Text(
                                  // ignore: prefer_interpolation_to_compose_strings
                                  "Age : " + ds['Age'],
                                  style: const TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  // ignore: prefer_interpolation_to_compose_strings
                                  "Address : " + ds['Address'],
                                  style: const TextStyle(
                                    color: Colors.orange,
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
                'Teacher',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              ),
              Text(
                'Details',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
        child: Column(
          children: [
            Expanded(child: allEmployeeDetails()),
          ],
        ),
      ),
    );
  }

  Future EditEmployeeDetails(String id) => showDialog(
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
                          color: Colors.blue),
                    ),
                    const Text(
                      'Details',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                const Text(
                  'Name',
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
                      borderRadius: BorderRadius.circular(10)),
                  child: TextField(
                    controller: nameController,
                    decoration: const InputDecoration(border: InputBorder.none),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Age',
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
                      borderRadius: BorderRadius.circular(10)),
                  child: TextField(
                    controller: agecontroller,
                    decoration: const InputDecoration(border: InputBorder.none),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Address',
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
                      borderRadius: BorderRadius.circular(10)),
                  child: TextField(
                    controller: addresscontroller,
                    decoration: const InputDecoration(border: InputBorder.none),
                  ),
                ),
                const SizedBox(height: 30.0),
                Center(
                  child: ElevatedButton(
                      onPressed: () async {
                        Map<String, dynamic> updateInfo = {
                          "Name": nameController.text,
                          "Age": agecontroller.text,
                          "Id": id,
                          "Address": addresscontroller.text
                        };
                        await DataBaseMethods()
                            .updateEmployeeDetails(id, updateInfo)
                            .then((value) {
                          Navigator.pop(context);
                        });
                      },
                      child: const Text("Update")),
                ),
              ],
            ),
          ),
        ),
      );
}
