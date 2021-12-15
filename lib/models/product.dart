class Product {
  late String productID;
  late String title;
  late String? description;
  late String price;
  late String image;

  Product(
      {required this.productID,
      required this.title,
      this.description,
      required this.price,
      this.image = ''});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      price: json['price']['N'].toString(),
      productID: json['productID']['S'].toString(),
      title: json['title']['S'].toString(),
      description: json['description']['S'].toString(),
      image: json['image']['S'].toString(),
    );
  }
}
