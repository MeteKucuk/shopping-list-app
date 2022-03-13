import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/home_controller.dart';
import 'itemcard.dart';
import '../../service/firebase_dataservice/listen_item.dart';

class StreamUserListItem extends StatefulWidget {
  final String listName;
  const StreamUserListItem({
    Key? key,
    required this.listName,
  }) : super(key: key);

  @override
  State<StreamUserListItem> createState() => _StreamUserListItemState();
}

class _StreamUserListItemState extends State<StreamUserListItem> {
  final HomeController homeController = Get.find<HomeController>();

  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>?>>(
      builder: (context,
          AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>?>> snapshot) {
        if (snapshot.hasData) {
          final data = (snapshot.data!.data()?["content"].values).toList();

          final isTrue =
              data.where((element) => element["isDone"] == true).toList();
          final isFalse =
              data.where((element) => element["isDone"] == false).toList();
          return Column(
            children: [
              Column(
                children: [
                  const Text(
                    'To Buy',
                    style: TextStyle(fontFamily: 'Gilroy', fontSize: 20),
                  ),
                  ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ItemCard(
                        isDone: isFalse[index]["isDone"],
                        title: isFalse[index]["name"],
                      );
                    },
                    itemCount: isFalse.length,
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Column(
                children: [
                  const Text(
                    'Bought',
                    style: TextStyle(fontFamily: 'Gilroy', fontSize: 20),
                  ),
                  ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ItemCard(
                        isDone: isTrue[index]["isDone"],
                        title: isTrue[index]["name"],
                      );
                    },
                    itemCount: isTrue.length,
                  ),
                ],
              ),
            ],
          );
        } else {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width * 0.9,
          );
        }
      },
      stream: ListenItem().userItemStream(homeController.listName.value),
    );
  }
}
