import 'package:flutter/material.dart';
import 'package:ono_frontend/views/adminpage.dart';

import 'cartpage.dart';
import 'header_link.dart';
import 'homepage.dart';

class OnoAppBar extends StatelessWidget implements PreferredSizeWidget {
  const OnoAppBar({
    Key? key,
    required this.title,
  })  : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize;
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: TextButton(
        onLongPress: () =>
            Navigator.popAndPushNamed(context, AdminPage.adminPageRoute),
        onPressed: () =>
            Navigator.popAndPushNamed(context, HomePage.homePageRoute),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
      actions: [
        const HeaderLink(title: 'Shop', destination: HomePage.homePageRoute),
        const HeaderLink(title: 'Services'),
        IconButton(
            onPressed: () {
              Navigator.popAndPushNamed(context, CartPage.cartPageRoute);
            },
            icon: const Icon(Icons.shopping_cart)),
      ],
    );
  }
}
