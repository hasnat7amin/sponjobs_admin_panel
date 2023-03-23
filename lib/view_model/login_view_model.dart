import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sponjobsadmin/view/dashboard.dart';

import '../res/components/flushbar.dart';

class LoginViewModel extends GetxController {
  RxBool isLoginLoading = false.obs;
  late dynamic adminData;
  final _db = FirebaseFirestore.instance;


  Future<void> adminLogin(String username, String password) async {
    isLoginLoading.value = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    CollectionReference adminCollRef = _db.collection("admin");
    QuerySnapshot querySnapshot = await adminCollRef.get();

    dynamic allData = querySnapshot.docs.map((doc) {
        return {"id": doc.id.toString(), "data": doc.data()};
    }).toList();

    for(var i=0;i<allData.length;i++){
      if(allData[i]["data"]["password"] == password && allData[i]["data"]["username"]  == username){
        adminData = allData[i];
        prefs.setString("id", allData[i]["id"]);
        Get.off(const Dashboard());
      }
    }
    isLoginLoading.value = false;

  }

  Future<bool> getAdminId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString('id');
    return id != null?true:false;
  }
}
