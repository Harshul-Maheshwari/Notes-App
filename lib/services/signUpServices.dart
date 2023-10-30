// ignore_for_file: non_constant_identifier_names, file_names, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_notesapp/screens/signInScreen.dart';
import 'package:get/get.dart';

SignUpUser(String userName, String userPhone, String userEmail,
    String userPassword) async {
  var userid = FirebaseAuth.instance.currentUser;
  try {
    await FirebaseFirestore.instance.collection("users").doc(userid!.uid).set({
      'userName': userName,
      'userPhone': userPhone,
      'userEmail': userEmail,
      'createdAt': DateTime.now(),
      'uid': userid.uid,
    }).then((value) =>
        {FirebaseAuth.instance.signOut(), Get.to(() => LoginScreen())});
  } on FirebaseAuthException catch (e) {
    // ignore: avoid_print
    print("Error! $e");
  }
}
