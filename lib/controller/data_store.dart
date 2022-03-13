import 'dart:developer';

import '../model/a101_product.dart';
import '../service/scrapper/a101_scrapper.dart';

class DataStore {
  static final DataStore _dataStore = DataStore._();
  DataStore._();
  factory DataStore() => _dataStore;

  final List<A101Product> _fetchedProducts = [];

  Future<List<A101Product>> singletonFetch() async {
    if (_fetchedProducts.isNotEmpty) {
      return _fetchedProducts;
    }

    List<A101Product> a101Products = await A101Scrapper().fetchProduct();
    _fetchedProducts.addAll(a101Products);

    inspect(_fetchedProducts);

    return a101Products;
  }
}
