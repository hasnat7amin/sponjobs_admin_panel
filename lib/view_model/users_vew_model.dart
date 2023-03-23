import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../res/constants/firebase_collections.dart';

class UserViewModel extends GetxController{
  Future<void> deleteUser(String col,String id)async {
   await FirebaseFirestore.instance.collection(col).doc(id).delete();
  }
}