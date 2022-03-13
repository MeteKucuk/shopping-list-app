import 'package:web_scraper/web_scraper.dart';

import '../../model/a101_product.dart';

class A101Scrapper {
  final webScraper = WebScraper('https://www.a101.com.tr');

  List<A101Product> products = [];

  Future<List<A101Product>> fetchProduct() async {
    List<Map<String, dynamic>>? product;
    List<Map<String, dynamic>>? productName;
    List<Map<String, dynamic>>? productImage;
    if (await webScraper.loadWebPage('/market/cips-cerez/')) {
      product = webScraper.getElement(
          'div.products-list > div> ul > li > article > a > div.product-desc > section.prices > span.current  ',
          ['class']);

      productName = webScraper.getElement(
          'div.products-list > div> ul > li > article > a> div.product-desc  >  header > hgroup > h3.name ',
          ['class']);

      productImage = webScraper.getElement(
          ' div.products-list > div > ul > li > article > div > a > figure.product-image > img  ',
          ['data-src']);
      for (int i = 0; i < product.length; i++) {
        products.add(A101Product(
            productName: (productName[i]['title'] as String).trim(),
            productPrice: (product[i]['title'] as String).replaceAll(' ', ''),
            productImage:
                (productImage[i]['attributes']['data-src'] as String).trim()));
      }
    }
    return products;
  }
}
