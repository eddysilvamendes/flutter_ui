// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cashier_app/model/menu.dart';
import 'package:cashier_app/model/my_data.dart';
import 'package:cashier_app/screen/base/widget/body_section.dart';
import 'package:cashier_app/screen/base/widget/menu_section.dart';
import 'package:cashier_app/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:cashier_app/utils/const.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _myBox = Hive.box('cashier_app');
  MyData data = MyData();
  @override
  void initState() {
    super.initState();
    if (_myBox.get('carts') == null) {
      data.initData();
    } else {
      data.loadData();
    }
  }

  @override
  void dispose() {
    Hive.box('carts').close();
    super.dispose();
  }

  int currentMenu = 0;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
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
          BodySection(currentMenu: currentMenu, data: data),
        ],
      ),
    );
  }
}
