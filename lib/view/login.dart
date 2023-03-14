import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sponjobsadmin/view_model/login_view_model.dart';

import '../res/components/button.dart';
import '../res/components/text_input.dart';
import '../res/constants/sizes.dart';
import '../res/styles/box_decoration.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _key = GlobalKey<FormState>();
  final _controller = Get.put(LoginViewModel());
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Obx(
          ()=> SafeArea(
            child: _controller.isLoginLoading.value
                ? const Center(
              child: CircularProgressIndicator(
                // color: AppColors.kPrimaryColor,
              ),
            )
                : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Container(
                width: width,
                height: height,
                child: Form(
                  key: _key,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text("Login To Admin Panal",style: outer_space_semibold_20,),
                      SizedBox(
                        height: height * Height.height_45,
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Username",
                          style: spanish_grey_regular_12,
                        ),
                      ),
                      SizedBox(
                        height: height * Height.height_8,
                      ),
                      textInput(
                        email,
                        "Enter Email",
                        Icons.account_circle_outlined,
                        false,
                        width,
                        TextInputType.emailAddress,
                        "Please enter your email.",
                      ),
                      SizedBox(
                        height: height * Height.height_12,
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Password",
                          style: spanish_grey_regular_12,
                        ),
                      ),
                      SizedBox(
                        height: height * Height.height_8,
                      ),
                      textInput(
                        password,
                        "Enter Password",
                        Icons.lock_outline_rounded,
                        true,
                        width,
                        TextInputType.visiblePassword,
                        "Please enter your password.",
                      ),
                      SizedBox(
                        height: height * Height.height_14,
                      ),
                      button(
                            () {
                          if (_key.currentState!.validate()){
                            print("email"+email.text.trim()+"password"+password.text.trim());
                            // userViewModel.userSignUp(
                            //     email.text.trim(),
                            //     password.text.trim(),
                            // )
                          } else {
                            if (kDebugMode) {
                              print("please enter all fields.");
                            }
                          }
                        },
                        "Login",
                        height,
                        width
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );

  }
}
