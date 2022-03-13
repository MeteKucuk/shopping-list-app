import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'homescreen.dart';

import '../controller/home_controller.dart';
import 'navigatescreen.dart';
import 'widgets/item_name_textformfield.dart';
import 'widgets/stream_user_list_item.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({
    Key? key,
  }) : super(key: key);

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final itemNameController = TextEditingController();

  bool isChecked = false;

  final HomeController homeController = Get.find<HomeController>();

  @override
  void dispose() {
    itemNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        NavigateScreen.navigationController.index = 0;
        NavigateScreen.navigationController.jumpToTab(0);

        return false;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF6FAFB),
        body: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SizedBox(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              NavigateScreen.navigationController.jumpToTab(0);

                              NavigateScreen.navigationController.index = 0;
                              Get.to(() => const HomeScreen());
                            });
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                            size: 35,
                          ),
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.more_vert,
                              size: 35,
                            ))
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Obx(
                          () => AutoSizeText(
                            '${homeController.listName.value.toUpperCase()} checklist (7)',
                            style: const TextStyle(
                              fontSize: 25,
                              fontFamily: 'Gilroy',
                            ),
                            maxLines: 2,
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Flexible(
                    fit: FlexFit.loose,
                    child: Obx(() => Column(
                          children: [
                            const Text(
                              'Add item from the most popular markets ',
                              style:
                                  TextStyle(fontFamily: 'Gilroy', fontSize: 18),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    child: Image.asset(
                                      'assets/sok.png',
                                      height: 50,
                                      width: 60,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 5),
                                    child: Image.asset(
                                      'assets/migros.png',
                                      height: 50,
                                      width: 60,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Image.asset(
                                    'assets/a101.jpg',
                                    height: 30,
                                  ),
                                ),
                              ],
                            ),
                            StreamUserListItem(
                                listName: homeController.listName.value)
                          ],
                        )),
                  ),
                  ItemNameTextFormField(
                    controller: itemNameController,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
