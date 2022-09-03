import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constant/constant.dart';
import '../widgets/category_card.dart';

class SpecialHomeScreen extends StatelessWidget {
  const SpecialHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              //padding: const EdgeInsets.all(5),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12, //color of shadow
                    spreadRadius: 1, //spread radius
                    blurRadius: 0, // blur radius
                    offset: Offset(0, 1), // changes position of shadow
                    //first paramerter of offset is left-right
                    //second parameter is top to down
                  )
                ],
              ),
              width: size.width,
              height: size.height * .3,
              child: Image.asset(
                'images/specialhome.png',
                fit: BoxFit.cover,
                width: size.width,
                height: size.height * .3,
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            Container(
              //padding: const EdgeInsets.all(5),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12, //color of shadow
                    spreadRadius: 1, //spread radius
                    blurRadius: 0, // blur radius
                    offset: Offset(0, 1), // changes position of shadow
                    //first paramerter of offset is left-right
                    //second parameter is top to down
                  )
                ],
              ),
              width: size.width,
              height: size.width * .81,
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CategoryCard(
                        text: 'FLOWERS & CHOC0LATE',
                        boxColor: Color.fromARGB(255, 194, 106, 194),
                        textColor: Color.fromARGB(255, 255, 255, 255),
                        onTap: () {
                          Get.toNamed("/specialcategoryproduct");
                        },
                      ),
                      CategoryCard(
                        text: 'FLOWERS IN VASES',
                        boxColor: Color.fromARGB(255, 70, 104, 150),
                        textColor: Color.fromARGB(255, 5, 3, 3),
                        onTap: () {
                          Get.toNamed("/specialcategoryproduct");
                        },
                      ),
                      CategoryCard(
                        text: 'FLOWERS & GIFTS',
                        boxColor: Color.fromARGB(255, 76, 115, 197),
                        textColor: Color.fromARGB(255, 255, 255, 255),
                        onTap: () {
                          Get.toNamed("/specialcategoryproduct");
                        },
                      ),
                    ],
                  ),
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CategoryCard(
                          text: 'NEW COLLECTION',
                          boxColor: Color.fromARGB(255, 125, 179, 143),
                          textColor: Color.fromARGB(255, 5, 3, 3),
                          onTap: () {
                            Get.toNamed("/specialcategoryproduct");
                          },
                        ),
                        CategoryCard(
                          text: 'HAND BAUQUEST',
                          boxColor: Color.fromARGB(255, 226, 119, 76),
                          textColor: Color.fromARGB(255, 255, 255, 255),
                          onTap: () {
                            Get.toNamed("/specialcategoryproduct");
                          },
                        ),
                        CategoryCard(
                          text: 'GRAND COLLECTION',
                          boxColor: Color.fromARGB(255, 197, 194, 188),
                          textColor: Color.fromARGB(255, 5, 3, 3),
                          onTap: () {
                            Get.toNamed("/specialcategoryproduct");
                          },
                        ),
                      ]),
                ],
              ),
            ),
            Container(
              width: size.width,
              height: size.height * .37 * 3,
              color: const Color.fromARGB(255, 238, 238, 238),
              child: Column(
                children: [
                  // SizedBox(
                  //   height: 10,
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20, left: 20, right: 20, bottom: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Eid Adha",
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 20,
                                fontWeight: FontWeight.normal)),
                        InkWell(
                          child: const Text("View All",
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal)),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: size.height * .3,
                    // color: Colors.blue,
                    child: GridView.builder(
                      padding: const EdgeInsets.only(
                          left: 15, right: 15, top: 20, bottom: 10),
                      itemCount: AppImage.carouselImages.length,
                      scrollDirection: Axis.horizontal,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        childAspectRatio: 1.35,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                      itemBuilder: (BuildContext context, int index) =>
                          Container(
                        // color: Colors.red,
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
                                  Offset(0, 1), // changes position of shadow
                              //first paramerter of offset is left-right
                              //second parameter is top to down
                            )
                          ],
                        ),

                        child: Column(
                          children: [
                            //SizedBox(height: size.height * .01),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Image.network(
                                AppImage.carouselImages[index],
                                fit: BoxFit.cover,
                                width: 130,
                                height: 140,
                              ),
                            ),
                            SizedBox(
                              height: size.height * .02,
                            ),
                            Row(
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text(
                                      "Product Name",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "SAR805.00",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: size.height * .02,
                            ),
                          ],
                        ),
                        // height: 147,
                        // width: ,
                      ),
                    ),
                  ),

                  //2nd row
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20, left: 20, right: 20, bottom: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("best Sellers",
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 20,
                                fontWeight: FontWeight.normal)),
                        InkWell(
                          child: const Text("View All",
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal)),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: size.height * .3,
                    // color: Colors.blue,
                    child: GridView.builder(
                      padding: const EdgeInsets.only(
                          left: 15, right: 15, top: 20, bottom: 10),
                      itemCount: AppImage.carouselImages.length,
                      scrollDirection: Axis.horizontal,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        childAspectRatio: 1.35,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                      itemBuilder: (BuildContext context, int index) =>
                          Container(
                        // color: Colors.red,
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
                                  Offset(0, 1), // changes position of shadow
                              //first paramerter of offset is left-right
                              //second parameter is top to down
                            )
                          ],
                        ),

                        child: Column(
                          children: [
                            //SizedBox(height: size.height * .01),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Image.network(
                                AppImage.carouselImages[index],
                                fit: BoxFit.cover,
                                width: 130,
                                height: 140,
                              ),
                            ),
                            SizedBox(
                              height: size.height * .02,
                            ),
                            Row(
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text(
                                      "Product Name",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "SAR805.00",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: size.height * .02,
                            ),
                          ],
                        ),
                        // height: 147,
                        // width: ,
                      ),
                    ),
                  ),

                  //3rd row
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20, left: 20, right: 20, bottom: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("New In",
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 20,
                                fontWeight: FontWeight.normal)),
                        InkWell(
                          child: const Text("View All",
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal)),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: size.height * .3,
                    // color: Colors.blue,
                    child: GridView.builder(
                      padding: const EdgeInsets.only(
                          left: 15, right: 15, top: 20, bottom: 10),
                      itemCount: AppImage.carouselImages.length,
                      scrollDirection: Axis.horizontal,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        childAspectRatio: 1.35,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                      itemBuilder: (BuildContext context, int index) =>
                          Container(
                        // color: Colors.red,
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
                                  Offset(0, 1), // changes position of shadow
                              //first paramerter of offset is left-right
                              //second parameter is top to down
                            )
                          ],
                        ),

                        child: Column(
                          children: [
                            //SizedBox(height: size.height * .01),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Image.network(
                                AppImage.carouselImages[index],
                                fit: BoxFit.cover,
                                width: 130,
                                height: 140,
                              ),
                            ),
                            SizedBox(
                              height: size.height * .02,
                            ),
                            Row(
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text(
                                      "Product Name",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "SAR805.00",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: size.height * .02,
                            ),
                          ],
                        ),
                        // height: 147,
                        // width: ,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
