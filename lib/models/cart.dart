import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:ono_frontend/models/product.dart';

class CartModel extends ChangeNotifier {
  final List<Product> _items = [];

  UnmodifiableListView<Product> get items => UnmodifiableListView(_items);

  void add(Product item) {
    _items.add(item);
    notifyListeners();
  }

  void delete(Product item) {
    _items.remove(item);
  }
}
