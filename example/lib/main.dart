import 'package:deposits_ecommerce/app/common/utils/exports.dart';
import 'package:example/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    dotenv.load();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Deposts Commerce Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) =>const MyHomePage(title: 'Deposits Commerce Example Home Page'),
      },
    );
  }
}
