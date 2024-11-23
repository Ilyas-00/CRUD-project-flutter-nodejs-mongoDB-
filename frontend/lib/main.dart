// chemin   : frontend/lib/screens/item_list.dart
import 'package:flutter/material.dart';
import 'screens/item_list.dart';
import 'screens/add_item.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter CRUD',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ItemList(),
      routes: {
        '/add-item': (context) => AddItemScreen(),
      },
    );
  }
}

