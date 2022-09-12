import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sv_craft/Features/cart/controllar/addtocart_con.dart';
import 'package:sv_craft/Features/market_place/controller/all_product_controller.dart';
import 'package:sv_craft/Features/special_day/controllar/special_details_pro_con.dart';
import 'package:sv_craft/Features/special_day/model/special_pro_detals_m.dart';
import 'package:sv_craft/constant/api_link.dart';
import 'package:sv_craft/constant/color.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({
    Key? key,
    required this.id,
    required this.token,
  }) : super(key: key);
  final int id;
  final String token;
  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final SpecialDetailsProductController _specialDetailsProductController =
      Get.put(SpecialDetailsProductController());
  final AllProductController _allProductController =
      Get.put(AllProductController());
  final AddtocartController _addToCartController =
      Get.put(AddtocartController());
  var details;
  var count = 0;
  var totalPrice = 0;
  late int userId;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      setTokenToVariable();
    }); //.then((value) => _allProductController.GetAllProduct(tokenp))
  }

  Future<void> setTokenToVariable() async {
    final userid = await _allProductController.getUserId();
    // print('token = ' + token);
    setState(() {
      userId = userid;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // print('User id from details $userId');
    return SafeArea(
        child: Scaffold(
            body: FutureBuilder<SpecialProductDetailsData?>(
                future: _specialDetailsProductController
                    .getSpecialProductDetails(widget.token, widget.id),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    if (snapshot.data == null) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      final data = snapshot.data;
                      // print('Print from builder $data ');
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              height: size.height * 0.5,
                              width: size.width,
                              child: Stack(
                                children: [
                                  Positioned(
                                    top: 0,
                                    left: 0,
                                    right: 0,
                                    bottom: 0,
                                    child: Container(
                                      height: size.height * 55,
                                      width: size.width,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(30),
                                          bottomRight: Radius.circular(30),
                                        ),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              '${Appurl.baseURL}${data!.image}'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: size.height * .02,
                                    left: 20,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(10),
                                          // width: size.width * .6,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.black38,
                                          ),
                                          child: Text(
                                            data!.name,
                                            style: const TextStyle(
                                                color: Appcolor.uperTextColor,
                                                fontSize: 20,
                                                fontWeight: FontWeight.normal),
                                            // textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Price : ${data.price}',
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 25,
                                          fontWeight: FontWeight.normal)),
                                  SizedBox(
                                    height: size.height * .01,
                                  ),
                                  const Text("Description",
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 30,
                                          fontWeight: FontWeight.normal)),
                                  Text(
                                      "${data.description} uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu",
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 18,
                                          fontWeight: FontWeight.normal)),
                                  SizedBox(
                                    height: size.height * .05,
                                  ),
                                  const Text('Quantity',
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 18,
                                          fontWeight: FontWeight.normal)),
                                  SizedBox(
                                    height: size.height * .01,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            count > 0 ? count-- : count = 0;
                                            totalPrice = count * data.price;
                                          });
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Colors
                                                    .black12, //color of shadow
                                                spreadRadius: 2, //spread radius
                                                blurRadius: 5, // blur radius
                                                offset: Offset(0,
                                                    2), // changes position of shadow
                                                //first paramerter of offset is left-right
                                                //second parameter is top to down
                                              )
                                            ],
                                          ),
                                          width: 35,
                                          height: 35,
                                          child: const Text(
                                            '-',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 25),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      InkWell(
                                        onTap: () {},
                                        child: Container(
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Colors
                                                    .black12, //color of shadow
                                                spreadRadius: 2, //spread radius
                                                blurRadius: 5, // blur radius
                                                offset: Offset(0,
                                                    2), // changes position of shadow
                                                //first paramerter of offset is left-right
                                                //second parameter is top to down
                                              )
                                            ],
                                          ),
                                          width: 50,
                                          height: 35,
                                          child: Text(
                                            count.toString(),
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            count++;
                                            totalPrice = count * data.price;
                                          });
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(5),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Colors
                                                    .black12, //color of shadow
                                                spreadRadius: 2, //spread radius
                                                blurRadius: 5, // blur radius
                                                offset: Offset(0,
                                                    2), // changes position of shadow
                                                //first paramerter of offset is left-right
                                                //second parameter is top to down
                                              )
                                            ],
                                          ),
                                          width: 35,
                                          height: 35,
                                          child: const Text(
                                            '+',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: size.height * .05,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text('Total : \$${totalPrice.toString()}',
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 20,
                                              fontWeight: FontWeight.normal)),
                                      // SizedBox(
                                      //   width: size.width * .2,
                                      // ),
                                      InkWell(
                                        onTap: () async {
                                          if (count > 0) {
                                            var addResponce =
                                                await _addToCartController
                                                    .addTocart(
                                              userId,
                                              data.id,
                                              "special_day",
                                              count,
                                              totalPrice,
                                              widget.token,
                                            );
                                            addResponce != null
                                                ? Get.snackbar(
                                                    "$addResponce",
                                                    "",
                                                    snackPosition:
                                                        SnackPosition.BOTTOM,
                                                  )
                                                : "";

                                            print(
                                                'Message from ui ${addResponce}');

                                            //delayed
                                            Future.delayed(
                                                Duration(microseconds: 500),
                                                () {
                                              Navigator.pop(context);
                                            });
                                          }
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: Appcolor.buttonColor,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Colors
                                                    .black12, //color of shadow
                                                spreadRadius: 2, //spread radius
                                                blurRadius: 2, // blur radius
                                                offset: Offset(0,
                                                    2), // changes position of shadow
                                                //first paramerter of offset is left-right
                                                //second parameter is top to down
                                              )
                                            ],
                                          ),
                                          width: 170,
                                          height: 50,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: const [
                                              Text(
                                                'Add to cart',
                                                style: TextStyle(
                                                    color: Appcolor.textColor,
                                                    fontSize: 20),
                                                textAlign: TextAlign.center,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Icon(
                                                Icons.shopping_cart,
                                                color: Colors.black,
                                                size: 20,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  }
                })));
  }
}
