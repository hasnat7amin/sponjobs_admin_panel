import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sponjobsadmin/res/colors.dart';
import 'package:sponjobsadmin/view/dashboard.dart';
import 'package:sponjobsadmin/view/dashboard/employee/employee_user_table.dart';
import 'package:sponjobsadmin/view/dashboard/employers/employers_user_table.dart';
import 'package:sponjobsadmin/view/login.dart';
import 'package:sponjobsadmin/view/splash.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        // primaryColor: orange,
        appBarTheme: const AppBarTheme(
          backgroundColor: orange
        )
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}

