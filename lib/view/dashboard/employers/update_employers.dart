import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sponjobsadmin/res/constants/firebase_collections.dart';
import 'package:sponjobsadmin/view_model/employee_user_model.dart';

import '../../../res/colors.dart';
import '../../../res/components/button.dart';
import '../../../res/components/text_input.dart';
import '../../../res/constants/sizes.dart';
import '../../../res/styles/box_decoration.dart';
import '../../../view_model/employer_user_model.dart';

class UpdateEmployers extends StatefulWidget {
  String id;
  String image;
  UpdateEmployers({Key? key, required this.id, required this.image})
      : super(key: key);

  @override
  State<UpdateEmployers> createState() => _UpdateEmployersState();
}

class _UpdateEmployersState extends State<UpdateEmployers> {
  FirebaseStorage storage = FirebaseStorage.instance;
  final _key = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  PickedFile? imagePick;
  final email = TextEditingController();
  final name = TextEditingController();
  final companyName = TextEditingController();
  final companyAddress = TextEditingController();
  final employeeUserModel = Get.put(EmployeeUserModel());
  String gender = "";
  String _image = "";
  File? file;

  getUser() async {
    var data = await FirebaseFirestore.instance
        .collection(FirebaseCollection.employers)
        .doc(widget.id)
        .get();
    debugPrint(data.data().toString());
    email.text = data.data()!['email'];
    name.text = data.data()!["name"];
    companyName.text = data.data()!["companyName"];
    companyAddress.text = data.data()!['companyAddress'].toString();
    debugPrint("image picker: " + imagePick.isNull.toString());
    debugPrint(data.id.toString());
  }

  Future getImage(ImageSource source) async {
    final pickedFile = await _picker.getImage(source: source, imageQuality: 30);
    if (pickedFile != null && pickedFile.path != null) {
      file = File(pickedFile.path);
      setState(()async { _image = await EmployersUserModel().getUrl(context, file: file!);});

      debugPrint(_image);
    }
  }

  @override
  void initState() {
    _image = widget.image;
    getUser();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Employee"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          width: width,
          height: height,
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Form(
            key: _key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    _image.toString().length > 0
                        ? CircleAvatar(
                      radius: height * Height.height_52,
                      backgroundImage: NetworkImage(
                        _image,
                      ),
                    )
                        : CircleAvatar(
                      radius: height * Height.height_52,
                      backgroundImage:
                      AssetImage("assets/images/profile.png"),
                    ),
                    InkWell(
                      onTap: () async {
                        getImage(ImageSource.gallery);
                      },
                      child: const CircleAvatar(
                        radius: 15,
                        backgroundColor: CupertinoColors.inactiveGray,
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
                  ],
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Email",
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
                    "Name",
                    style: spanish_grey_regular_12,
                  ),
                ),
                SizedBox(
                  height: height * Height.height_8,
                ),
                textInput(
                  name,
                  "Enter Name",
                  Icons.person_outline,
                  false,
                  width,
                  TextInputType.name,
                  "Please enter your name.",
                ),
                SizedBox(
                  height: height * Height.height_12,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Company Name",
                    style: spanish_grey_regular_12,
                  ),
                ),
                SizedBox(
                  height: height * Height.height_8,
                ),
                textInput(
                  companyName,
                  "Enter Company Name",
                  Icons.person_outline,
                  false,
                  width,
                  TextInputType.name,
                  "Please enter your company name.",
                ),
                SizedBox(
                  height: height * Height.height_12,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Company Address",
                    style: spanish_grey_regular_12,
                  ),
                ),
                SizedBox(
                  height: height * Height.height_8,
                ),
                textInput(
                  companyAddress,
                  "Enter Company Address",
                  Icons.person_outline,
                  false,
                  width,
                  TextInputType.name,
                  "Please enter your company address.",
                ),
                SizedBox(
                  height: height * Height.height_14,
                ),
                button(()async {
                  if (_key.currentState!.validate()){
                    // print("email"+email.text.trim()+"password"+password.text.trim());
                    await FirebaseFirestore.instance.collection(FirebaseCollection.employers).doc(widget.id).update({
                      "name":name.text.toString(),
                      "email":email.text.toString(),
                      "companyAddress": companyAddress.text.toString(),
                      "companyName": companyName.text.toString(),
                      'image': _image
                    }).then((value) {
                      Get.snackbar("Congratulations", "This employers updated successfully.").show();
                      // Get.back();
                      Navigator.pop(context);
                    }).onError((error, stackTrace) {
                      Get.snackbar("Error", error.toString()).show();
                      Navigator.pop(context);
                    });

                  } else {
                    if (kDebugMode) {
                      print("please enter all fields.");
                    }
                  }
                }, "Save Changes", height, width),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
