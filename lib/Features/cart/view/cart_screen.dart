import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sv_craft/Features/cart/controllar/cart_controller.dart';
import 'package:sv_craft/Features/cart/controllar/delete_item_con.dart';
import 'package:sv_craft/Features/cart/view/checkout_screen.dart';
import 'package:sv_craft/Features/cart/view/widgets/grocery_cart_count.dart';
import 'package:sv_craft/Features/home/bottom_bar.dart';
import 'package:sv_craft/Features/home/controller/home_controller.dart';
import 'package:sv_craft/Features/home/home_screen.dart';
import 'package:sv_craft/Features/profile/controller/get_address_con.dart';
import 'package:sv_craft/Features/profile/view/address_page.dart';
import 'package:sv_craft/Features/profile/view/profile_screen.dart';
import 'package:sv_craft/constant/api_link.dart';

import '../../../constant/color.dart';
import 'widgets/cart_list_tile.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final HomeController _homeController = Get.put(HomeController());
  final CartController _cartController = Get.put(CartController());
  final CartItemDeleteController _cartItemDeleteController =
      Get.put(CartItemDeleteController());
  GetAddressController _getAddressController = Get.put(GetAddressController());
  bool _isLoading = true;
  var cartData;
  // var totalPrice = 0.0;
  var _selectedIndex = 1;
  PageController? _pageController;

  var itemCount = 0;

  var Address;
  var totalPrice = 0;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      setTokenToVariable();
    });

    Future.delayed(Duration(microseconds: 500), () async {
      setState(() {
        _isLoading = false;
      });
    });
  }

  Future<void> setTokenToVariable() async {
    final data = await _cartController.getCartProduct(
        _homeController.tokenGlobal, _homeController.userId);
    if (data != null) {
      setState(() {
        cartData = data;
      });

      // if (cartData.grocery.length > 0) {
      //   for (int i = 0; i < cartData.grocery.length; i++) {
      //     totalPrice += cartData.grocery[i].price;
      //   }
      // }

      // if (cartData.special_day.length > 0) {
      //   for (int i = 0; i < cartData.special_day.length; i++) {
      //     totalPrice += cartData.special_day[i].price;
      //   }
      // }
    }

    var address =
        await _getAddressController.getAddress(_homeController.tokenGlobal);
    if (address != null) {
      setState(() {
        Address = address;
      });
    }
  }

  List select = [];
  List<bool> selected = <bool>[];
  getindex(int itemCount) {
    for (var i = 0; i < itemCount; i++) {
      selected.add(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
        return Future.value(false);
      },
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: cartData != null
                ? Column(
                    children: [
                      Container(
                        height: size.height * .27,
                        width: size.width,
                        // color: Colors.red,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 30),
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Varukorg (37)",
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              const Text(
                                "Neque porro quisquam est qui dolorem ipsum quia dolor sit amet.",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black54),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(0),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black12, //color of shadow
                                        spreadRadius: 1, //spread radius
                                        blurRadius: 0, // blur radius
                                        offset: Offset(
                                            0, 0), // changes position of shadow
                                        //first paramerter of offset is left-right
                                        //second parameter is top to down
                                      )
                                    ],
                                  ),
                                  width: size.width,
                                  height: 50,
                                  child: const Text(
                                    'Hantera ersattnongsvaror',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 18),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      cartData.grocery.length > 0
                          ? Column(
                              children: [
                                Container(
                                  color: Color.fromARGB(31, 134, 129, 129),
                                  height: 40,
                                  child: Row(
                                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: const [
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Grocery Products",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black87),
                                      ),
                                      Spacer(),
                                      SizedBox(
                                        width: 10,
                                      ),
                                    ],
                                  ),
                                ),
                                ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: cartData.grocery.length,
                                    itemBuilder: (context, index) {
                                      var singleGroceryPrice =
                                          cartData.grocery[index].price /
                                              cartData.grocery[index].quantity;

                                      totalPrice = cartData.totalPrice;

                                      getindex(cartData.grocery.length);
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: Container(
                                          // key: ValueKey(myProducts[index]),
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 0),
                                          child: Column(
                                            children: [
                                              Container(
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      height: 100,
                                                      width: size.width / 6,
                                                      // color: Colors.redAccent,
                                                      child: Image.network(
                                                        '${Appurl.baseURL}${cartData.grocery[index].image}',
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    Container(
                                                      height: 100,
                                                      width: size.width / 2.8,
                                                      //color: Colors.black87,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10.0),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              cartData
                                                                  .grocery[
                                                                      index]
                                                                  .name,
                                                              style: TextStyle(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: Colors
                                                                      .black54),
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                            Text(
                                                              'Price : ${singleGroceryPrice.toString()} kr',
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300,
                                                                  color: Colors
                                                                      .black54),
                                                            ),
                                                            // Text(
                                                            //   "Price in kr",
                                                            //   style: TextStyle(
                                                            //       fontSize: 16,
                                                            //       fontWeight: FontWeight.w300,
                                                            //       color: Colors.black54),
                                                            // ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                          color: Color.fromARGB(
                                                              31,
                                                              145,
                                                              140,
                                                              140),
                                                          width: 1,
                                                        ),
                                                      ),
                                                      height: 74,
                                                      width: size.width / 5,
                                                      //color: Colors.redAccent,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          //cartData.grocery[index].quantity.toString()
                                                          Text(
                                                              cartData
                                                                      .grocery[
                                                                          index]
                                                                      .quantity
                                                                      .toString() +
                                                                  'st',
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: Colors
                                                                    .black54,
                                                              ),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center),
                                                          Spacer(),

                                                          //////deeeeeeffffff
                                                          /////frfff
                                                          Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              cartData.grocery[index]
                                                                          .quantity >
                                                                      1
                                                                  ? InkWell(
                                                                      onTap:
                                                                          () {
                                                                        setState(
                                                                            () {
                                                                          //Product count
                                                                          cartData.grocery[index].quantity > 1
                                                                              ? cartData.grocery[index].quantity = (cartData.grocery[index].quantity) - 1
                                                                              : null;

                                                                          //Item price total
                                                                          cartData
                                                                              .grocery[index]
                                                                              .price = cartData.grocery[index].quantity * singleGroceryPrice.toInt();

                                                                          //Total price
                                                                          cartData.grocery[index].quantity >= 1 && cartData.totalPrice > 0
                                                                              ? cartData.totalPrice = cartData.totalPrice - (cartData.grocery[index].price / cartData.grocery[index].quantity).toInt()
                                                                              : null;
                                                                        });
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        padding:
                                                                            const EdgeInsets.all(5),
                                                                        alignment:
                                                                            Alignment.center,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color: Color.fromARGB(
                                                                              220,
                                                                              245,
                                                                              243,
                                                                              243),
                                                                          borderRadius:
                                                                              BorderRadius.circular(0),
                                                                          boxShadow: const [
                                                                            BoxShadow(
                                                                              color: Colors.black12, //color of shadow
                                                                              spreadRadius: 1, //spread radius
                                                                              blurRadius: 0, // blur radius
                                                                              offset: Offset(0, 0), // changes position of shadow
                                                                              //first paramerter of offset is left-right
                                                                              //second parameter is top to down
                                                                            )
                                                                          ],
                                                                        ),
                                                                        width:
                                                                            35,
                                                                        height:
                                                                            35,
                                                                        child:
                                                                            const Text(
                                                                          '-',
                                                                          style: TextStyle(
                                                                              color: Colors.black54,
                                                                              fontSize: 20),
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                        ),
                                                                      ),
                                                                    )
                                                                  : Container(),
                                                              SizedBox(
                                                                height: 2,
                                                              ),
                                                              InkWell(
                                                                onTap: () {
                                                                  setState(() {
                                                                    cartData
                                                                        .grocery[
                                                                            index]
                                                                        .quantity = (cartData
                                                                            .grocery[index]
                                                                            .quantity) +
                                                                        1;

                                                                    //Item price total
                                                                    cartData
                                                                        .grocery[
                                                                            index]
                                                                        .price = (cartData
                                                                            .grocery[
                                                                                index]
                                                                            .price) +
                                                                        singleGroceryPrice
                                                                            .toInt();

                                                                    //Total price
                                                                    cartData
                                                                        .totalPrice = cartData
                                                                            .totalPrice +
                                                                        (cartData.grocery[index].price /
                                                                                cartData.grocery[index].quantity)
                                                                            .toInt();

                                                                    print(cartData
                                                                        .totalPrice);
                                                                  });
                                                                },
                                                                child:
                                                                    Container(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(5),
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            220,
                                                                            245,
                                                                            243,
                                                                            243),
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(0),
                                                                    boxShadow: const [
                                                                      BoxShadow(
                                                                        color: Colors
                                                                            .black12, //color of shadow
                                                                        spreadRadius:
                                                                            1, //spread radius
                                                                        blurRadius:
                                                                            0, // blur radius
                                                                        offset: Offset(
                                                                            0,
                                                                            0), // changes position of shadow
                                                                        //first paramerter of offset is left-right
                                                                        //second parameter is top to down
                                                                      )
                                                                    ],
                                                                  ),
                                                                  width: 35,
                                                                  height: 35,
                                                                  child:
                                                                      const Text(
                                                                    '+',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black54,
                                                                        fontSize:
                                                                            20),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      height: 100,
                                                      width: size.width / 4,
                                                      // color: Colors.blue,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        children: [
                                                          IconButton(
                                                            onPressed:
                                                                () async {
                                                              var responce =
                                                                  await _cartItemDeleteController
                                                                      .cartItemDelete(
                                                                _homeController
                                                                    .tokenGlobal,
                                                                _homeController
                                                                    .userId,
                                                                cartData
                                                                    .grocery[
                                                                        index]
                                                                    .id,
                                                                'grocery',
                                                              );
                                                              setState(() {});

                                                              if (responce !=
                                                                  null) {
                                                                setState(() {});
                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              CartScreen()),
                                                                );

                                                                print(
                                                                    "Item deleted");
                                                              } else {
                                                                setState(() {});
                                                                print(
                                                                    "Item not deleted");
                                                              }
                                                            },
                                                            icon: Icon(
                                                                Icons.delete),
                                                            color: Colors.red,
                                                          ),
                                                          Text(
                                                            "${cartData.grocery[index].price.toString()} kr",
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: Colors
                                                                    .black54),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                              ],
                            )
                          : Container(),

                      cartData.special_day.length > 0
                          ? Column(
                              children: [
                                Container(
                                  color: Color.fromARGB(31, 134, 129, 129),
                                  height: 40,
                                  child: Row(
                                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: const [
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "special_day Products",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black87),
                                      ),
                                      Spacer(),
                                      // Text(
                                      //   "SUMMA",
                                      //   style: TextStyle(
                                      //       fontSize: 20,
                                      //       fontWeight: FontWeight.w500,
                                      //       color: Colors.black87),
                                      // ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                    ],
                                  ),
                                ),
                                ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: cartData.special_day.length,
                                    itemBuilder: (context, index) {
                                      var singlespecial_dayPrice = cartData
                                              .special_day[index].price /
                                          cartData.special_day[index].quantity;

                                      totalPrice = cartData.totalPrice;

                                      getindex(cartData.special_day.length);
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: Container(
                                          // key: ValueKey(myProducts[index]),
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 0),
                                          child: Column(
                                            children: [
                                              Container(
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      height: 100,
                                                      width: size.width / 6,
                                                      // color: Colors.redAccent,
                                                      child: Image.network(
                                                        '${Appurl.baseURL}${cartData.special_day[index].image}',
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    Container(
                                                      height: 100,
                                                      width: size.width / 2.8,
                                                      //color: Colors.black87,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10.0),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              cartData
                                                                  .special_day[
                                                                      index]
                                                                  .name,
                                                              style: TextStyle(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: Colors
                                                                      .black54),
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                            Text(
                                                              'Price : ${singlespecial_dayPrice.toString()} kr',
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300,
                                                                  color: Colors
                                                                      .black54),
                                                            ),
                                                            // Text(
                                                            //   "Price in kr",
                                                            //   style: TextStyle(
                                                            //       fontSize: 16,
                                                            //       fontWeight: FontWeight.w300,
                                                            //       color: Colors.black54),
                                                            // ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                          color: Color.fromARGB(
                                                              31,
                                                              145,
                                                              140,
                                                              140),
                                                          width: 1,
                                                        ),
                                                      ),
                                                      height: 74,
                                                      width: size.width / 5,
                                                      //color: Colors.redAccent,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          //cartData.special_day[index].quantity.toString()
                                                          Text(
                                                              cartData
                                                                      .special_day[
                                                                          index]
                                                                      .quantity
                                                                      .toString() +
                                                                  'st',
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: Colors
                                                                    .black54,
                                                              ),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center),
                                                          Spacer(),

                                                          //////deeeeeeffffff
                                                          /////frfff
                                                          Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              cartData.special_day[index]
                                                                          .quantity >
                                                                      1
                                                                  ? InkWell(
                                                                      onTap:
                                                                          () {
                                                                        setState(
                                                                            () {
                                                                          //Product count
                                                                          cartData.special_day[index].quantity > 1
                                                                              ? cartData.special_day[index].quantity = (cartData.special_day[index].quantity) - 1
                                                                              : null;

                                                                          //Item price total
                                                                          cartData
                                                                              .special_day[index]
                                                                              .price = cartData.special_day[index].quantity * singlespecial_dayPrice.toInt();

                                                                          //  Total price
                                                                          cartData.special_day[index].quantity >= 1 && cartData.totalPrice > 0
                                                                              ? cartData.totalPrice = cartData.totalPrice - (cartData.special_day[index].price / cartData.special_day[index].quantity).toInt()
                                                                              : null;
                                                                        });
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        padding:
                                                                            const EdgeInsets.all(5),
                                                                        alignment:
                                                                            Alignment.center,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color: Color.fromARGB(
                                                                              220,
                                                                              245,
                                                                              243,
                                                                              243),
                                                                          borderRadius:
                                                                              BorderRadius.circular(0),
                                                                          boxShadow: const [
                                                                            BoxShadow(
                                                                              color: Colors.black12, //color of shadow
                                                                              spreadRadius: 1, //spread radius
                                                                              blurRadius: 0, // blur radius
                                                                              offset: Offset(0, 0), // changes position of shadow
                                                                              //first paramerter of offset is left-right
                                                                              //second parameter is top to down
                                                                            )
                                                                          ],
                                                                        ),
                                                                        width:
                                                                            35,
                                                                        height:
                                                                            35,
                                                                        child:
                                                                            const Text(
                                                                          '-',
                                                                          style: TextStyle(
                                                                              color: Colors.black54,
                                                                              fontSize: 20),
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                        ),
                                                                      ),
                                                                    )
                                                                  : Container(),
                                                              SizedBox(
                                                                height: 2,
                                                              ),
                                                              InkWell(
                                                                onTap: () {
                                                                  setState(() {
                                                                    cartData
                                                                        .special_day[
                                                                            index]
                                                                        .quantity = (cartData
                                                                            .special_day[index]
                                                                            .quantity) +
                                                                        1;

                                                                    //Item price total
                                                                    cartData
                                                                        .special_day[
                                                                            index]
                                                                        .price = (cartData
                                                                            .special_day[
                                                                                index]
                                                                            .price) +
                                                                        singlespecial_dayPrice
                                                                            .toInt();

                                                                    //Total price
                                                                    cartData
                                                                        .totalPrice = cartData
                                                                            .totalPrice +
                                                                        (cartData.special_day[index].price /
                                                                                cartData.special_day[index].quantity)
                                                                            .toInt();

                                                                    print(cartData
                                                                        .totalPrice);
                                                                  });
                                                                },
                                                                child:
                                                                    Container(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(5),
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            220,
                                                                            245,
                                                                            243,
                                                                            243),
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(0),
                                                                    boxShadow: const [
                                                                      BoxShadow(
                                                                        color: Colors
                                                                            .black12, //color of shadow
                                                                        spreadRadius:
                                                                            1, //spread radius
                                                                        blurRadius:
                                                                            0, // blur radius
                                                                        offset: Offset(
                                                                            0,
                                                                            0), // changes position of shadow
                                                                        //first paramerter of offset is left-right
                                                                        //second parameter is top to down
                                                                      )
                                                                    ],
                                                                  ),
                                                                  width: 35,
                                                                  height: 35,
                                                                  child:
                                                                      const Text(
                                                                    '+',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black54,
                                                                        fontSize:
                                                                            20),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      height: 100,
                                                      width: size.width / 4,
                                                      // color: Colors.blue,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        children: [
                                                          IconButton(
                                                            onPressed:
                                                                () async {
                                                              var responce =
                                                                  await _cartItemDeleteController
                                                                      .cartItemDelete(
                                                                _homeController
                                                                    .tokenGlobal,
                                                                _homeController
                                                                    .userId,
                                                                cartData
                                                                    .special_day[
                                                                        index]
                                                                    .id,
                                                                'special_day',
                                                              );
                                                              setState(() {});

                                                              if (responce !=
                                                                  null) {
                                                                setState(() {});
                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              CartScreen()),
                                                                );

                                                                print(
                                                                    "Item deleted");
                                                              } else {
                                                                setState(() {});
                                                                print(
                                                                    "Item not deleted");
                                                              }
                                                            },
                                                            icon: Icon(
                                                                Icons.delete),
                                                            color: Colors.red,
                                                          ),
                                                          Text(
                                                            "${cartData.special_day[index].price.toString()} kr",
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: Colors
                                                                    .black54),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                              ],
                            )
                          : Container(),

                      // //cartData.special_day != null
                      // cartData.special_day.length > 0
                      //     ? Column(
                      //         children: [
                      //           Container(
                      //             color: Color.fromARGB(31, 134, 129, 129),
                      //             height: 40,
                      //             child: Row(
                      //               //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //               children: const [
                      //                 SizedBox(
                      //                   width: 10,
                      //                 ),
                      //                 Text(
                      //                   "Special Day Products",
                      //                   style: TextStyle(
                      //                       fontSize: 20,
                      //                       fontWeight: FontWeight.w500,
                      //                       color: Colors.black87),
                      //                 ),
                      //                 Spacer(),
                      //                 // Text(
                      //                 //   "SUMMA",
                      //                 //   style: TextStyle(
                      //                 //       fontSize: 20,
                      //                 //       fontWeight: FontWeight.w500,
                      //                 //       color: Colors.black87),
                      //                 // ),
                      //                 SizedBox(
                      //                   width: 10,
                      //                 ),
                      //               ],
                      //             ),
                      //           ),
                      //           ListView.builder(
                      //               physics: NeverScrollableScrollPhysics(),
                      //               shrinkWrap: true,
                      //               itemCount: cartData.special_day.length,
                      //               itemBuilder: (context, index) {
                      //                 var singleSpecialPrice =
                      //                     cartData.special_day[index].price /
                      //                         int.parse(cartData
                      //                             .special_day[index].quantity);
                      //                 return Padding(
                      //                   padding: const EdgeInsets.symmetric(
                      //                       horizontal: 5),
                      //                   child: Container(
                      //                     // key: ValueKey(myProducts[index]),
                      //                     margin: const EdgeInsets.symmetric(
                      //                         vertical: 5, horizontal: 0),
                      //                     child: Column(
                      //                       children: [
                      //                         Container(
                      //                           child: Row(
                      //                             children: [
                      //                               Container(
                      //                                 height: 100,
                      //                                 width: size.width / 6,
                      //                                 // color: Colors.redAccent,
                      //                                 child: Image.network(
                      //                                   '${Appurl.baseURL}${cartData.special_day[index].image}',
                      //                                   fit: BoxFit.cover,
                      //                                 ),
                      //                               ),
                      //                               Container(
                      //                                 height: 100,
                      //                                 width: size.width / 2.8,
                      //                                 //color: Colors.black87,
                      //                                 child: Padding(
                      //                                   padding:
                      //                                       const EdgeInsets
                      //                                           .all(10.0),
                      //                                   child: Column(
                      //                                     crossAxisAlignment:
                      //                                         CrossAxisAlignment
                      //                                             .start,
                      //                                     children: [
                      //                                       Text(
                      //                                         cartData
                      //                                             .special_day[
                      //                                                 index]
                      //                                             .name,
                      //                                         style: TextStyle(
                      //                                             fontSize: 18,
                      //                                             fontWeight:
                      //                                                 FontWeight
                      //                                                     .w500,
                      //                                             color: Colors
                      //                                                 .black54),
                      //                                         overflow:
                      //                                             TextOverflow
                      //                                                 .ellipsis,
                      //                                         maxLines: 2,
                      //                                       ),
                      //                                       Text(
                      //                                         'Price : ${singleSpecialPrice.toString()} kr',
                      //                                         style: TextStyle(
                      //                                             fontSize: 16,
                      //                                             fontWeight:
                      //                                                 FontWeight
                      //                                                     .w300,
                      //                                             color: Colors
                      //                                                 .black54),
                      //                                       ),
                      //                                       // Text(
                      //                                       //   "Price in kr",
                      //                                       //   style: TextStyle(
                      //                                       //       fontSize: 16,
                      //                                       //       fontWeight: FontWeight.w300,
                      //                                       //       color: Colors.black54),
                      //                                       // ),
                      //                                     ],
                      //                                   ),
                      //                                 ),
                      //                               ),
                      //                               Container(
                      //                                 decoration: BoxDecoration(
                      //                                   border: Border.all(
                      //                                     color: Color.fromARGB(
                      //                                         31,
                      //                                         145,
                      //                                         140,
                      //                                         140),
                      //                                     width: 1,
                      //                                   ),
                      //                                 ),
                      //                                 height: 74,
                      //                                 width: size.width / 5,
                      //                                 //color: Colors.redAccent,
                      //                                 child: Row(
                      //                                   mainAxisAlignment:
                      //                                       MainAxisAlignment
                      //                                           .center,
                      //                                   children: [
                      //                                     Text(
                      //                                         '${cartData.special_day[index].quantity.toString()} st',
                      //                                         style: TextStyle(
                      //                                           fontSize: 18,
                      //                                           fontWeight:
                      //                                               FontWeight
                      //                                                   .w500,
                      //                                           color: Colors
                      //                                               .black54,
                      //                                         ),
                      //                                         textAlign:
                      //                                             TextAlign
                      //                                                 .center),
                      //                                     Spacer(),
                      //                                     cartData != null
                      //                                         ? GroceryCartCount(
                      //                                             index: index,
                      //                                             productId: cartData
                      //                                                 .special_day[
                      //                                                     index]
                      //                                                 .id,
                      //                                             price: cartData
                      //                                                     .special_day[
                      //                                                         index]
                      //                                                     .price /
                      //                                                 int.parse(cartData
                      //                                                     .special_day[
                      //                                                         index]
                      //                                                     .quantity),
                      //                                             category:
                      //                                                 'special_day',
                      //                                             count: int.parse(cartData
                      //                                                 .special_day[
                      //                                                     index]
                      //                                                 .quantity))
                      //                                         : CircularProgressIndicator(),
                      //                                   ],
                      //                                 ),
                      //                               ),
                      //                               Container(
                      //                                 height: 100,
                      //                                 width: size.width / 4,
                      //                                 // color: Colors.blue,
                      //                                 child: Column(
                      //                                   mainAxisAlignment:
                      //                                       MainAxisAlignment
                      //                                           .center,
                      //                                   crossAxisAlignment:
                      //                                       CrossAxisAlignment
                      //                                           .end,
                      //                                   children: [
                      //                                     IconButton(
                      //                                       onPressed:
                      //                                           () async {
                      //                                         var responce =
                      //                                             await _cartItemDeleteController
                      //                                                 .cartItemDelete(
                      //                                           _homeController
                      //                                               .tokenGlobal,
                      //                                           _homeController
                      //                                               .userId,
                      //                                           cartData
                      //                                               .special_day[
                      //                                                   index]
                      //                                               .id,
                      //                                           'special_day',
                      //                                         );
                      //                                         setState(() {});

                      //                                         if (responce !=
                      //                                             null) {
                      //                                           setState(() {});
                      //                                           Navigator.push(
                      //                                             context,
                      //                                             MaterialPageRoute(
                      //                                                 builder:
                      //                                                     (context) =>
                      //                                                         CartScreen()),
                      //                                           );

                      //                                           print(
                      //                                               "Item deleted");
                      //                                         } else {
                      //                                           setState(() {});
                      //                                           print(
                      //                                               "Item not deleted");
                      //                                         }
                      //                                       },
                      //                                       icon: Icon(
                      //                                           Icons.delete),
                      //                                       color: Colors.red,
                      //                                     ),
                      //                                     Text(
                      //                                       "${cartData.special_day[index].price.toString()} kr",
                      //                                       style: TextStyle(
                      //                                           fontSize: 18,
                      //                                           fontWeight:
                      //                                               FontWeight
                      //                                                   .w500,
                      //                                           color: Colors
                      //                                               .black54),
                      //                                     ),
                      //                                   ],
                      //                                 ),
                      //                               ),
                      //                             ],
                      //                           ),
                      //                         ),
                      //                       ],
                      //                     ),
                      //                   ),
                      //                 );
                      //               }),
                      //         ],
                      //       )
                      //     : Container(),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        // padding: const EdgeInsets.symmetric(horizontal: 20),
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(0),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12, //color of shadow
                              spreadRadius: 1, //spread radius
                              blurRadius: 0, // blur radius
                              offset:
                                  Offset(0, 0), // changes position of shadow
                              //first paramerter of offset is left-right
                              //second parameter is top to down
                            )
                          ],
                        ),
                        width: size.width,
                        height: 50,
                        child: InkWell(
                          onTap: () {
                            List groceryList = [];
                            for (int i = 0; i < cartData.grocery.length; i++) {
                              groceryList.add(cartData.grocery[i].toJson());
                              //print(groceryList);
                            }

                            // var groceryMap = groceryList.map((e) {
                            //   return {
                            //     "id": e.id,
                            //     "quantity": e.quantity,
                            //     "name": e.name,
                            //   };
                            // }).toList();
                            // print(groceryMap);
                            for (int i = 0;
                                i < cartData.special_day.length;
                                i++) {
                              List specialList = [];
                              specialList.add(cartData.special_day[i].toJson());
                              //print(specialList);
                            }
                            print(totalPrice);

                            // final mybody = {
                            //   "grocery": cartData.grocery.toJson(),
                            //   "special_day": cartData.special_day.toJson(),
                            //   "total_price": totalPrice,
                            // };
                            // http.post('dasdasf', body: mybody);
                          },
                          child: Text(
                            cartData.user.name,
                            style: TextStyle(color: Colors.black, fontSize: 18),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      Container(
                        // padding: const EdgeInsets.symmetric(horizontal: 20),
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(0),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12, //color of shadow
                              spreadRadius: 1, //spread radius
                              blurRadius: 0, // blur radius
                              offset:
                                  Offset(0, 0), // changes position of shadow
                              //first paramerter of offset is left-right
                              //second parameter is top to down
                            )
                          ],
                        ),
                        width: size.width,
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Icon(Icons.list_alt_outlined,
                                color: Colors.black, size: 20),
                            SizedBox(width: 10),
                            Text(
                              'Spara till lista',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      const CartListTile(
                          text: 'Total Varukostnad', price: '20,350'),
                      const CartListTile(text: 'Reserverat 10%', price: '323'),
                      const CartListTile(text: 'Plockavgift', price: '4900'),
                      const CartListTile(text: 'Hemleverence', price: '9900'),
                      // const CartListTile(text: 'Totalbelopp', price: '3711,01'),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(0),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12, //color of shadow
                              spreadRadius: 1, //spread radius
                              blurRadius: 0, // blur radius
                              offset:
                                  Offset(0, 0), // changes position of shadow
                            )
                          ],
                        ),
                        width: size.width,
                        height: 50,
                        child: Row(
                          children: [
                            Text(
                              'Totalbelopp',
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 15),
                              textAlign: TextAlign.center,
                            ),
                            Spacer(),
                            Text(
                              '${cartData.totalPrice.toString()} kr',
                              style: TextStyle(
                                  color: Colors.black87, fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      const CartListTile(
                          text: 'Du sparar totalt', price: '205,50'),
                      const SizedBox(height: 30),
                      InkWell(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          // margin: const EdgeInsets.symmetric(horizontal: 20),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Appcolor.primaryColor,
                            borderRadius: BorderRadius.circular(0),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12, //color of shadow
                                spreadRadius: 1, //spread radius
                                blurRadius: 0, // blur radius
                                offset:
                                    Offset(0, 0), // changes position of shadow
                                //first paramerter of offset is left-right
                                //second parameter is top to down
                              )
                            ],
                          ),
                          width: size.width,
                          height: 80,
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(width: size.width * .30),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Ga till kassan',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 22),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    'Total: ${cartData.totalPrice.toString()} kr',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                              SizedBox(width: size.width * .15),
                              Icon(Icons.arrow_forward,
                                  color: Colors.white, size: 30),
                              // IconButton(
                              //   onPressed: () {},
                              //   icon: Icon(Icons.arrow_forward),
                              //   color: Colors.white,
                              // ),
                              // SizedBox(width: 1),
                            ],
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Address.name != null
                                      ? CheckoutScreen()
                                      : AddressScreen()));
                        },
                      ),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: size.height * .48,
                      ),
                      Center(
                        child: Column(
                          children: [
                            Text('No items in cart',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ],
                  ),
          ),
          bottomNavigationBar: BottomNavyBar(
            backgroundColor: Appcolor.primaryColor,
            selectedIndex: _selectedIndex,
            showElevation: true,
            onItemSelected: (index) => setState(() {
              _selectedIndex = index;
              _pageController?.animateToPage(index,
                  duration: Duration(milliseconds: 300), curve: Curves.ease);

              if (_selectedIndex == 0) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              } else if (_selectedIndex == 1) {
                // Navigator.pushReplacement(
                //   context,
                //   MaterialPageRoute(builder: (context) => const CartScreen()),
                // );
              } else if (_selectedIndex == 2) {
                // Navigator.pushReplacement(
                //   context,
                //   MaterialPageRoute(builder: (context) => ProfileScreen()),
                // );
              } else if (_selectedIndex == 3) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
                );
              }
            }),
            items: [
              BottomNavyBarItem(
                icon: Icon(Icons.home),
                title: Text('Home'),
                activeColor: Colors.white,
              ),
              BottomNavyBarItem(
                  icon: Icon(Icons.shopping_cart),
                  title: Text('Cart'),
                  activeColor: Colors.white),
              BottomNavyBarItem(
                  icon: Icon(Icons.bookmark_border),
                  title: Text('Bookmarks'),
                  activeColor: Colors.white),
              BottomNavyBarItem(
                  icon: Icon(Icons.person),
                  title: Text('Profile'),
                  activeColor: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}
