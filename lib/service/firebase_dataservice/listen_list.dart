import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

class ListenList {
  final StreamController<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      _userListController =
      StreamController<List<QueryDocumentSnapshot<Map<String, dynamic>>>>();

  Stream<List<QueryDocumentSnapshot<Map<String, dynamic>>>> userListStream() {
    var data = FirebaseFirestore.instance.collection('lists').snapshots();

    data.listen((event) {
      _userListController.add(event.docs);
    });
    return _userListController.stream;
  }
}
