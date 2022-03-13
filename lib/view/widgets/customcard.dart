// ignore_for_file: must_be_immutable

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:togethershoplist/controller/home_controller.dart';
import 'package:togethershoplist/service/firebase_dataservice/delete_firebase.dart';
import 'package:togethershoplist/view/addproduct.dart';

class CustomCard extends StatefulWidget {
  String? title;

  int? index;

  CustomCard({
    Key? key,
    required this.title,
    this.index,
  }) : super(key: key);

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  final homeController = Get.find<HomeController>();
  bool isSelected = false;

  AssetImage isOdd(int i) {
    if (i % 2 == 0) {
      return const AssetImage('assets/backgroundblue.png');
    } else {
      return const AssetImage('assets/greenbackground.png');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        homeController.listNameChanged(widget.title.toString());
        Get.to(() => const AddProduct());
      },
      child: Slidable(
        // Specify a key if the Slidable is dismissible.
        key: const ValueKey(0),

        // The start action pane is the one at the left or the top side.

        // The end action pane is the one at the right or the bottom side.
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              spacing: 100,
              // An action can be bigger than the others.
              flex: 1,
              onPressed: (_) {},
              backgroundColor: const Color(0xFF7BC043),
              foregroundColor: Colors.white,
              icon: Icons.archive,
              label: 'Archive',
            ),
            SlidableAction(
              spacing: 10,
              onPressed: (_) async {
                await DeleteFirebase().deleteList(index: widget.index);
              },
              backgroundColor: const Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),

        // The child of the Slidable is what the user sees when the
        // component is not dragged.
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 9,
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            borderOnForeground: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            shadowColor: const Color(0xFFDFB29B),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFDFB29B).withOpacity(.5),
                    blurRadius: 20.0,
                    spreadRadius: 5.0,
                    offset: const Offset(
                      5.0,
                      5.0,
                    ),
                  )
                ],
                borderRadius: BorderRadius.circular(11.0),
                image: DecorationImage(
                  image: isOdd(widget.index!),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          const Expanded(
                              flex: 1,
                              child: Text(
                                '3 Items',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontFamily: 'Gilroy'),
                              )),
                          Expanded(
                              flex: 1,
                              child: AutoSizeText(
                                widget.title.toString(),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontFamily: 'Gilroy'),
                                maxLines: 2,
                              )),
                          Expanded(
                              flex: 1,
                              child: Row(
                                children: const [
                                  Icon(
                                    Icons.people_alt,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'Metekucuk',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Gilroy'),
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ),
                    Expanded(
                        child: Column(
                      children: const [],
                    )),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
