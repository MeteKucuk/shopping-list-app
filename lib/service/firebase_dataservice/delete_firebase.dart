import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../../controller/home_controller.dart';

class DeleteFirebase {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final controller = Get.find<HomeController>();

  Future<void> deleteList({int? index}) async {
    final uid = _auth.currentUser!.uid;

    final userList = await _firestore.collection(uid).get();
    final userListName = userList.docs[index!].id;

    await _firestore.collection(uid).doc(userListName).delete();
  }

  Future<void> deleteItem(String title) async {
    final uid = _auth.currentUser!.uid;

    await _firestore.collection(uid).doc(controller.listName.value).update(
      {'content.$title': FieldValue.delete()},
    );
  }
}
