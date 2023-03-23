import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sponjobsadmin/res/colors.dart';
import 'package:sponjobsadmin/res/constants/firebase_collections.dart';
import 'package:sponjobsadmin/view/dashboard/employee/employee_user_table.dart';
import 'package:sponjobsadmin/view/dashboard/employers/employers_user_table.dart';
import 'package:sponjobsadmin/view_model/users_vew_model.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final userViewModel = Get.put(UserViewModel());
  final employee_snapshot =
      FirebaseFirestore.instance.collection("employee").snapshots();
  final employers_snapshot =
      FirebaseFirestore.instance.collection("employers").snapshots();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: orange,
        title: Text("Admin Dashboard"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 2,
          children: [
            StreamBuilder(
              stream: FirebaseFirestore.instance.collection(FirebaseCollection.employee).snapshots(),
              builder: (BuildContext context, snapshot) {
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
                return dashboardCard(() {
                  debugPrint(snapshot.data?.docs.toList().toString());
                  Get.to(() => EmployeeUserTable(
                        title: "Employee",
                        // data: snapshot,
                      ));
                }, "Employee", "Total Employee: ${snapshot.data?.docs.length}",
                    height);
              },
            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance.collection(FirebaseCollection.employers).snapshots(),
              builder: (BuildContext context,snapshot) {
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
                return dashboardCard(() {
                  debugPrint(snapshot.data?.docs.toString());
                  Get.to(() => EmployersUserTabel(title: "Employers"));
                }, "Employers",
                    "Total Employers: ${snapshot.data?.docs.length}", height);
              },
            ),
            //  dashboardCard(() {
            //   debugPrint("clicked functin");
            //   Get.to(() =>UserTable(
            //     title: "Employer",
            //     data: userViewModel.employers,
            //   ));
            // }, "Employer", "Total Employers: ${employers.length}", height),
            //  dashboardCard(() {
            //    Get.to(() =>UserTable(
            //      title: "Employee",
            //      data: userViewModel.employee,
            //    ));
            //  }, "Employee", "Total Employee: ${employee.length}", height),
            // dashboardCard(() {
            //   Get.to(UserTable(
            //     title: "Blocked Employer",
            //   ));
            // }, "Block Employer", "Total Block Employer: 123", height),
            // dashboardCard(() {
            //   Get.to(UserTable(
            //     title: "Blocked Employee",
            //   ));
            // }, "Block Employee", "Total Block Employee: 123", height),
            // dashboardCard(() {
            //   Get.to(UserTable(
            //     title: "Active Employer",
            //   ));
            // }, "Active Employer", "Total Active Employer: 123", height),
            // dashboardCard(() {
            //   Get.to(UserTable(
            //     title: "Active Employee",
            //   ));
            // }, "Active Employee", "Total Active Employee: 123", height),
          ],
        ),
      ),
    );
  }
}

Widget dashboardCard(
    VoidCallback func, String title, String desc, double height) {
  return GestureDetector(
    onTap: () {
      debugPrint("clicked");
      func();
    },
    child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200]?.withOpacity(0.4),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SizedBox(
                  height: height * 0.012,
                ),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(desc),
                    SizedBox(
                      height: height * 0.012,
                    ),
                  ],
                ),
              ],
            ),
          ],
        )),
  );
}
