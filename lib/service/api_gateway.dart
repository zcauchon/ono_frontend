import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ono_frontend/models/product.dart';

class ApiGateway {
  static const String apiBase = 'https://api.cauchon.io/ono';

  static Future<List<Product>> getProductList() async {
    final response = await http.get(
      Uri.parse('$apiBase/getproducts'),
    );
    if (response.statusCode == 200) {
      List<Product> productList = [];
      for (dynamic item in jsonDecode(response.body)['body']['Items']) {
        productList.add(Product.fromJson(item));
      }
      return productList;
    } else {
      throw Exception('Failed to load products');
    }
  }
}
