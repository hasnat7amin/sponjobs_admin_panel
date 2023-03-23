
import "dart:io";

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../res/components/flushbar.dart';

class EmployeeUserModel {
  ///Upload Image to Storage
  Future<String> getUrl(BuildContext context, {required File file}) async {
    late String postFileUrl;
    try {
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('images/${file.path.split('/').last}');
      UploadTask uploadTask = storageReference.putFile(file);
      uploadTask.snapshotEvents.listen((TaskSnapshot taskSnapshot) {
        final progress =
            100.0 * (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
        print("_______________________${progress}");
      });
      await uploadTask.whenComplete(() async {
        await storageReference.getDownloadURL().then((fileURL) {
          postFileUrl = fileURL;
        });
      });
      getFlushBar(context, title: 'Image updated successfully');
      return postFileUrl;
    } on FirebaseException catch (e) {
      getFlushBar(context, title: e.toString());
      rethrow;
    }
  }
}