import 'package:flutter/material.dart';
import 'package:ono_frontend/views/adminpage.dart';

import 'header_link.dart';
import 'homepage.dart';

class AdminAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AdminAppBar({
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
          '$title - Admin',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
      actions: const [
        HeaderLink(
            title: 'Product Management', destination: HomePage.homePageRoute),
        HeaderLink(title: 'Sales')
      ],
    );
  }
}
