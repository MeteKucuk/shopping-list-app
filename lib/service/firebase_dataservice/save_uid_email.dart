import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SaveUidEmail {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  Future<void> saveUserData(
      {required String uid, required String email}) async {
    await _firestore.collection('users').doc('userList').set({
      " accounts": {
        uid: {
          'email': email,
          'uid': uid,
        }
      }
    }, SetOptions(merge: true));
  }
}
