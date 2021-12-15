import 'package:flutter/material.dart';
import 'package:ono_frontend/views/homepage.dart';

void main() {
  runApp(const OnoApp());
}

class OnoApp extends StatelessWidget {
  const OnoApp({Key? key}) : super(key: key);

  final title = 'Overnight Office';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(
        primaryColor: Colors.black,
      ),
      initialRoute: MyHomePage.homePageRoute,
      routes: {MyHomePage.homePageRoute: (context) => MyHomePage(title: title)},
      debugShowCheckedModeBanner: false,
    );
  }
}
