import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxString listName = ''.obs;

  Rx<GlobalKey<FormState>> itemformGlobal = GlobalKey<FormState>().obs;

  Rx<GlobalKey<FormState>> listFormGlobal = GlobalKey<FormState>().obs;

  void listNameChanged(String value) {
    listName.value = value;
  }
}
