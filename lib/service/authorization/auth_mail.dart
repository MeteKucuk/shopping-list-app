import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:togethershoplist/service/firebase_dataservice/save_uid_email.dart';

class AuthMail {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> register(
      String email, dynamic password, bool successfull) async {
    User? user;
    try {
      user = (await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user;
    } on FirebaseAuthException catch (e) {
      e.code == 'email-already-in-use'
          ? Get.snackbar('Information', 'This e-mail is already registered')
          : Get.snackbar('Error', 'Something went wrong');
    }
    if (user != null) {
      FirebaseFirestore.instance.collection(user.uid).doc('list').set({
        "content": [
          {
            "name": "test",
            "price": 0,
            "sum": 1,
            "isDone": false,
            "adByUser": true
          }
        ]
      });
      return successfull = true;
    } else {
      return successfull = false;
    }
  }

  Future<void> signInWithEmailandPassword(
      String email, dynamic password, bool success) async {
    final User? user = (await _auth.signInWithEmailAndPassword(
            email: email, password: password))
        .user;

    if (user != null) {
      await SaveUidEmail().saveUserData(uid: user.uid, email: user.email!);

      success = true;
    } else {
      success = false;
    }
  }
}
