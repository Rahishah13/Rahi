// import 'package:flutter/material.dart';
// import 'package:task/form_page.dart';
// import 'package:task/display_page.dart';
// void main() {
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner:  false,
//     initialRoute: 'form_page',
//     routes: {
//       'form_page': (context)=>FormPage(),
//       'dispaly_page':(context)=>DisplayPage(),
//
//     },
//   ));
// }
import 'package:flutter/material.dart';
import 'form_page.dart';
import 'display_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Shared Preferences',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => FormPage(),
        '/display': (context) => DisplayPage(),
      },
    );
  }
}

