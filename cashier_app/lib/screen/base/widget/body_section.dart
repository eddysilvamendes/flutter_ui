// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cashier_app/model/my_data.dart';
import 'package:cashier_app/screen/home/home_screen.dart';
import 'package:cashier_app/utils/const.dart';
import 'package:cashier_app/utils/size_config.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BodySection extends StatefulWidget {
  int currentMenu;
  final MyData data;
  BodySection({
    Key? key,
    required this.currentMenu,
    required this.data,
  }) : super(key: key);

  @override
  State<BodySection> createState() => _BodySectionState();
}

class _BodySectionState extends State<BodySection> {
  Widget body() {
    switch (widget.currentMenu) {
      case 0:
        return HomeScreen(
          data: widget.data,
        );
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
        return HomeScreen(
          data: widget.data,
        );
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
