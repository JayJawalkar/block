// ignore_for_file: use_build_context_synchronously
import 'package:exam_block/pages/details_add_multi.dart';
import 'package:exam_block/screens/filepicker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Center(
                child: Text(
                  "Home",
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 80),
              _buildAddDetailsSection(),
              const SizedBox(height: 40),
              _buildAddJsonSection(),
              const SizedBox(height: 40),
              _buildLogoutButton(),
              const SizedBox(height: 40),
              _buildAllocateButton()
            ],
          ),
        ),
      ),
    );
  }

  // Widget to display the JSON data in a table format

  // Widget to build the "Add Teacher and Block Details" section
  Widget _buildAddDetailsSection() {
    return SizedBox(
      width: double.maxFinite,
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(width: 20),
          Text(
            "Add Teacher and Block Details ",
            style: TextStyle(
              fontSize: 12.spMax,
            ),
          ),
          FloatingActionButton.extended(
            hoverElevation: 20,
            focusElevation: 20,
            backgroundColor: Colors.white,
            focusColor: Colors.white,
            hoverColor: Colors.white,
            heroTag: "Button 2",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MultiDetailPage(),
                ),
              );
            },
            label: Text(
              "ADD",
              style: TextStyle(
                fontSize: 6.sp,
              ),
            ),
            icon: Icon(
              Icons.add,
              size: 9.sp,
            ),
          ),
        ],
      ),
    );
  }

  // Widget to build the "Add Time Table .json" section
  Widget _buildAddJsonSection() {
    return SizedBox(
      width: double.maxFinite,
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(width: 20),
          Text(
            "Add Time Table .json ",
            style: TextStyle(
              fontSize: 12.spMax,
            ),
          ),
          FloatingActionButton.extended(
            hoverElevation: 20,
            focusElevation: 20,
            backgroundColor: Colors.white,
            focusColor: Colors.white,
            hoverColor: Colors.white,
            heroTag: "Button 1",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FilePicker1(),
                ),
              );
            }, // Trigger JSON picker
            label: Text(
              "ADD",
              style: TextStyle(fontSize: 6.sp),
            ),
            icon: Icon(
              Icons.add,
              size: 9.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogoutButton() {
    return FloatingActionButton.extended(
      hoverElevation: 20,
      focusElevation: 20,
      backgroundColor: Colors.white,
      focusColor: Colors.white,
      hoverColor: Colors.white,
      heroTag: "LOGOUT",
      onPressed: () {
        Navigator.pop(context);
      },
      label: Text(
        "LOGOUT",
        style: TextStyle(fontSize: 6.sp),
      ),
      icon: Icon(
        Icons.add_chart,
        size: 9.sp,
      ),
    );
  }

  Widget _buildAllocateButton() {
    return FloatingActionButton.extended(
      hoverElevation: 20,
      focusElevation: 20,
      backgroundColor: Colors.white,
      focusColor: Colors.white,
      hoverColor: Colors.white,
      heroTag: "Allocate",
      onPressed: () {},
      label: Text(
        "Allocate",
        style: TextStyle(fontSize: 6.sp),
      ),
      icon: Icon(
        Icons.add_chart,
        size: 9.sp,
      ),
    );
  }
}
