import 'package:flutter/material.dart';
import 'package:ono_frontend/models/product.dart';
import 'package:ono_frontend/service/api_gateway.dart';
import 'package:ono_frontend/views/header_link.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;
  static const String homePageRoute = '/home';

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
      appBar: AppBar(
        title: TextButton(
          onPressed: () {},
          child: Text(
            widget.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
        actions: [
          const HeaderLink(
            title: 'Shop',
            active: true,
          ),
          const HeaderLink(title: 'Installation & Reconfigure'),
          const HeaderLink(title: 'Moving & Storage'),
          const HeaderLink(title: 'Service'),
          const HeaderLink(title: 'Delivery Services'),
          const HeaderLink(title: 'Consignment'),
          IconButton(onPressed: () {}, icon: const Icon(Icons.shopping_cart)),
        ],
      ),
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
                  (e) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Image.network(e.image),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            e.title,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text('\$${e.price}'),
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
