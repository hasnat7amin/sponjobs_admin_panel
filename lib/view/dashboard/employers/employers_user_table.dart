import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sponjobsadmin/res/colors.dart';
import 'package:sponjobsadmin/view/dashboard/employers/update_employers.dart';

import 'dart:core';

import 'package:sponjobsadmin/view_model/users_vew_model.dart';

import '../../../res/components/flushbar.dart';
import '../../../res/constants/firebase_collections.dart';

class EmployersUserTabel extends StatefulWidget {
  String title;
  EmployersUserTabel({Key? key,required this.title}) : super(key: key);

  @override
  State<EmployersUserTabel> createState() => _EmployersUserTabelState();
}

class _EmployersUserTabelState extends State<EmployersUserTabel> {
  String? _title;
  @override
  void initState() {
    // TODO: implement initState
    _title = widget.title;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final userViewModel = Get.put(UserViewModel());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: orange,
        title: Text(_title!),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.topCenter,
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection(FirebaseCollection.employers).snapshots(),
              builder: (BuildContext context,  snapshot){
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: SizedBox(
                      width: height * 0.048,
                      height: height * 0.048,
                      child: const CircularProgressIndicator(
                        color: Colors.grey,
                      ),
                    ),
                  );
                }
                if (snapshot.hasError) {
                  Get.snackbar("Failed to load data.",
                      "Failed to load data from firebase");
                }
                return DataTable(
                  horizontalMargin: 8,
                  columnSpacing: 18,
                  columns: const [
                    DataColumn(
                        label: Text('Image',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Name',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Phone',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold))),
                    // DataColumn(
                    //   label: Text(
                    //     'Address',
                    //     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    //   ),
                    // ),
                    DataColumn(
                      label: Text(
                        'Actions',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                  rows:  snapshot.data!.docs.map((doc) {
                    return  DataRow(cells: [
                      DataCell(
                        CircleAvatar(
                          radius: 15,
                          backgroundImage: NetworkImage(doc['image'],),
                        ),
                      ),
                      DataCell(Text(doc['name'])),
                      DataCell(Text(doc['phone'])),
                      // DataCell(Text(doc['companyAddress'])),
                      DataCell(
                        Row(
                          children:  [
                            InkWell(
                              onTap: (){
                                debugPrint(doc.id);
                                Get.to(UpdateEmployers(id: doc.id,image: doc["image"],));

                                // userViewModel.deleteUser(FirebaseCollection.employers, doc.id.toString());
                              },
                              child: const CircleAvatar(
                                radius: 15,
                                backgroundColor: orange,
                                child: Padding(
                                  padding: EdgeInsets.all(3),
                                  child: Icon(
                                    Icons.edit,
                                    color: white,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ),
                           const SizedBox(
                              width: 4,
                            ),
                            InkWell(
                              onTap: ()async{
                                debugPrint(doc.id);
                                await FirebaseFirestore.instance.collection(FirebaseCollection.employers).doc(doc.id).update({
                                  "isBanned":!doc["isBanned"]
                                }).then((value){
                                  getFlushBar(context, title: 'Employers ${doc["name"]} is successfully ${!doc["isBanned"]?"banned":"unbanned"}.');
                                }).onError((error, stackTrace) async{
                                  getFlushBar(context,title: error.toString());
                                });
                              },
                              child: const CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors.red,
                                child: Padding(
                                  padding: EdgeInsets.all(3),
                                  child: Icon(
                                   Icons.delete,
                                    color: white,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ]);
                  }).toList(),
                );
              },
            )
          ),
        ),
      ),
    );
  }
}
