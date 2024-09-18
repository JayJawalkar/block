import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:exam_block/forms/block_add_details.dart';
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
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Center(
                      child: Text(
                        "Select Details To Add",
                        style: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 100,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(
                  width: 20,
                ),
                Text(
                  "Add New Teacher Details",
                  style: TextStyle(fontSize: 12.sp),
                ),
                FloatingActionButton.extended(
                  backgroundColor: Colors.white,
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
                  label: Text(
                    "ADD",
                    style: TextStyle(fontSize: 6.sp),
                  ),
                  hoverElevation: 20,
                  icon: Icon(Icons.add_chart, size: 9.sp),
                ),
              ],
            ),
            const SizedBox(height: 100),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(
                  width: 30,
                ),
                Text(
                  "Add New Block Details",
                  style: TextStyle(fontSize: 12.sp),
                ),
                FloatingActionButton.extended(
                  backgroundColor: Colors.white,
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
                  label: Text(
                    "ADD",
                    style: TextStyle(fontSize: 6.sp),
                  ),
                  hoverElevation: 20,
                  icon: Icon(
                    Icons.add_chart,
                    size: 9.sp,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
