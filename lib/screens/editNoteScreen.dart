// ignore_for_file: file_names, prefer_const_constructors

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_notesapp/screens/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditNoteScreen extends StatefulWidget {
  const EditNoteScreen({super.key});

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  TextEditingController noteController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Notes"),
      ),
      body: Container(
        child: Column(
          children: [
            TextFormField(
              controller: noteController
                //----CATCH ARGUMENT FROM HOMESCREEN-----
                ..text = "${Get.arguments['note'].toString()}",
            ),
            ElevatedButton(
                //----UPDATE DATA IN FIREBASE FIRESTORE---
                onPressed: () async {
                  await FirebaseFirestore.instance
                      .collection("notes")
                      .doc(Get.arguments['docId'].toString())
                      .update({'note': noteController.text.trim()}).then(
                          (value) => {
                                Get.offAll(() => HomeScreen()),
                                log("Data Updated")
                              });
                },
                child: Text("Update"))
          ],
        ),
      ),
    );
  }
}
