import 'package:cashier_app/model/product.dart';
import 'package:cashier_app/utils/const.dart';
import 'package:drop_shadow/drop_shadow.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      width: 180,
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(20),
      ),
      //Product image and name
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Product Image
          Container(
            height: 180,
            width: 180,
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  offset: Offset(0, 8),
                  spreadRadius: 0,
                  blurRadius: 5,
                  color: bgColor,
                )
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: DropShadow(
                child: Image.asset(
                  'assets/${product.image}',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          //Product Text
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              product.name!,
              style: roboto.copyWith(
                fontSize: 18,
                color: black,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }
}
