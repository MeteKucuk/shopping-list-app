import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/items.dart';

class HomeService {
  final _firebaseFirestore = FirebaseFirestore.instance;

  static List<String> fruitItems = [];

  List<String> listofFruits = [];

  Future<Items> getFruits() async {
    var collection = _firebaseFirestore.collection('items');
    var document = collection.doc('list');

    var data = await document.get();

    var result = data.data();
    final items = Items.fromJson(result!);
    fruitItems = items.grocery.fruits;

    return items;
  }
}
