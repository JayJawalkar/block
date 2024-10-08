import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam_block/service/common.dart';
import 'package:exam_block/service/database.dart';
import 'package:flutter/material.dart';

class BlockDetailsScreen extends StatefulWidget {
  const BlockDetailsScreen({super.key});

  @override
  State<BlockDetailsScreen> createState() => _BlockDetailsScreenState();
}

class _BlockDetailsScreenState extends State<BlockDetailsScreen> {
  TextEditingController nameController = TextEditingController();
  Stream? BlockStream;

  getOntheLoad() async {
    BlockStream = await DataBaseMethodsBlock().getBlockDetails();
    setState(() {});
  }

  @override
  void initState() {
    getOntheLoad();
    super.initState();
  }

  Widget allBlockDetails() {
    return StreamBuilder(
        stream: BlockStream,
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
                                  children: [
                                    Text(
                                      // ignore: prefer_interpolation_to_compose_strings
                                      "ClassNo :" + ds['ClassNo'],
                                      style: const TextStyle(
                                        color: Colors.orange,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                    const Spacer(),
                                    GestureDetector(
                                      onTap: () {
                                        nameController.text = ds["ClassNo"];
                                        selectedBuilding = ds["Building"];
                                        selectedFloor = ds["Floor"];
                                        EditBlockDetails(ds["Id"]);
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
                                        DataBaseMethodsBlock()
                                            .deleteBlockDetails(ds["Id"]);
                                      },
                                      child: const Icon(Icons.delete,
                                          color: Colors.orange),
                                    ),
                                  ],
                                ),
                                Text(
                                  // ignore: prefer_interpolation_to_compose_strings
                                  "Building : " + ds['Building'],
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  // ignore: prefer_interpolation_to_compose_strings
                                  "Floor : " + ds['Floor'],
                                  style: const TextStyle(
                                    color: Colors.grey,
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
                'Block',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              Text(
                'Details',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
        child: Column(
          children: [
            Expanded(child: allBlockDetails()),
          ],
        ),
      ),
    );
  }

  Future EditBlockDetails(String id) => showDialog(
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
                          color: Colors.black),
                    ),
                    const Text(
                      'Details',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                const Text(
                  'Class Room Number',
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
                  'Building',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: DropdownButton<String>(
                    value: selectedFloor,
                    hint: const Text('Select a Floor'),
                    items:
                        floorOptionsMap[selectedBuilding]!.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedFloor = newValue;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 20),
                const SizedBox(height: 30.0),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      Map<String, dynamic> updateBlockInfo = {
                        "ClassNo": nameController.text,
                        "Building": selectedBuilding,
                        "Floor": selectedFloor,
                        "Id": id,
                      };
                      await DataBaseMethods()
                          .updateEmployeeDetails(id, updateBlockInfo)
                          .then((value) {
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context);
                      });
                    },
                    child: const Text("Update"),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
