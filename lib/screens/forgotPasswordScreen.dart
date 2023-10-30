// ignore_for_file: file_names, avoid_unnecessary_containers, prefer_const_constructors, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_notesapp/screens/signInScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController forgotPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Forgot Password Screen'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                height: 250.0,
                child: Lottie.asset('assets/animation/animation_lncxm5aq.json'),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30.0),
                child: TextFormField(
                  controller: forgotPasswordController,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.mail),
                      hintText: 'Email',
                      enabledBorder: OutlineInputBorder()),
                ),
              ),
              SizedBox(height: 10.0),
              ElevatedButton(
                  //-----FORGOT PASSWORD VIA FIREBASE------
                  onPressed: () async {
                    var forgotEmail = forgotPasswordController.text.trim();
                    try {
                      await FirebaseAuth.instance
                          .sendPasswordResetEmail(email: forgotEmail)
                          .then((value) => {
                                print("Email Sent!"),
                                Get.off(() => LoginScreen())
                              });
                    } on FirebaseAuthException catch (e) {
                      print("Error! $e");
                    }
                  },
                  child: Text('Forgot Password')),
            ],
          ),
        ),
      ),
    );
  }
}
