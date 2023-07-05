
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
        '//display': (context) => DisplayPage(userData: ModalRoute.of(context)!.settings.arguments as Map<String, String>),
      },
    );
  }
}

