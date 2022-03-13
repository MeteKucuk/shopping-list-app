import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../service/authorization/auth_facebook.dart';
import '../../service/authorization/auth_google.dart';
import '../../service/authorization/auth_mail.dart';
import '../navigatescreen.dart';
import 'register.dart';
import 'widgets/customDivider.dart';
import 'widgets/socialButton.dart';
import 'widgets/text_form_field.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  late bool success;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Form(
          key: _formkey,
          child: Flex(
            direction: Axis.vertical,
            children: [
              Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text(
                        'Hello Again!',
                        style: TextStyle(fontFamily: 'Gilroy', fontSize: 30),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        'Welcome back you have \n          been missed!',
                        style:
                            TextStyle(color: Color(0xFF9895A5), fontSize: 20),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: CustomTextFormField(
                          hintText: 'Enter e-mail',
                          obscureTextt: false,
                          controller: emailController,
                          validator: (value) =>
                              value!.isEmpty ? 'Please enter an email' : null,
                        ),
                      ),
                      Container(
                        height: 10,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: GestureDetector(
                          onTap: () {},
                          child: CustomTextFormField(
                            hintText: 'Password',
                            obscureTextt: true,
                            controller: passwordController,
                            validator: (value) => value!.isEmpty
                                ? 'Please enter a password'
                                : null,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(
                          top: 20,
                          right: MediaQuery.of(context).size.width * 0.1,
                        ),
                        child: const InkWell(
                          child: Text('Recovery Your Password'),
                        ),
                      )
                    ],
                  )),
              Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          if (_formkey.currentState!.validate()) {
                            setState(() {
                              success = true;
                            });
                            try {
                              await AuthMail().signInWithEmailandPassword(
                                  emailController.text,
                                  passwordController.text,
                                  success);

                              Get.offAll(() => const NavigateScreen());
                            } catch (e) {
                              Get.snackbar('', 'This mail doesn\'t exist');
                            }
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: const Color(0xFFF66A68),
                          ),
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: MediaQuery.of(context).size.height * 0.08,
                          child: const Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Sing In',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontFamily: 'Gilroy'),
                              )),
                        ),
                      ),
                      Row(
                        children: const [
                          Expanded(
                            child: CustomDivider(),
                          ),
                          Text("Or continue with"),
                          Expanded(child: CustomDivider()),
                        ],
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: Platform.isAndroid
                              ? [
                                  socialButton('assets/google.svg', () async {
                                    try {
                                      var isLogged =
                                          await AuthGoogle().signInWithGoogle();

                                      isLogged
                                          ? Get.offAll(
                                              () => const NavigateScreen())
                                          : null;
                                    } catch (e) {
                                      Get.snackbar(
                                          'Error', 'Something went wrong');
                                    }
                                  }),
                                  socialButton('assets/facebook.svg', () async {
                                    try {
                                      var credinital = await AuthFacebook()
                                          .signInWithFacebook();
                                      if (credinital.user != null) {
                                        Get.offAll(
                                            () => const NavigateScreen());
                                      }
                                    } catch (e) {
                                      Get.snackbar(
                                          'Error', 'Something went wrong');
                                    }
                                  }),
                                ]
                              : [
                                  socialButton('assets/apple.svg', () {}),
                                  socialButton('assets/facebook.svg', () async {
                                    try {
                                      var credinital = await AuthFacebook()
                                          .signInWithFacebook();
                                      if (credinital.user != null) {
                                        Get.offAll(
                                            () => const NavigateScreen());
                                      }
                                    } catch (e) {
                                      Get.snackbar(
                                          'Error', 'Something went wrong');
                                    }
                                  }),
                                ]),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Not a member'),
                          TextButton(
                              onPressed: () {
                                Get.to(() => const Register());
                              },
                              child: const Text('Register now'))
                        ],
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
