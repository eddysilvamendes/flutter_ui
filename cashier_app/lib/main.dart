import 'package:cashier_app/model/cart.dart';
import 'package:cashier_app/model/category.dart';
import 'package:cashier_app/model/menu.dart';
import 'package:cashier_app/model/product.dart';
import 'package:cashier_app/screen/base/main_page.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('cashier_app');

  Hive.registerAdapter(MenuAdapter());
  Hive.registerAdapter(CategoriesAdapter());
  Hive.registerAdapter(ProductAdapter());
  Hive.registerAdapter(CartAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}
