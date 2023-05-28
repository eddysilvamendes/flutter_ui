import 'package:cashier_app/screen/home/home_screen.dart';
import 'package:cashier_app/utils/const.dart';
import 'package:cashier_app/utils/size_config.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BodySection extends StatefulWidget {
  int currentMenu;
  BodySection({super.key, required this.currentMenu});

  @override
  State<BodySection> createState() => _BodySectionState();
}

class _BodySectionState extends State<BodySection> {
  Widget body() {
    switch (widget.currentMenu) {
      case 0:
        return const HomeScreen();
      case 1:
        return const Center(
          child: Text(
            'Transaction',
            style: TextStyle(fontSize: 26),
          ),
        );
      case 2:
        return const Center(
          child: Text(
            'Cashier',
            style: TextStyle(fontSize: 26),
          ),
        );
      case 3:
        return const Center(
          child: Text(
            'Settings',
            style: TextStyle(fontSize: 26),
          ),
        );

      default:
        return const HomeScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.fromLTRB(0, 20, 20, 20),
      width: SizeConfig.screenWidth! * .9 - 8,
      height: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: bgColor,
      ),
      child: body(),
    );
  }
}
