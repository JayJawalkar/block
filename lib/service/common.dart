import 'package:flutter/material.dart';

List<String> options = [
  'Computer',
  'Electronics and Telecommunication',
  'Information & Technology',
  'Civil',
  'Robotics',
  'Mechanical'
];
final Map<String, String> deptIdMap = {
  'Computer': 'Comp2006',
  'Electronics and Telecommunication': 'E&TC2006',
  'Information & Technology': 'IT2015',
  'Civil': 'Civil2006',
  'Robotics': 'Rob2023',
  'Mechanical': 'Mech2006',
};
List<String> buildingOptions = [
  'Building A',
  'Building B',
];
Map<String, List<String>> floorOptionsMap = {
  'Building A': [
    'Floor 1',
    'Computer',
    'Electronics and Telecommunication',
  ],
  'Building B': [
    'Civil',
    'Robotics',
    'Mechanical',
  ]
};
String? selectedDept;
String? selectedDeptId;
String? selectedBuilding;
String? selectedFloor;
DateTime? selectedDate;
TimeOfDay? selectedTime;
