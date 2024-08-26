import 'package:exam_block/forms/block_add_details.dart';
import 'package:exam_block/forms/dep_add_details.dart';
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
        child: Container(
          height: MediaQuery.of(context).size.height * 1,
          width: MediaQuery.of(context).size.width * 1,
          margin: const EdgeInsets.all(30),
          decoration: const BoxDecoration(color: Colors.grey),
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
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Center(
                        child: Text(
                          "Select Details To Add",
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 70,
              ),
              Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 131, 131, 131),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    const Text(
                      "Add New Teacher Details",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    FloatingActionButton.extended(
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
              ),
              Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 131, 131, 131),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(
                      width: 30,
                    ),
                    const Text(
                      "Add New Block Details",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    FloatingActionButton.extended(
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
              ),
              Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 131, 131, 131),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    const Text(
                      "Add New Department Details",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    FloatingActionButton.extended(
                      focusColor: Colors.white,
                      hoverColor: Colors.white,
                      heroTag: "New Department",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DepAddDetails(),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
