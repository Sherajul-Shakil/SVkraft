import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sv_craft/Features/special_day/controllar/special_details_pro_con.dart';
import 'package:sv_craft/Features/special_day/model/special_pro_detals_m.dart';
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
  var details;

  // @override
  // void initState() {
  //   super.initState();
  //   Timer(Duration(seconds: 1), () {
  //     var data = _specialDetailsProductController.getSpecialDetailsProduct(
  //         widget.token, widget.id);
  //     setState(() {
  //       details = data;
  //     });
  //     print('Print from details page ${details.data!.name},');
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
                      print('Print from builder $data ');
                      return Stack(
                        children: [
                          Positioned(
                            // top: 0,
                            // left: 0,
                            // right: 0,
                            // bottom: size.height * .5,
                            child: Container(
                              height: size.height * 54,
                              width: size.width,
                              color: Appcolor.primaryColor,
                            ),
                          ),
                          Positioned(
                            top: size.height * .08,
                            left: 30,
                            // right: 0,
                            // bottom: size.height * .5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: size.width * .8,
                                  child: Text(data!.name,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 30,
                                          fontWeight: FontWeight.normal)),
                                ),
                                // Text("Category",
                                //     style: TextStyle(
                                //         color: Colors.white,
                                //         fontSize: 25,
                                //         fontWeight: FontWeight.normal)),
                              ],
                            ),
                          ),
                          Positioned(
                            top: size.height * .48,
                            child: Container(
                              height: size.height * 52,
                              width: size.width,
                              // color: Colors.white,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30),
                                ),
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Positioned(
                            top: size.height * .20,
                            right: 0,
                            left: 0,
                            // bottom: size.height * .5,
                            child: Image.network(
                              'http://mamun.click/${data.image}',
                              height: size.height * .3,
                              width: size.width * .8,
                            ),
                          ),
                          Positioned(
                            top: size.height * .50,
                            right: 0,
                            left: 0,
                            // bottom: size.height * .5,
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Description",
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 30,
                                          fontWeight: FontWeight.normal)),
                                  Text(data.description,
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
                                        onTap: () {},
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
                                          child: const Text(
                                            '10',
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
                                        onTap: () {},
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
                                    children: [
                                      const Text('\$200',
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 25,
                                              fontWeight: FontWeight.normal)),
                                      // SizedBox(
                                      //   width: size.width * .2,
                                      // ),
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
                                          width: 220,
                                          height: 60,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: const [
                                              Text(
                                                'Add to cart',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 25),
                                                textAlign: TextAlign.center,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Icon(
                                                Icons.shopping_cart,
                                                color: Colors.black,
                                                size: 25,
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
                          ),
                        ],
                      );
                    }
                  }
                })));
  }
}
