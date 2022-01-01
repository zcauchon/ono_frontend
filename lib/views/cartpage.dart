import 'package:flutter/material.dart';
import 'package:ono_frontend/models/cart.dart';
import 'package:ono_frontend/views/ono_app_bar.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  static const String cartPageRoute = '/cart';

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var cart = context.watch<CartModel>();

    return Scaffold(
        appBar: const OnoAppBar(title: 'Overnight Office'),
        body: Center(
          child: Container(
            alignment: Alignment.topCenter,
            width: screenSize.width * .7,
            height: screenSize.height,
            padding: const EdgeInsets.all(10),
            child: cart.items.isNotEmpty
                ? Column(
                    children: [
                      SizedBox(
                        height: screenSize.height * .85,
                        child: ListView.builder(
                          itemCount: cart.items.length,
                          itemBuilder: (context, index) => ListTile(
                            leading: Image.network(
                              cart.items[index].product.image ?? '',
                              errorBuilder: (context, error, stackTrace) =>
                                  Image.asset(
                                      'images/default-product-image.png'),
                            ),
                            title: Text(cart.items[index].product.title),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('Total Price \$${cart.cartTotal()}'),
                          ElevatedButton(
                              onPressed: () => {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        behavior: SnackBarBehavior.floating,
                                        margin: EdgeInsets.all(10),
                                        content: Text(
                                            'Online Ordering Is Not Yet Supported'),
                                      ),
                                    )
                                  },
                              child: const Text('Checkout')),
                        ],
                      )
                    ],
                  )
                : const Text('No Items in Cart'),
          ),
        ));
  }
}
