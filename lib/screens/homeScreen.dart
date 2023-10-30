// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_notesapp/screens/createNoteScreen.dart';
import 'package:firebase_notesapp/screens/editNoteScreen.dart';
import 'package:firebase_notesapp/screens/signInScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? userId = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Home Screen"),
        actions: [
          GestureDetector(
              onTap: () {
                FirebaseAuth.instance.signOut();
                Get.off(() => LoginScreen());
              },
              child: Icon(Icons.logout))
        ],
      ),
      //-------GET AND SHOW DATA FROM FIRESTORE-----
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("notes")
            .where("userId", isEqualTo: userId?.uid)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong!");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CupertinoActivityIndicator());
          }
          if (snapshot.data!.docs.isEmpty) {
            return Center(child: Text("No Data Found!"));
          }
          if (snapshot != null && snapshot.data != null) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var note = snapshot.data!.docs[index]['note'];
                var noteId = snapshot.data!.docs[index]['userId'];
                var docId = snapshot.data!.docs[index].id;
                return Card(
                  child: ListTile(
                    title: Text(note),
                    subtitle: Text(noteId),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                            onTap: () {
                              //---NAVIGATE AND SEND DATA TO EDITNOTESCREEN FROM FIREBASE FIRESTORE----
                              Get.to(() => EditNoteScreen(), arguments: {
                                'note': note,
                                'docId': docId,
                              });
                            },
                            child: Icon(Icons.edit)),
                        SizedBox(width: 10.0),
                        //DELETE DATA FROM FIREBASE FIRESTORE
                        GestureDetector(
                            onTap: () async {
                              await FirebaseFirestore.instance
                                  .collection("notes")
                                  .doc(docId)
                                  .delete();
                            },
                            child: Icon(Icons.delete)),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => CreateNoteScreen());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
