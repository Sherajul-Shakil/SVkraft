import 'package:flutter/material.dart';
import 'package:sv_craft/constant/color.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({Key? key}) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
            body: Stack(
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
          top: size.height * .1,
          left: 30,
          // right: 0,
          // bottom: size.height * .5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text("Product Name",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.normal)),
              Text("Category",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.normal)),
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
          top: size.height * .15,
          right: 0,
          left: 0,
          // bottom: size.height * .5,
          child: Image.asset(
            "images/flower1.png",
            height: 300,
            width: 250,
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
                const Text(
                    "A flower, sometimes known as a bloom or blossom, is the reproductive structure found in flowering plantsA flower, sometimes known as a bloom or blossom, is the reproductive structure found in flowering plants",
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
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12, //color of shadow
                              spreadRadius: 2, //spread radius
                              blurRadius: 5, // blur radius
                              offset:
                                  Offset(0, 2), // changes position of shadow
                              //first paramerter of offset is left-right
                              //second parameter is top to down
                            )
                          ],
                        ),
                        width: 35,
                        height: 35,
                        child: const Text(
                          '-',
                          style: TextStyle(color: Colors.black, fontSize: 25),
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
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12, //color of shadow
                              spreadRadius: 2, //spread radius
                              blurRadius: 5, // blur radius
                              offset:
                                  Offset(0, 2), // changes position of shadow
                              //first paramerter of offset is left-right
                              //second parameter is top to down
                            )
                          ],
                        ),
                        width: 50,
                        height: 35,
                        child: const Text(
                          '10',
                          style: TextStyle(color: Colors.black, fontSize: 20),
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
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12, //color of shadow
                              spreadRadius: 2, //spread radius
                              blurRadius: 5, // blur radius
                              offset:
                                  Offset(0, 2), // changes position of shadow
                              //first paramerter of offset is left-right
                              //second parameter is top to down
                            )
                          ],
                        ),
                        width: 35,
                        height: 35,
                        child: const Text(
                          '+',
                          style: TextStyle(color: Colors.black, fontSize: 20),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12, //color of shadow
                              spreadRadius: 2, //spread radius
                              blurRadius: 5, // blur radius
                              offset:
                                  Offset(0, 2), // changes position of shadow
                              //first paramerter of offset is left-right
                              //second parameter is top to down
                            )
                          ],
                        ),
                        width: 220,
                        height: 60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'Add to cart',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 25),
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
    )));
  }
}
