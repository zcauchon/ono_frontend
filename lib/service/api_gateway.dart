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

  static Future<Product> getProduct(String productID) async {
    final response = await http.post(
      Uri.parse('$apiBase/getproduct/$productID'),
    );
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)['body']['Count'] == 0) {
        return Product(productID: '', title: '', price: '');
      } else {
        return Product.fromJson(jsonDecode(response.body)['body']['Items'][0]);
      }
    } else {
      throw Exception('Failed to load products');
    }
  }

  static Future<bool> createProduct(Product item) async {
    final response = await http.post(
      Uri.parse('$apiBase/createproduct'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'productID': item.productID,
        'title': item.title,
        'description': item.description ?? item.title,
        'price': item.price,
        'quantity': item.quantity ?? '1',
        'tags': item.tags ?? ''
      }),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> deleteProduct(String productID) async {
    final response =
        await http.delete(Uri.parse('$apiBase/deleteproduct/$productID'));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
