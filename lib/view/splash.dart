import "dart:async";

import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:get/get_core/src/get_main.dart";
import "package:sponjobsadmin/res/colors.dart";
import "package:sponjobsadmin/view/login.dart";

import "../view_model/login_view_model.dart";
import "dashboard.dart";


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    getLogin()async{
      final userViewModel = Get.put(LoginViewModel());
      bool isLogedIn = await userViewModel.getAdminId();
      if(isLogedIn){
        Get.off(const Dashboard());
      }
      else{
        Get.off(const LoginScreen());
      }
    };
    Timer(const Duration(seconds: 10),(){
      getLogin();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        decoration: const BoxDecoration(
          color: orange,
        ),
        child: Stack(
          children: [
            const Center(
              child: Text(
                "SponsJob",
                style: TextStyle(
                  fontSize: 25,
                  color: white,
                ),
              ),
            ),

            Positioned(
              bottom: height*0.08,right: 0,left: 0,
              child: const Center(
                child: CircularProgressIndicator(
                  color: white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
