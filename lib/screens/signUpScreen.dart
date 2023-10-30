// ignore_for_file: file_names, avoid_unnecessary_containers, prefer_const_constructors

//import 'dart:math';

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_notesapp/screens/signInScreen.dart';
import 'package:firebase_notesapp/services/signUpServices.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController userPhoneController = TextEditingController();
  TextEditingController userEmailController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();

  User? currentUser = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('SignUp Screen'),
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
                  controller: userNameController,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      hintText: 'UserName',
                      enabledBorder: OutlineInputBorder()),
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30.0),
                child: TextFormField(
                  controller: userPhoneController,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.phone),
                      hintText: 'Phone',
                      enabledBorder: OutlineInputBorder()),
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30.0),
                child: TextFormField(
                  controller: userEmailController,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.mail),
                      hintText: 'Email',
                      enabledBorder: OutlineInputBorder()),
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30.0),
                child: TextFormField(
                  controller: userPasswordController,
                  decoration: InputDecoration(
                      suffixIcon: Icon(Icons.visibility),
                      prefixIcon: Icon(Icons.password),
                      hintText: 'Password',
                      enabledBorder: OutlineInputBorder()),
                ),
              ),
              SizedBox(height: 10.0),
              ElevatedButton(
                  onPressed: () async {
                    var userName = userNameController.text.trim();
                    var userPhone = userPhoneController.text.trim();
                    var userEmail = userEmailController.text.trim();
                    var userPassword = userPasswordController.text.trim();

                    //----CREATE USER ACCOUNT WITH EMAIL AND PASSWORD-----
                    await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                            email: userEmail, password: userPassword)
                        .then((value) => {
                              log("User Created"),
                              SignUpUser(
                                  userName, userPhone, userEmail, userPassword),
                            });
                  },
                  child: Text('Sign Up')),
              SizedBox(height: 10.0),
              GestureDetector(
                onTap: () {
                  Get.to(() => LoginScreen());
                },
                child: Container(
                    child: Card(
                        child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("Already have an account? SignIn"),
                ))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
