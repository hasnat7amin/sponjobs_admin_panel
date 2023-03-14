import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sponjobsadmin/view/dashboard.dart';
import 'package:sponjobsadmin/view/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
