// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:togethershoplist/service/firebase_dataservice/listen_list.dart';
import 'package:togethershoplist/utils/constant.dart';

import 'customcard.dart';

class StreamUserList extends StatefulWidget {
  const StreamUserList({Key? key}) : super(key: key);

  @override
  _StreamUserListState createState() => _StreamUserListState();
}

class _StreamUserListState extends State<StreamUserList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<QueryDocumentSnapshot<Map<String, dynamic>>>>(
      stream: ListenList().userListStream(),
      builder: (BuildContext context,
          AsyncSnapshot<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
              snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }

        if (snapshot.data!.isEmpty) {
          return Column(
            children: [
              const Text(
                'Your list is Empty',
                style: TextStyle(
                    color: kColorOrange, fontFamily: 'Gilroy', fontSize: 35),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Create list and add them to your list \n for an eaiser communication ',
                style: TextStyle(
                    color: Colors.grey, fontSize: 18, fontFamily: 'Gilroy'),
              ),
              Lottie.network(
                'https://assets8.lottiefiles.com/packages/lf20_5ngs2ksb.json',
              ),
            ],
          );
        }

        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
/*             DateTime mytime = snapshot.data![index].data()['dataTime'].toDate();
            String month = DateConvert().dateCoverter(date: mytime.month); */

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(
                    flex: 3,
                    child: Padding(
                        padding: EdgeInsets.only(top: 25.0),
                        child: Center(
                          child: Text.rich(
                            TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                    text: "aa",
                                    style: TextStyle(
                                        fontFamily: 'Gilroy', fontSize: 31)),
                                TextSpan(
                                    text: "ds",
                                    style: TextStyle(
                                        fontFamily: 'Gilroy', fontSize: 18)),
                              ],
                            ),
                          ),
                        ))),
                Expanded(
                  flex: 27,
                  child: CustomCard(
                    index: index,
                    title: snapshot.data![index].id,
                  ),
                ),
              ],
            );
          },
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
        );
      },
    );
  }
}
