// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cashier_app/model/cart.dart';
import 'package:cashier_app/model/category.dart';
import 'package:cashier_app/model/my_data.dart';
import 'package:cashier_app/model/product.dart';
import 'package:cashier_app/screen/cart/cart_item.dart';
import 'package:cashier_app/screen/category/category_item.dart';
import 'package:cashier_app/screen/home/widget/search.dart';
import 'package:cashier_app/screen/product/product_item.dart';
import 'package:cashier_app/utils/const.dart';
import 'package:cashier_app/utils/size_config.dart';
import 'package:cashier_app/widgets/fade_in_animation.dart';
import 'package:cashier_app/widgets/my_animation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  final MyData data;
  const HomeScreen({
    Key? key,
    required this.data,
  }) : super(key: key);

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
      margin: const EdgeInsets.only(right: 5),
      duration: const Duration(milliseconds: 500),
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

  addCart(Product product) {
    setState(() {
      if (widget.data.carts
              .indexWhere((element) => element.product == product) ==
          -1) {
        widget.data.carts.add(Cart(product: product, quantity: 1));
      } else {
        int qty;
        int index = widget.data.carts
            .indexWhere((element) => element.product == product);
        qty = widget.data.carts[index].quantity! + 1;
        removeCart(index);
        widget.data.carts.add(Cart(product: product, quantity: qty));
      }
      widget.data.updateData();
    });
  }

  void addQty(int index) {
    setState(() {
      widget.data.carts[index].quantity =
          widget.data.carts[index].quantity! + 1;
      widget.data.updateData();
    });
  }

  void reduceQty(int index) {
    setState(() {
      if (widget.data.carts[index].quantity! > 1) {
        widget.data.carts[index].quantity =
            widget.data.carts[index].quantity! - 1;
      } else {
        removeCart(index);
      }
      widget.data.updateData();
    });
  }

  void removeCart(int index) {
    setState(() {
      widget.data.carts.removeAt(index);
      widget.data.updateData();
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Row(
      children: [
        //Product
        SizedBox(
          width: SizeConfig.screenWidth! * .6,
          height: double.infinity,
          // Home Body
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
              const MySearch(),
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
                                : 8,
                            (index_) {
                              var newIndex = (currentProductPage * 8) + index_;
                              newIndex = newIndex > myProduct.length - 1
                                  ? myProduct.length - 1
                                  : newIndex;
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    carts.add(
                                      Cart(
                                        product: myProduct[newIndex],
                                        quantity: 1,
                                      ),
                                    );
                                  });
                                },
                                child: SizedBox(
                                  height: 230,
                                  width: 180,
                                  child: Stack(
                                    children: [
                                      FadeInAnimation(
                                        durationInMs: (index_ + 1) + 250,
                                        animatePosition: MyAnimation(
                                          topAfter: 0,
                                          topBefore: 230,
                                        ),
                                        child: ProductItem(
                                          product: myProduct[newIndex],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
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
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(
                                verticalDirection: VerticalDirection.up,
                                children: [
                                  ...List.generate(
                                    carts.length,
                                    (index) => Dismissible(
                                      key: Key(carts[index].product!.name!),
                                      onDismissed: (direction) {
                                        carts.removeAt(index);
                                      },
                                      child: CartItem(
                                        cart: carts[index],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
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
