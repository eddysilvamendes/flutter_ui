// ignore_for_file: public_member_api_docs, sort_constructors_first
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
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: darkBlue,
        body: Row(
          children: [
            //Menu Section
            const MenuSection(),
            //Body Section
            Container(
              width: SizeConfig.screenWidth! * .5,
              height: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
