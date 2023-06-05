import 'package:cashier_app/utils/const.dart';
import 'package:flutter/material.dart';

class MySearch extends StatelessWidget {
  const MySearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(5),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(10), color: white),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: 'Enter item code',
          hintStyle: roboto.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: grey,
          ),
          prefixIcon: const Icon(Icons.search),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
