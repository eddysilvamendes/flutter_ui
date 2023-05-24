// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:cashier_app/model/menu.dart';
import 'package:cashier_app/utils/const.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentMenu = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: darkBlue,
        body: Row(
          children: [
            //Menu Section
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.horizontal(
                  right: Radius.circular(30),
                ),
                color: blue,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ...List.generate(
                    menus.length,
                    (index) => GestureDetector(
                      onTap: () {
                        setState(() {
                          currentMenu = index;
                        });
                      },
                      child: MenuItem(
                        menu: menus[index],
                        isActive: currentMenu == index ? true : false,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
