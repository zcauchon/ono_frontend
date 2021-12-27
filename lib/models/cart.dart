import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:ono_frontend/models/product.dart';

class CartModel extends ChangeNotifier {
  late Product product;
  late num quantity = 0;

  CartModel();
  CartModel.newProduct(this.product, this.quantity);

  final List<CartModel> _items = [];

  UnmodifiableListView<CartModel> get items => UnmodifiableListView(_items);

  void add(Product item) {
    CartModel existinItem = _items.firstWhere(
        (element) => element.product.title == item.title,
        orElse: () => CartModel());
    if (existinItem.quantity == 0) {
      _items.add(CartModel.newProduct(item, 1));
    } else {
      existinItem.quantity++;
    }
    notifyListeners();
  }

  void delete(CartModel item) {
    _items.remove(item);
    notifyListeners();
  }
}
