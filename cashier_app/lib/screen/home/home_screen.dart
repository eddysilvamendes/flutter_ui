// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:drop_shadow/drop_shadow.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:cashier_app/model/cart.dart';
import 'package:cashier_app/model/category.dart';
import 'package:cashier_app/model/product.dart';
import 'package:cashier_app/utils/const.dart';
import 'package:cashier_app/utils/size_config.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  bool moreCategory = false;
  int currentCategory = 0;
  int currentProductPage = 0;

  DateTime now = DateTime.now();
  PageController controller = PageController();

  AnimatedContainer indicator({int? index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      height: 5,
      width: currentProductPage == index ? 30 : 5,
      decoration: BoxDecoration(
        color: currentProductPage == index ? blue : white,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  List<Cart> carts = [];
  List<Product> myProduct = products;
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
              //Order and date
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text.rich(
                    TextSpan(
                      style: roboto.copyWith(
                        fontSize: 24,
                        color: black,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        const TextSpan(text: 'Order No.'),
                        TextSpan(
                          text: '5'.padLeft(3, '0'),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    DateFormat('EEE d MMM y, hh:mm aa').format(now),
                    style: roboto.copyWith(fontSize: 18, color: grey),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              //Search Bar
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), color: white),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Enter item code',
                    hintStyle: roboto.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: grey,
                    ),
                    prefixIcon: const Icon(Icons.search),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              //Indicator and Txt
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //Indicator
                  Row(
                    children: [
                      ...List.generate(
                        (myProduct.length / 8).ceil(),
                        (index) => indicator(index: index),
                      ),
                    ],
                  ),
                  Text(
                    ' ${(currentProductPage + 1) * 8 > myProduct.length ? myProduct.length : (currentProductPage + 1) * 8} of ${myProduct.length}',
                    style: roboto.copyWith(
                      fontSize: 16,
                      color: grey,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              //Product Page View
              Expanded(
                child: PageView(
                  controller: controller,
                  onPageChanged: (value) {
                    setState(() => currentProductPage = value);
                  },
                  children: [
                    //Product list pagination
                    ...List.generate(
                      (myProduct.length / 8).ceil(),
                      (index) => Wrap(
                        runSpacing: 15,
                        spacing: 15,
                        children: [
                          ...List.generate(
                              index == (myProduct.length / 8).ceil() - 1
                                  ? myProduct.length % 8
                                  : 8, (index_) {
                            var newIndex = (currentProductPage * 8) + index_;
                            newIndex = newIndex > myProduct.length - 1
                                ? myProduct.length - 1
                                : newIndex;
                            return ProductItem(
                              product: myProduct[newIndex],
                            );
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              //Category Item
              Container(
                width: SizeConfig.screenWidth! * .6,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: SizeConfig.screenWidth! * 0.6 - 100,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            ...List.generate(
                              moreCategory == true ? categories.length : 3,
                              (index) => GestureDetector(
                                onTap: () {
                                  setState(() {
                                    currentCategory = index;
                                    myProduct = products
                                        .where((element) => element.category!
                                            .contains(categories[index]))
                                        .toList();
                                    if (controller.hasClients) {
                                      controller.animateToPage(
                                        0,
                                        duration:
                                            const Duration(microseconds: 500),
                                        curve: Curves.easeInOut,
                                      );
                                    }
                                  });
                                },
                                child: CategoryItem(
                                  categories: categories[index],
                                  isActive:
                                      currentCategory == index ? true : false,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          moreCategory = !moreCategory;
                        });
                      },
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                            color: blue,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: lightBlue.withOpacity(.5),
                                  offset: const Offset(0, 10),
                                  spreadRadius: 0,
                                  blurRadius: 5)
                            ]),
                        child: Icon(
                          moreCategory == true ? Icons.close : Icons.more_horiz,
                          color: white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        //Cart
        Container(
          padding: const EdgeInsets.only(top: 15),
          width: SizeConfig.screenWidth! * .3 - 80,
          height: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Column(
            children: [
              //Cart Title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Cart',
                      style: roboto.copyWith(
                        fontSize: 28,
                        color: black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    carts.isNotEmpty
                        ? GestureDetector(
                            onTap: () {},
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.red.withOpacity(.2),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: const Icon(
                                Icons.close,
                                color: Colors.red,
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
              //Cart Content
              carts.isNotEmpty
                  ? Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                ...List.generate(
                                  carts.length,
                                  (index) => CartItem(cart: carts[index]),
                                ),
                              ],
                            ),
                          ),
                          //Sub Total and Tax
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              children: [
                                //Sub Total
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Sub Total',
                                      style: roboto.copyWith(
                                        fontSize: 18,
                                        color: black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      '\$1200',
                                      style: roboto.copyWith(
                                        fontSize: 18,
                                        color: black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                //Tax
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Tax',
                                      style: roboto.copyWith(
                                        fontSize: 18,
                                        color: black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      '\$100',
                                      style: roboto.copyWith(
                                        fontSize: 18,
                                        color: black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          //Total
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const [
                                BoxShadow(
                                    color: bgColor,
                                    spreadRadius: 0,
                                    blurRadius: 5,
                                    offset: Offset(0, -10))
                              ],
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Total',
                                      style: roboto.copyWith(
                                        fontSize: 28,
                                        color: black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      '\$1300',
                                      style: roboto.copyWith(
                                        fontSize: 28,
                                        color: black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                              ],
                            ),
                          ),
                          //CheckOut Button
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: blue,
                              boxShadow: [
                                BoxShadow(
                                    color: lightBlue.withOpacity(.3),
                                    offset: const Offset(0, 10),
                                    spreadRadius: 0,
                                    blurRadius: 10),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                'CHECKOUT',
                                style: roboto.copyWith(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: white,
                                ),
                              ),
                            ),
                          ),
                          /* const SizedBox(height: 10),
               Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: white,
                  boxShadow: const [
                    BoxShadow(
                        color: bgColor,
                        offset: Offset(0, 10),
                        spreadRadius: 0,
                        blurRadius: 10),
                  ],
                ),
                child: Center(
                  child: Text(
                    'PENDING',
                    style: roboto.copyWith(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: blue,
                    ),
                  ),
                ),
              ),*/
                        ],
                      ),
                    )
                  : Expanded(
                      child: Center(
                        child: Text(
                          'Empty',
                          style: roboto.copyWith(
                            fontSize: 32,
                            color: black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ],
    );
  }
}

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
    );
  }
}

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

class ProductItem extends StatelessWidget {
  const ProductItem({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      width: 180,
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(20),
      ),
      //Product image and name
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Product Image
          Container(
            height: 180,
            width: 180,
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  offset: Offset(0, 8),
                  spreadRadius: 0,
                  blurRadius: 5,
                  color: bgColor,
                )
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: DropShadow(
                child: Image.asset(
                  'assets/${product.image}',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          //Product Text
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              product.name!,
              style: roboto.copyWith(
                fontSize: 18,
                color: black,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }
}
