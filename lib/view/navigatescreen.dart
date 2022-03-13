import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import '../utils/constant.dart';
import 'addproduct.dart';
import 'widgets/new_list_page.dart';

import '../controller/home_controller.dart';
import 'listpage.dart';
import 'homescreen.dart';

class NavigateScreen extends StatefulWidget {
  static late PersistentTabController navigationController;
  const NavigateScreen({Key? key}) : super(key: key);

  @override
  _NavigateScreenState createState() => _NavigateScreenState();
}

class _NavigateScreenState extends State<NavigateScreen> {
  final HomeController homeController = Get.find<HomeController>();

  final nameEditor = TextEditingController();
  List<Widget> productPage() {
    return [
      const HomeScreen(),
      const AddProduct(),
      const ListPage(),
    ];
  }

  bool navbarVisibility = false;

  @override
  void initState() {
    NavigateScreen.navigationController =
        PersistentTabController(initialIndex: 0);
    NavigateScreen.navigationController.addListener(() {
      setState(() {
        navbarVisibility = NavigateScreen.navigationController.index == 1;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        context,
        controller: NavigateScreen.navigationController,

        hideNavigationBar: navbarVisibility,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Colors.white, // Default is Colors.white.
        handleAndroidBackButtonPress: true, // Default is true.
        resizeToAvoidBottomInset:
            true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: true, // Default is true.
        hideNavigationBarWhenKeyboardShows:
            true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
          colorBehindNavBar: Colors.white,
        ),

        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: const ItemAnimationProperties(
          // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),

        navBarStyle:
            NavBarStyle.style15, // Choose the nav bar style with this property.
      ),
    );
  }

  List<Widget> _buildScreens() {
    return [
      const HomeScreen(),
      const NewListPage(),
      const ListPage(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        iconSize: 30,
        icon: const Icon(
          Icons.home,
        ),
        activeColorPrimary: Colors.deepOrangeAccent.withOpacity(0.8),
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        iconSize: 30,
        onPressed: (p0) {
          NavigateScreen.navigationController.jumpToTab(1);

          NavigateScreen.navigationController.index = 1;
          const NewListPage();
        },
        activeColorPrimary: kColorOrange.withOpacity(0.8),
        inactiveColorSecondary: Colors.red,
        activeColorSecondary: Colors.red,
        filter: ImageFilter.blur(sigmaX: 6.0, sigmaY: 10.0),
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.list_alt_rounded),
          activeColorPrimary: Colors.deepOrangeAccent.withOpacity(0.8),
          inactiveColorPrimary: Colors.grey,
          iconSize: 28),
    ];
  }

  /* Future<dynamic> defaulDialog() {
    return Get.defaultDialog(
      title: 'ListName',
      content: Obx(() => Form(
            key: homeController.listFormGlobal.value,
            child: TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter list name';
                }
                return null;
              },
              controller: nameEditor,
              autofocus: true,
            ),
          )),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(primary: const Color(0xFFF66A68)),
          child: const Text(
            'Cancel',
            style: TextStyle(fontFamily: 'Gilroy', fontSize: 12),
          ),
          onPressed: () {
            NavigateScreen.navigationController.jumpToTab(0);

            NavigateScreen.navigationController.index = 0;

            Get.back();
          },
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(primary: const Color(0xFFF66A68)),
          child: const Text(
            'Create',
            style: TextStyle(fontFamily: 'Gilroy', fontSize: 12),
          ),
          onPressed: () {
            if (homeController.listFormGlobal.value.currentState!.validate()) {
              CreateList().createList(nameEditor.text);
              homeController.listNameChanged(nameEditor.text);

              NavigateScreen.navigationController.jumpToTab(1);

              NavigateScreen.navigationController.index = 1;

              Get.back();
            }
          },
        ),
      ],
    );
  } */
}
