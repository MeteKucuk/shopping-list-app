import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../controller/home_controller.dart';

class CreateList {
  final homeController = Get.find<HomeController>();

  Future<void> createList(String listName, DateTime dateTime) async {
    return await FirebaseFirestore.instance
        .collection("lists")
        .doc(listName)
        .set({
      "owner": "CqxRDkF36GOfZA7JQJ9rTj20NOj2",
      "listName": listName,
      'dataTime': dateTime,
      "content": {}
    });
  }
}
