import 'package:flutter/material.dart';

class ExamDetails extends StatefulWidget {
  const ExamDetails({super.key});

  @override
  State<ExamDetails> createState() => _ExamDetailsState();
}

class _ExamDetailsState extends State<ExamDetails> {
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
                    const TextField(
                      decoration: InputDecoration(
                        filled: true,
                        hintText: "Enter Subject Name",
                        focusedBorder: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 50),
                    const TextField(
                      decoration: InputDecoration(
                        filled: true,
                        hintText: "Enter Subject Code",
                        focusedBorder: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 50),
                    const TextField(
                      keyboardType: TextInputType.datetime,
                      decoration: InputDecoration(
                        filled: true,
                        hintText: "Enter Date",
                        focusedBorder: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 50),
                    const TextField(
                      decoration: InputDecoration(
                        filled: true,
                        hintText: "Enter Time",
                        focusedBorder: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 70),
                    FloatingActionButton.extended(
                      heroTag: "Button 1",
                      onPressed: () {},
                      focusElevation: 20,
                      label: const Text("ADD"),
                      hoverElevation: 20,
                      icon: const Icon(Icons.login_rounded),
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
