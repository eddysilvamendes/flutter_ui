import 'package:cashier_app/model/category.dart';
import 'package:cashier_app/utils/const.dart';
import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    Key? key,
    required this.categories,
    required this.isActive,
  }) : super(key: key);

  final Categories categories;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 15),
      padding: const EdgeInsets.fromLTRB(10, 10, 35, 10),
      decoration: BoxDecoration(
        color: isActive ? lightBlue.withOpacity(.3) : white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: AssetImage(
                    'assets/${categories.image}',
                  ),
                  fit: BoxFit.cover),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            categories.text!,
            style: roboto.copyWith(
              fontSize: 16,
              color: lightBlue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
