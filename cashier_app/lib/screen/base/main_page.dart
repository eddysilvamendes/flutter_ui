// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cashier_app/model/menu.dart';
import 'package:cashier_app/screen/base/dependences/body_section.dart';
import 'package:cashier_app/screen/base/dependences/menu_section.dart';
import 'package:cashier_app/utils/size_config.dart';
import 'package:flutter/material.dart';

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
    SizeConfig().init(context);
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

            const SizedBox(
              width: 20,
            ),
            //Body Section
            BodySection(currentMenu: currentMenu),
          ],
        ),
      ),
    );
  }
}
