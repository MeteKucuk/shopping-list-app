import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../navigatescreen.dart';
import 'welcome.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1), () {
      if (FirebaseAuth.instance.currentUser == null) {
        Get.offAll(() => const Welcome());
      } else {
        Get.offAll(() => const NavigateScreen());
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
