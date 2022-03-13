class A101Product {
  String productName;
  String productPrice;
  String? productImage;

  A101Product(
      {required this.productName,
      required this.productPrice,
      String? productImage})
      : productImage = productImage ?? 'https://picsum.photos/200';
}
