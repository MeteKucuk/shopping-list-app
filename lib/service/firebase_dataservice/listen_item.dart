// ignore_for_file: file_names

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:togethershoplist/controller/home_controller.dart';

class ListenItem {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final FirebaseAuth auth = FirebaseAuth.instance;

  final controller = Get.find<HomeController>();

  Stream<DocumentSnapshot<Map<String, dynamic>>> userItemStream(
      String listName) {
    return FirebaseFirestore.instance
        .collection(auth.currentUser!.uid)
        .doc(listName)
        .snapshots();
  }
}
