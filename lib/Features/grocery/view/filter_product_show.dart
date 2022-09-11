import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sv_craft/Features/grocery/controllar/filter_product_con.dart';
import 'package:sv_craft/Features/grocery/model/filter_product_model.dart';
import 'package:sv_craft/Features/grocery/view/widgets/grocery_count.dart';
import 'package:sv_craft/constant/constant.dart';

class FilterProductShow extends StatefulWidget {
  const FilterProductShow(
      {Key? key, required this.subcategory, required this.token})
      : super(key: key);
  final String subcategory;
  final String token;

  @override
  State<FilterProductShow> createState() => _FilterProductShowState();
}

class _FilterProductShowState extends State<FilterProductShow> {
  final GroceryFilterController _groceryFilterController =
      Get.put(GroceryFilterController());
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      body: Container(
        height: size.height,
        // color: Colors.blue,
        child: FutureBuilder<List<FilterProductData>?>(
            future: _groceryFilterController.getGroceryFilterProduct(
                widget.token, widget.subcategory),
            builder: (context, snapshot) {
              if (!snapshot.hasData || snapshot.data == null) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (snapshot.data!.isEmpty) {
                  return const Center(child: Text('No Product Found'));
                } else {
                  final data = snapshot.data;
                  return GridView.builder(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 20, bottom: 10),
                    itemCount: data!.length,
                    scrollDirection: Axis.vertical,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: .48,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    itemBuilder: (BuildContext context, int index) => Container(
                      //color: Colors.green,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12, //color of shadow
                            spreadRadius: 2, //spread radius
                            blurRadius: 5, // blur radius
                            offset: Offset(0, 2), // changes position of shadow
                            //first paramerter of offset is left-right
                            //second parameter is top to down
                          )
                        ],
                      ),

                      child: Column(
                        children: [
                          SizedBox(height: size.height * .01),
                          Row(
                            children: [
                              SizedBox(width: size.width * .01),
                              const Icon(
                                Icons.list_alt,
                                color: Colors.black,
                              ),
                              Spacer(),
                              Text(
                                data[index].marketPrice.toString(),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              SizedBox(width: size.width * .01),
                            ],
                          ),
                          Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: Image.network(
                                  // 'http://mamun.click/${data[index].image}' ??
                                  AppImage.carouselImages[index],
                                  fit: BoxFit.cover,
                                  width: 120,
                                  height: 150,
                                ),
                              ),
                              Positioned(
                                  top: 20,
                                  right: 0,
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    color: Colors.yellow,
                                    child: Text(
                                      "${data[index].offPrice.toString()}% off",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.red),
                                    ),
                                  ))
                            ],
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
                                children: [
                                  Text(
                                    data[index].name,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                  Text(
                                    "${data[index].price} kr",
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
                          Row(
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 50,
                                    width: size.width * .4,
                                    child: Text(
                                      data[index].description ?? "",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3,
                                    ),
                                  ),
                                  // Text(
                                  //   "also the leap into electronic",
                                  //   style: TextStyle(
                                  //     fontSize: 12,
                                  //     fontWeight: FontWeight.w500,
                                  //     color: Colors.black,
                                  //   ),
                                  // ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: size.height * .01,
                          ),
                          GroceryCount(
                            index: index,
                          )
                        ],
                      ),
                      // height: 147,
                      // width: ,
                    ),
                  );
                }
              }
            }),
      ),
    ));
  }
}