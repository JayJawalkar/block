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

  Future<Stream<QuerySnapshot>> getEmployeeDetails() async {
    return await FirebaseFirestore.instance.collection("block").snapshots();
  }

  Future updateEmployeeDetails(
      String id, Map<String, dynamic> updateInfo) async {
    return await FirebaseFirestore.instance
        .collection("block")
        .doc(id)
        .update(updateInfo);
  }

  Future deleteEmployeeDetails(String id) async {
    return await FirebaseFirestore.instance
        .collection("block")
        .doc(id)
        .delete();
  }
}
