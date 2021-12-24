import 'package:flutter/material.dart';

import 'cartpage.dart';
import 'header_link.dart';
import 'homepage.dart';

class OnoAppBar extends StatefulWidget implements PreferredSizeWidget {
  const OnoAppBar({
    Key? key,
    required this.title,
  })  : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize;
  final String title;

  @override
  State<OnoAppBar> createState() => _OnoAppBarState();
}

class _OnoAppBarState extends State<OnoAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
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
        const HeaderLink(title: 'Shop', destination: HomePage.homePageRoute),
        const HeaderLink(title: 'Services'),
        const HeaderLink(title: 'Consignment'),
        IconButton(
            onPressed: () {
              Navigator.popAndPushNamed(context, CartPage.cartPageRoute);
            },
            icon: const Icon(Icons.shopping_cart)),
      ],
    );
  }
}
