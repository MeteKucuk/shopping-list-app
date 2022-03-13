import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/constant.dart';
import 'authorization/welcome.dart';

import '../service/scrapper/a101_scrapper.dart';
import 'widgets/streamUserList.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final productFetch = A101Scrapper();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6FAFB),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        await FirebaseAuth.instance.signOut();
                        Get.to(const Welcome());
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        size: 35,
                      ),
                    ),
                    const Icon(
                      Icons.search,
                      size: 35,
                    ),
                  ],
                ),
              ),
              const Text(
                'Shopping List',
                style: kStyleText,
              ),
              Flexible(
                  fit: FlexFit.loose,
                  child: Column(
                    children: const [
                      StreamUserList(),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
