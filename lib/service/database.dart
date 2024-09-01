// ignore_for_file: await_only_futures

import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseMethods {
  Future addEmployeeDetails(
      Map<String, dynamic> employeeInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("teacher")
        .doc(id)
        .set(employeeInfoMap);
  }

  Future<Stream<QuerySnapshot>> getEmployeeDetails() async {
    return await FirebaseFirestore.instance.collection("teacher").snapshots();
  }

  Future updateEmployeeDetails(
      String id, Map<String, dynamic> updateInfo) async {
    return await FirebaseFirestore.instance
        .collection("teacher")
        .doc(id)
        .update(updateInfo);
  }

  Future deleteEmployeeDetails(String id) async {
    return await FirebaseFirestore.instance
        .collection("teacher")
        .doc(id)
        .delete();
  }
}

class DataBaseMethodsBlock {
  Future addBlockDetails(
      Map<String, dynamic> employeeInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("block")
        .doc(id)
        .set(employeeInfoMap);
  }

  Future<Stream<QuerySnapshot>> getBlockDetails() async {
    return await FirebaseFirestore.instance.collection("block").snapshots();
  }

  Future updateBlockDetails(
      String id, Map<String, dynamic> updateBlockInfo) async {
    return await FirebaseFirestore.instance
        .collection("block")
        .doc(id)
        .update(updateBlockInfo);
  }

  Future deleteBlockDetails(String id) async {
    return await FirebaseFirestore.instance
        .collection("block")
        .doc(id)
        .delete();
  }
}
class DataBaseMethodsExam {
  Future addExamDetails(
      Map<String, dynamic> examInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("exam")
        .doc(id)
        .set(examInfoMap);
  }

  Future<Stream<QuerySnapshot>> getExamDetails() async {
    return await FirebaseFirestore.instance.collection("block").snapshots();
  }

  Future updateExamDetails(
      String id, Map<String, dynamic> updateBlockInfo) async {
    return await FirebaseFirestore.instance
        .collection("exam")
        .doc(id)
        .update(updateBlockInfo);
  }

  Future deleteExamDetails(String id) async {
    return await FirebaseFirestore.instance
        .collection("exam")
        .doc(id)
        .delete();
  }
}
