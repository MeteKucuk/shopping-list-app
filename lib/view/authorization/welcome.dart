import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'login.dart';
import 'register.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> with SingleTickerProviderStateMixin {
  AnimationController? _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    );

    _controller?.animateTo(_controller!.upperBound - 0.2);
    Timer.periodic(const Duration(seconds: 50), (_) {
      _controller?.reset();

      _controller?.animateTo(_controller!.upperBound - 0.2);
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller!.dispose();
    _controller = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Flex(
          direction: Axis.vertical,
          children: [
            Expanded(
              flex: 1,
              child: Column(
                children: const [
                  Spacer(),
                  Expanded(
                    flex: 2,
                    child: Text(
                      "Shopping together is \n      Always better",
                      style: TextStyle(
                          fontFamily: 'Gilroy',
                          fontSize: 30,
                          fontStyle: FontStyle.normal),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      "Enjoy creating a need list together. \n        Do not overlook anything.",
                      style: TextStyle(color: Color(0xFF9895A5), fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.1),
                        child: Lottie.network(
                          'https://assets1.lottiefiles.com/packages/lf20_m825wtqt.json',
                          controller: _controller,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 50),
                        width: MediaQuery.of(context).size.width * 0.8,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xFFF4F6FB),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFFFFF),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    Get.to(() => const Register());
                                  },
                                  child: const Text(
                                    'Register',
                                    style: TextStyle(
                                      color: Color(0xFF595568),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: TextButton(
                                onPressed: () {
                                  Get.to(() => const Login());
                                },
                                child: const Text(
                                  'Sign In',
                                  style: TextStyle(
                                    color: Color(0xFF595568),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
