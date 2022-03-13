import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../product_pages/milk_breakfast.dart';

// ignore: must_be_immutable
class ProductListCard extends StatelessWidget {
  String listName;
  ProductListCard({
    required this.listName,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() => const MilkandBreakfast()),
      child: Card(
        child: SizedBox(
          height: Get.height * 0.07,
          width: Get.width * 0.9,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  listName,
                  style: const TextStyle(
                      fontSize: 16, fontFamily: 'Gilroy', color: Colors.black),
                ),
                const Icon(Icons.arrow_forward_sharp)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
