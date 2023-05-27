import 'package:cashier_app/utils/const.dart';
import 'package:cashier_app/utils/size_config.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Row(
      children: [
        //Product
        SizedBox(
          width: SizeConfig.screenWidth! * .6,
          height: double.infinity,
          child: Column(
            children: [
              Text.rich(TextSpan(
                style: const TextStyle(
                  fontSize: 24,
                  color: black,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  const TextSpan(text: 'Order No.'),
                  TextSpan(text: '5'.padLeft(3, '0')),
                ],
              )),
            ],
          ),
        ),
        //Cart
        Container(
          width: SizeConfig.screenWidth! * .3 - 6,
          height: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
