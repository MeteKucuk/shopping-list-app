import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:togethershoplist/service/firebase_dataservice/save_uid_email.dart';

class AuthGoogle {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> signInWithGoogle() async {
    GoogleSignInAccount? googleUser;

    try {
      googleUser = await GoogleSignIn().signIn();
      // ignore: empty_catches
    } on Exception {}

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    var userCredential = await _auth.signInWithCredential(credential);

    try {
      SaveUidEmail().saveUserData(
          uid: userCredential.user!.uid, email: userCredential.user!.email!);
    } catch (e) {
      print(e.toString());
    }

    /*  userCredential.user?.getIdToken().then((value) {
      print(value);
    }); */

    return userCredential.user != null;
  }
}
