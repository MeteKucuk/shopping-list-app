import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../service/authorization/auth_google.dart';
import '../../service/authorization/auth_mail.dart';
import 'login.dart';
import 'widgets/customDivider.dart';
import 'widgets/socialButton.dart';
import 'widgets/text_form_field.dart';

import '../../service/authorization/auth_facebook.dart';
import '../navigatescreen.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool success = false;

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
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        'Create Account!',
                        style: TextStyle(fontFamily: 'Gilroy', fontSize: 30),
                      ),
                      const SizedBox(
                        height: 15,
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
                          validator: (val) {
                            if (val!.isEmpty && !val.contains('@')) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
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
                            validator: (val) {
                              if (val == null ||
                                  val.isEmpty ||
                                  val.length < 6) {
                                return 'Password should be 6 characters ';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      Container(
                        height: 10,
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
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          if (_formkey.currentState!.validate()) {
                            final succesfull = await AuthMail().register(
                                emailController.text,
                                passwordController.text,
                                success);

                            succesfull
                                ? Get.offAll(const NavigateScreen())
                                : null;
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
                                'Create Account',
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
                          Text("Or sign up  with"),
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
                          const Text('Already  a member?'),
                          TextButton(
                              onPressed: () {
                                Get.to(() => const Login());
                              },
                              child: const Text('Sign In'))
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
