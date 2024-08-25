import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';

class DataBaseMethods {
  Future addEmployeeDetails(Map<String, dynamic> teacherInfo, String id) async {
    return await FirebaseFirestore.instance.collection('teacher').doc(id).set(teacherInfo);
  }

  Future addBlockDetails(Map<String, dynamic> blockInfo, String id) async {
    return await FirebaseFirestore.instance.collection("Block").doc(id).asDocument();
  }
    Future<Stream<QuerySnapshot>> getEmployeeDetails() async {
    return await FirebaseFirestore.instance.collection("teacher").snapshots();
  }
  // Future<void> addEmployeeDetails(
  //     Map<String, dynamic> employeeInfoMap, String id) async {
  //   try {
  //     await FirebaseFirestore.instance
  //         .collection("teacher")
  //         .doc(id)
  //         .set(employeeInfoMap);
  //   } catch (e) {
  //     print("Error adding employee details: $e");
  //     // Handle error appropriately
  //     rethrow; // Optionally, rethrow the error if you want to handle it further up the call stack
  //   }
  // }

  // Future<Stream<QuerySnapshot>> getEmployeeDetails() async {
  //   return FirebaseFirestore.instance.collection("teacher").snapshots();
  // }

  // Future updateEmployeeDetails(
  //     String id, Map<String, dynamic> updateInfo) async {
  //   return await FirebaseFirestore.instance
  //       .collection("teacher")
  //       .doc(id)
  //       .update(updateInfo);
  // }

  // Future deleteEmployeeDetails(String id) async {
  //   return await FirebaseFirestore.instance
  //       .collection("teacher")
  //       .doc(id)
  //       .delete();
  // }
}
