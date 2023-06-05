import 'package:cashier_app/model/cart.dart';
import 'package:cashier_app/utils/const.dart';
import 'package:cashier_app/utils/size_config.dart';
import 'package:cashier_app/widgets/fade_in_animation.dart';
import 'package:cashier_app/widgets/my_animation.dart';
import 'package:drop_shadow/drop_shadow.dart';
import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  final Cart cart;
  const CartItem({
    Key? key,
    required this.cart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SizedBox(
      width: SizeConfig.screenWidth! * .3 - 110,
      height: 70,
      child: Stack(
        children: [
          FadeInAnimation(
            durationInMs: 250,
            animatePosition: MyAnimation(
              leftBefore: -SizeConfig.screenWidth! * 0.3 - 110,
              leftAfter: 0,
            ),
            child: Container(
              width: SizeConfig.screenWidth! * .3 - 110,
              padding: const EdgeInsets.all(5),
              margin: const EdgeInsets.only(bottom: 5),
              decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: bgColor,
                      offset: Offset(2, 7),
                      spreadRadius: 0,
                      blurRadius: 5,
                    ),
                  ]),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: DropShadow(
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                      child: Image.asset(
                        'assets/${cart.product!.image}',
                        width: 30,
                        height: 30,
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cart.product!.name!,
                          style: roboto.copyWith(
                            fontSize: 16,
                            color: black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '\$${cart.product!.price}',
                          style: roboto.copyWith(
                            fontSize: 20,
                            color: black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: lightBlue.withOpacity(.1),
                          ),
                          child: const Icon(
                            Icons.remove,
                            color: blue,
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        cart.quantity.toString(),
                        style: roboto.copyWith(
                          fontSize: 22,
                          color: black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 5),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: lightBlue.withOpacity(.1),
                          ),
                          child: const Icon(
                            Icons.add,
                            color: blue,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
