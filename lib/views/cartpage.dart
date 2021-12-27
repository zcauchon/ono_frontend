import 'package:flutter/material.dart';
import 'package:ono_frontend/models/cart.dart';
import 'package:ono_frontend/views/ono_app_bar.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  static const String cartPageRoute = '/cart';

  @override
  Widget build(BuildContext context) {
    var cart = context.watch<CartModel>();

    return Scaffold(
      appBar: const OnoAppBar(title: 'Overnight Office'),
      body: cart.items.isNotEmpty
          ? Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: ListView.builder(
                itemCount: cart.items.length,
                itemBuilder: (context, index) => Center(
                  child: ListTile(
                    leading: Image.network(cart.items[index].product.image),
                    title: Text('\$${cart.items[index].product.title}'),
                    subtitle: Row(
                      children: [
                        Text(cart.items[index].quantity.toString()),
                        const Text(' @ \$'),
                        Text(cart.items[index].product.price),
                      ],
                    ),
                    trailing: TextButton(
                        onPressed: () {
                          cart.delete(cart.items[index]);
                        },
                        child: const Text('Remove')),
                  ),
                ),
              ),
            )
          : const Text('No Items in Cart'),
    );
  }
}
