import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ono_frontend/views/homepage.dart';

class HeaderLink extends StatelessWidget {
  const HeaderLink(
      {Key? key, required this.title, this.destination, this.active = false})
      : super(key: key);

  final String title;
  final String? destination;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.popAndPushNamed(
            context, destination ?? HomePage.homePageRoute);
      },
      child: Text(
        title,
        style: TextStyle(
          fontWeight: active ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      style: TextButton.styleFrom(
        textStyle: const TextStyle(fontSize: 20),
        primary: Colors.white,
      ),
    );
  }
}
