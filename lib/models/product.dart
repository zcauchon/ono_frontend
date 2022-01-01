class Product {
  late String productID;
  late String title;
  late String? description;
  late String price;
  late String? image;
  late String? quantity;
  late String? tags;

  Product(
      {required this.productID,
      required this.title,
      required this.price,
      this.description,
      this.image,
      this.quantity,
      this.tags});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      price: json['price']['N'].toString(),
      productID: json['productID']['S'].toString(),
      title: json['title']['S'].toString(),
      description: json['description']['S'].toString(),
      image: json['image']['S'].toString(),
      quantity: json['quantity']['N'].toString(),
    );
  }
}
