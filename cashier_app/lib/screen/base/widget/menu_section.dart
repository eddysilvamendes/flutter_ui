import 'package:cashier_app/model/menu.dart';
import 'package:cashier_app/utils/const.dart';
import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final Menu menu;
  final bool isActive;
  const MenuItem({
    Key? key,
    required this.menu,
    required this.isActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: 1,
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        decoration: BoxDecoration(
          color: isActive ? white : blue,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Icon(
              menu.icon,
              color: isActive ? blue : white,
            ),
            const SizedBox(width: 10),
            Text(
              menu.text,
              style: roboto.copyWith(
                color: isActive ? blue : white,
                fontSize: isActive ? 18 : 14,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
