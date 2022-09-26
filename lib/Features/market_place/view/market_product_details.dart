import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sv_craft/Features/market_place/controller/dproduct_details_controller.dart';
import 'package:sv_craft/Features/market_place/model/product_details.dart';
import 'package:sv_craft/Features/seller_profile/view/profile.dart';
import 'package:sv_craft/constant/api_link.dart';
import 'package:sv_craft/constant/color.dart';

class MarketProductDetails extends StatefulWidget {
  const MarketProductDetails({
    Key? key,
    required this.id,
    required this.token,
  }) : super(key: key);
  final int id;
  final String token;

  @override
  State<MarketProductDetails> createState() => _MarketProductDetailsState();
}

class _MarketProductDetailsState extends State<MarketProductDetails> {
  final ProductDetailsController _productDetailsController =
      Get.put(ProductDetailsController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    print("Market derails page build");
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: FutureBuilder<ProductDetailsData?>(
            future: _productDetailsController.getProductDetails(
                widget.token, widget.id),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Column(
                  children: [
                    SizedBox(
                      height: size.height * .4,
                    ),
                    const Center(
                        child: SpinKitFadingCircle(
                      color: Colors.black,
                    )),
                  ],
                );
              } else {
                if (snapshot.data == null) {
                  return const Center(
                      child: Center(
                          child: SpinKitFadingCircle(
                    color: Colors.black,
                  )));
                } else {
                  final data = snapshot.data;

                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        //   CarouselSlider(
                        //   items: images.map(
                        //     (i) {
                        //       return Builder(
                        //         builder: (BuildContext context) => Image.file(
                        //           i,
                        //           fit: BoxFit.cover,
                        //           height: 200,
                        //         ),
                        //       );
                        //     },
                        //   ).toList(),
                        //   options: CarouselOptions(
                        //     viewportFraction: 1,
                        //     height: 200,
                        //   ),
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () {
                                  Get.back();
                                },
                                icon: const Icon(Icons.arrow_back_ios)),
                          ],
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: size.width * 0.05,
                            ),
                            Text(
                              data!.productName,
                              style: const TextStyle(
                                  fontSize: 26, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.06,
                        ),
                        Image.network(
                          '${Appurl.baseURL}${data.image[0].filePath}',
                          fit: BoxFit.cover,
                          height: size.height * 0.4,
                          width: size.width * 0.8,
                        ),
                        SizedBox(
                          height: size.height * 0.05,
                        ),
                        Container(
                          width: size.width * 0.8,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.network(
                                '${Appurl.baseURL}${data.image[0].filePath}',
                                fit: BoxFit.cover,
                                height: size.height * 0.08,
                                width: size.width * 0.2,
                              ),
                              SizedBox(
                                width: size.width * 0.05,
                              ),
                              Image.network(
                                '${Appurl.baseURL}${data.image[0].filePath}',
                                fit: BoxFit.cover,
                                height: size.height * 0.1,
                                width: size.width * 0.2,
                              ),
                              SizedBox(
                                width: size.width * 0.05,
                              ),
                              Image.network(
                                '${Appurl.baseURL}${data.image[0].filePath}',
                                fit: BoxFit.cover,
                                height: size.height * 0.08,
                                width: size.width * 0.2,
                              ),
                              SizedBox(
                                width: size.width * 0.05,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(20),
                          //height: size.height * 0.5,
                          width: size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              // Text(data.productName,
                              //     style: const TextStyle(
                              //         color: Colors.black,
                              //         fontSize: 30,
                              //         fontWeight: FontWeight.normal)),
                              // const SizedBox(
                              //   height: 10,
                              // ),

                              Text('Description',
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 24,
                                      fontWeight: FontWeight.normal)),
                              Html(
                                data: data.description,
                                style: {
                                  "html": Style(
                                    color: Colors.black,
                                  ),
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text('Price : ${data.price} kr',
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal)),
                              const SizedBox(
                                height: 5,
                              ),
                              Text('Qunatity : ${data.quantity}',
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal)),
                              const SizedBox(
                                height: 5,
                              ),
                              Text('Condition : ${data.condition}',
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal)),
                              const SizedBox(
                                height: 5,
                              ),
                              Text('Brand : ${data.brand}',
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal)),
                              const SizedBox(
                                height: 20,
                              ),

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      //Navigate to SellerProfile with material route
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             SellerProfile(
                                      //                 sellerId: data.userId)));
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Appcolor.primaryColor,
                                        borderRadius: BorderRadius.circular(8),
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
                                      width: 180,
                                      height: 45,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Text(
                                            'Call Seller',
                                            style: TextStyle(
                                                color: Appcolor.uperTextColor,
                                                fontSize: 18),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      //Navigate to SellerProfile with material route
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SellerProfile(
                                                      sellerId: data.userId)));
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Appcolor.buttonColor,
                                        borderRadius: BorderRadius.circular(8),
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
                                      width: 180,
                                      height: 45,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Text(
                                            'Show Profile',
                                            style: TextStyle(
                                                color: Appcolor.textColor,
                                                fontSize: 18),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }
              }
            }),
      ),
    ));
  }
}
