import 'package:flutter/material.dart';

class DepAddDetails extends StatefulWidget {
  const DepAddDetails({super.key});

  @override
  State<DepAddDetails> createState() => _DepAddDetails();
}

class _DepAddDetails extends State<DepAddDetails> {
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
                    "Add New Department Details",
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
                  const TextField(
                    decoration: InputDecoration(
                      filled: true,
                      hintText: "Enter Department Name",
                      focusedBorder: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 50),
                  const TextField(
                    decoration: InputDecoration(
                      filled: true,
                      hintText: "Enter Department Id",
                      focusedBorder: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 50),
                  const TextField(
                    keyboardType: TextInputType.datetime,
                    decoration: InputDecoration(
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
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            children: [
                              Radio(
                                  value: "Yes",
                                  groupValue: groupValue,
                                  onChanged: (value) {
                                    setState(() {
                                      groupValue = value!;
                                    });
                                  }),
                              const Text(
                                "A",
                                style: TextStyle(fontSize: 20),
                              ),
                              Radio(
                                  value: "No",
                                  groupValue: groupValue,
                                  onChanged: (value) {
                                    setState(() {
                                      groupValue = value!;
                                    });
                                  }),
                              const Text(
                                "B",
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 70),
                  FloatingActionButton.extended(
                    heroTag: "Teacher Submit",
                    onPressed: () {},
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
