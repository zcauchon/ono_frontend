import 'package:flutter/material.dart';
import 'package:ono_frontend/models/cart.dart';
import 'package:ono_frontend/views/cartpage.dart';
import 'package:ono_frontend/views/homepage.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const OnoApp());
}

class OnoApp extends StatelessWidget {
  const OnoApp({Key? key}) : super(key: key);

  final title = 'Overnight Office';

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => CartModel()),
        ],
        child: MaterialApp(
          title: title,
          initialRoute: HomePage.homePageRoute,
          routes: {
            HomePage.homePageRoute: (context) => HomePage(title: title),
            CartPage.cartPageRoute: (context) => const CartPage(),
          },
          debugShowCheckedModeBanner: false,
        ));
  }
}
