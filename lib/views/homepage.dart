import 'package:flutter/material.dart';
import 'package:ono_frontend/models/cart.dart';
import 'package:ono_frontend/models/product.dart';
import 'package:ono_frontend/service/api_gateway.dart';
import 'package:provider/provider.dart';

import 'ono_app_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;
  static const String homePageRoute = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Product>> productList;
  @override
  void initState() {
    super.initState();
    productList = ApiGateway.getProductList();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: OnoAppBar(title: widget.title),
      body: FutureBuilder<List<Product>>(
        future: productList,
        builder: (ctx, snapshot) {
          if (snapshot.hasData) {
            return GridView.count(
              crossAxisCount: screenSize.width < 600
                  ? 1
                  : screenSize.width < 750
                      ? 2
                      : screenSize.width < 1100
                          ? 3
                          : 4,
              padding: const EdgeInsets.all(10.0),
              children: List.from(
                snapshot.data!.map(
                  (e) => Stack(
                    children: [
                      Expanded(
                        child: Image.network(e.image),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.white54),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      e.title,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Provider.of<CartModel>(context,
                                                listen: false)
                                            .add(e);
                                      },
                                      //add/remove from cart
                                      child: const Text(
                                        "Add",
                                      ),
                                    )
                                  ],
                                ),
                                Text('\$${e.price}'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error),
                  Text('Error: ${snapshot.error}'),
                ]);
          } else {
            return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Center(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  Text("Loading...")
                ]);
          }
        },
      ),
    );
  }
}
