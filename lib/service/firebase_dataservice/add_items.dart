import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../controller/home_controller.dart';

class AddItems {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final FirebaseAuth auth = FirebaseAuth.instance;
  final controller = Get.find<HomeController>();

  Future<void> addItem(String itemName) async {
    final User? user = auth.currentUser;
    final uid = user!.uid;

    await firestore.collection(uid).doc(controller.listName.toString()).set({
      "owner": "CqxRDkF36GOfZA7JQJ9rTj20NOj2",
      "listName": "list1",
      "content": {
        itemName: {
          "price": 0,
          "addByUser": true,
          "sum": 1,
          "isDone": false,
          "name": itemName
        }
      }
    }, SetOptions(merge: true));
  }
}
