import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../controller/home_controller.dart';

class UpdateItems {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final FirebaseAuth auth = FirebaseAuth.instance;
  final controller = Get.find<HomeController>();

  Future<void> updateItem(
      {required String itemName, required bool isDone}) async {
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
          "isDone": isDone,
          "name": itemName
        }
      }
    }, SetOptions(merge: true));
  }
}
