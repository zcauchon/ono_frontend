import 'package:flutter/material.dart';
import 'package:ono_frontend/models/cart.dart';
import 'package:ono_frontend/views/ono_app_bar.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  static const String cartPageRoute = '/cart';

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    var cart = context.watch<CartModel>();

    return Scaffold(
      appBar: const OnoAppBar(title: 'Overnight Office'),
      body: cart.items.isNotEmpty
          ? ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (context, index) => Center(
                child: ListTile(
                  leading: Image.network(cart.items[index].image),
                  title: Text(cart.items[index].title),
                  subtitle: Text(cart.items[index].price),
                  trailing: TextButton(
                      onPressed: () {
                        setState(() {
                          cart.delete(cart.items[index]);
                        });
                      },
                      child: const Text('Remove')),
                ),
              ),
            )
          : const Text('No Items in Cart'),
    );
  }
}
