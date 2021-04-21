import 'package:boletin/network_data_source.dart';
import 'package:boletin/widgets/previews_screen.dart';
import 'package:flutter/material.dart';

final networkDataSource = NetworkDataSource();
void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PreviewsScreen(),
    );
  }
}
