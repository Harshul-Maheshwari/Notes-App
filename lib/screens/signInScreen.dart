// ignore_for_file: file_names, avoid_unnecessary_containers, prefer_const_constructors, unused_local_variable, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_notesapp/screens/forgotPasswordScreen.dart';
import 'package:firebase_notesapp/screens/homeScreen.dart';
import 'package:firebase_notesapp/screens/signUpScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('Login Screen'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                height: 300.0,
                child: Lottie.asset('assets/animation/animation_lncxm5aq.json'),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30.0),
                child: TextFormField(
                  controller: loginEmailController,
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
                  controller: loginPasswordController,
                  decoration: InputDecoration(
                      suffixIcon: Icon(Icons.visibility),
                      prefixIcon: Icon(Icons.password),
                      hintText: 'Password',
                      enabledBorder: OutlineInputBorder()),
                ),
              ),
              SizedBox(height: 10.0),
              ElevatedButton(
                  //----LOGIN USER NY FIREBASE------
                  onPressed: () async {
                    var loginEmail = loginEmailController.text.trim();
                    var loginPassword = loginPasswordController.text.trim();

                    try {
                      final User? firebaseUser = (await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: loginEmail, password: loginPassword))
                          .user;
                      if (firebaseUser != null) {
                        Get.to(() => HomeScreen());
                      } else {
                        print("Check Email and Password");
                      }
                    } on FirebaseAuthException catch (e) {
                      print("Error! $e");
                    }
                  },
                  child: Text('Login')),
              SizedBox(height: 10.0),
              GestureDetector(
                onTap: () {
                  Get.to(() => ForgotPasswordScreen());
                },
                child: Container(
                    child: Card(
                        child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text('Forgot password'),
                ))),
              ),
              SizedBox(height: 10.0),
              GestureDetector(
                onTap: () {
                  Get.to(() => SignUpScreen());
                },
                child: Container(
                    child: Card(
                        child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("Don't have an account? SignUp"),
                ))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
