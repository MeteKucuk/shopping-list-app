// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:togethershoplist/controller/home_controller.dart';
import 'package:togethershoplist/service/firebase_dataservice/delete_firebase.dart';
import 'package:togethershoplist/service/firebase_dataservice/update_items.dart';

class ItemCard extends StatefulWidget {
  final String? title;

  bool isDone;
  ItemCard({
    Key? key,
    required this.title,
    required this.isDone,
  }) : super(key: key);

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  final homeController = Get.find<HomeController>();
  bool isSelected = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await Get.defaultDialog(actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text('Cancel')),
              TextButton(
                  onPressed: () {
                    DeleteFirebase().deleteItem(widget.title.toString());
                    Get.back();
                  },
                  child: const Text('Confirm')),
            ],
          ),
        ], title: 'Delete Item ?', buttonColor: Colors.red);

        /*   await DeleteFirebase().deleteItem(widget.title!); */
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        shadowColor: Colors.black,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Checkbox(
                focusColor: Colors.black,
                shape: const CircleBorder(),
                value: widget.isDone,
                onChanged: (value) async {
                  setState(() {
                    widget.isDone = value!;
                  });

                  await UpdateItems().updateItem(
                      isDone: widget.isDone, itemName: widget.title.toString());
                }),
            Text(
              widget.title!,
              style: const TextStyle(
                  color: Colors.black, fontSize: 22, fontFamily: 'Gilroy'),
            ),
          ],
        ),
      ),
    );
  }
}
