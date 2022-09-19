import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:sv_craft/Features/auth/controllar/signin_controllar.dart';
import 'package:sv_craft/Features/market_place/controller/all_product_controller.dart';
import 'package:sv_craft/Features/market_place/controller/category_controller.dart';
import 'package:sv_craft/Features/market_place/controller/city_controller.dart';
import 'package:sv_craft/Features/market_place/controller/market_search_controller.dart';
import 'package:sv_craft/Features/market_place/model/all_product_model.dart';
import 'package:sv_craft/Features/market_place/view/market_filter.dart';
import 'package:sv_craft/Features/market_place/view/market_product_details.dart';
import 'package:sv_craft/constant/api_link.dart';
import 'package:sv_craft/constant/color.dart';

class MarketPlace extends StatefulWidget {
  const MarketPlace({Key? key}) : super(key: key);

  @override
  State<MarketPlace> createState() => _MarketPlaceState();
}

class _MarketPlaceState extends State<MarketPlace> {
  // final SigninController _signinController = Get.put(SigninController());
  final MarketSearchController _maeketSearchController =
      Get.put(MarketSearchController());
  final MarketCategoryController _marketCategoryController =
      Get.put(MarketCategoryController());
  final MarketCityController _cityController = Get.put(MarketCityController());
  final AllProductController _allProductController =
      Get.put(AllProductController());

  final TextEditingController _cityNameController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  String? selectedCategory;
  String? selectedCity;
  String? selectedPrice;

  var tokenp;
  bool _isSearched = false;
  bool _searchBoolean = false;
  var searchedData;
  bool _showfilter = false;
  String? priceRange;

  final _formKey = GlobalKey<FormState>();

  final List<String> _category = [];
  final List<String> _city = [];
  final List<String> _priceRan = ["Highest", "Lowest", "Newest", "Oldest"];

//"All", "Mobile", "iPhone", "Laptop", "Watch"
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      setTokenToVariable();
    }); //.then((value) => _allProductController.GetAllProduct(tokenp))
  }

  Future<void> setTokenToVariable() async {
    final token = await _allProductController.getToken();
    // print('token = ' + token);
    setState(() {
      tokenp = token;
      _allProductController.tokenGlobal = token;
    });
  }

  @override
  ondispose() {
    _cityNameController.dispose();
    _categoryController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Widget _searchTextField() {
    return TextField(
      controller: _searchController,
      onChanged: (String s) async {
        Future.delayed(Duration(seconds: 1), () async {
          final searchProduct =
              await _maeketSearchController.getmarketSearchProduct(tokenp, s);

          if (searchProduct != null) {
            setState(() {
              _isSearched = true;
              searchedData = searchProduct;
              // print('searchProduct = ${searchProduct[0].productName}');
            });
          }
        });
        // final searchProduct =
        //     await _maeketSearchController.getmarketSearchProduct(tokenp, s);

        // if (searchProduct != null) {
        //   setState(() {
        //     _isSearched = true;
        //     searchedData = searchProduct;
        //     // print('searchProduct = ${searchProduct[0].productName}');
        //   });
        // }
      },
      autofocus: true,
      cursorColor: Colors.black,
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
      textInputAction: TextInputAction.search,
      decoration: const InputDecoration(
        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
        enabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        focusedBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        hintText: 'Search',
        hintStyle: TextStyle(
          color: Appcolor.uperTextColor,
          fontSize: 20,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    //print(tokenp);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        leadingWidth: 300,
        automaticallyImplyLeading: false,
        backgroundColor: Appcolor.primaryColor,
        elevation: 1,
        // leading: const Text('Market Place',
        //     style: TextStyle(
        //         color: Colors.black,
        //         fontSize: 20,
        //         fontWeight: FontWeight.bold)),
        title: !_searchBoolean
            ? const Text('Market Place',
                style: TextStyle(
                    color: Appcolor.uperTextColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold))
            : _searchTextField(),
        actions: !_searchBoolean
            ? [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: Appcolor.iconShadowColor, //<-- SEE HERE
                  child: IconButton(
                    icon: const Icon(
                      Icons.search,
                      color: Appcolor.iconColor,
                      size: 20,
                    ),
                    onPressed: () {
                      setState(() {
                        Future.delayed(Duration(microseconds: 500), () async {
                          _searchBoolean = true;
                          _showfilter = false;
                        });
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: size.width * .02,
                ),
                !_showfilter
                    ? CircleAvatar(
                        radius: 18,
                        backgroundColor:
                            Appcolor.iconShadowColor, //<-- SEE HERE
                        child: IconButton(
                          icon: const Icon(
                            FontAwesome.sliders,
                            color: Appcolor.iconColor,
                            size: 20,
                          ),
                          onPressed: () async {
                            // Get product category
                            final category = await _marketCategoryController
                                .getmarketCategoryProduct(tokenp);

                            _category.clear();
                            if (category != null) {
                              for (var task in category) {
                                _category.add(task.categoryName);
                              }
                            }

                            // Get city name
                            final city =
                                await _cityController.getmarketCity(tokenp);

                            _city.clear();
                            if (city != null) {
                              for (var task in city) {
                                _city.add(task.name);
                              }
                            }

                            setState(() {
                              _showfilter = true;
                            });
                          },
                        ),
                      )
                    : CircleAvatar(
                        radius: 18,
                        backgroundColor:
                            Appcolor.iconShadowColor, //<-- SEE HERE
                        child: IconButton(
                          icon: const Icon(
                            Icons.clear,
                            color: Appcolor.iconColor,
                            size: 20,
                          ),
                          onPressed: () {
                            setState(() {
                              Future.delayed(Duration(microseconds: 500),
                                  () async {
                                _showfilter = false;
                              });
                            });
                          },
                        ),
                      ),
                SizedBox(
                  width: size.width * .02,
                ),
              ]
            : [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: Appcolor.iconShadowColor, //<-- SEE HERE
                  child: IconButton(
                    icon: const Icon(
                      Icons.clear,
                      color: Appcolor.iconColor,
                      size: 20,
                    ),
                    onPressed: () {
                      setState(() {
                        Future.delayed(Duration(microseconds: 500), () async {
                          searchedData = null;
                          _searchBoolean = false;
                          _isSearched = false;
                        });
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: size.width * .02,
                ),
              ],
      ),
      body: SingleChildScrollView(
        child: !_showfilter
            ? Column(
                children: [
                  Container(
                    height: 50,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: const [
                          Text('Today\'s Picks',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 22,
                                  fontWeight: FontWeight.normal)),
                          Spacer(),
                          Icon(Icons.location_on_sharp,
                              color: Appcolor.primaryColor),
                          Text('Dhaka',
                              style: TextStyle(
                                  color: Appcolor.primaryColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal)),
                        ],
                      ),
                    ),
                  ),
                  searchedData != null && _searchController.text.isNotEmpty
                      ? Container(
                          height: size.height - 120,
                          color: Colors.white,
                          child: GridView.builder(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 20, bottom: 10),
                            itemCount: searchedData.length,
                            scrollDirection: Axis.vertical,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: .79,
                              mainAxisSpacing: 5,
                              crossAxisSpacing: 5,
                            ),
                            itemBuilder: (BuildContext context, int index) =>
                                Container(
                              // color: Colors.red,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black38, //color of shadow
                                    spreadRadius: 1, //spread radius
                                    blurRadius: 1, // blur radius
                                    offset: Offset(
                                        1, 1), // changes position of shadow
                                    //first paramerter of offset is left-right
                                    //second parameter is top to down
                                  )
                                ],
                              ),

                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            MarketProductDetails(
                                              id: searchedData[index].id,
                                              token: tokenp,
                                            )),
                                  );
                                },
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 5),
                                      child: Image.network(
                                        '${Appurl.baseURL}${searchedData[index].image[0].filePath}',
                                        fit: BoxFit.contain,
                                        height: 180,
                                        width: 170,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 6),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              '${searchedData[index].price} Kr',
                                              maxLines: 3,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight:
                                                      FontWeight.normal)),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          SizedBox(
                                            width: 110.0,
                                            child: Text(
                                              searchedData[index].productName,
                                              overflow: TextOverflow.ellipsis,
                                              softWrap: false,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 16.0),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      : Container(
                          height: size.height - 120,
                          color: Colors.white,
                          child: tokenp != null
                              ? FutureBuilder<List<Datum>?>(
                                  future: _allProductController.GetAllProduct(
                                      tokenp),
                                  builder: (context, snapshot) {
                                    // print(
                                    //     'inside buildertrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr\n' +
                                    //         snapshot.data.toString());

                                    if (!snapshot.hasData ||
                                        snapshot.data == null) {
                                      return const Center(
                                          child: const SpinKitFadingCircle(
                                        color: Colors.black,
                                      ));
                                    } else {
                                      if (snapshot.data!.isEmpty) {
                                        return const Center(
                                            child: Text('No Product Found'));
                                      } else {
                                        final data = snapshot.data;
                                        return GridView.builder(
                                          padding: const EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                              top: 20,
                                              bottom: 10),
                                          itemCount: data!.length,
                                          scrollDirection: Axis.vertical,
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            childAspectRatio: .79,
                                            mainAxisSpacing: 5,
                                            crossAxisSpacing: 5,
                                          ),
                                          itemBuilder: (BuildContext context,
                                                  int index) =>
                                              Container(
                                            // color: Colors.red,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: Colors
                                                      .black12, //color of shadow
                                                  spreadRadius:
                                                      1, //spread radius
                                                  blurRadius: 1, // blur radius
                                                  offset: Offset(1,
                                                      1), // changes position of shadow
                                                  //first paramerter of offset is left-right
                                                  //second parameter is top to down
                                                )
                                              ],
                                            ),

                                            child: InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          MarketProductDetails(
                                                            id: data[index].id,
                                                            token: tokenp,
                                                          )),
                                                );
                                              },
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 5,
                                                        vertical: 5),
                                                    child: Image.network(
                                                      'http://mamun.click/${data[index].image[0].filePath}',
                                                      fit: BoxFit.cover,
                                                      height: 180,
                                                      width: 170,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 6),
                                                    child: Row(
                                                      // mainAxisAlignment:
                                                      //     MainAxisAlignment
                                                      //         .spaceBetween,
                                                      children: [
                                                        Text(
                                                            '${data[index].price} Kr',
                                                            maxLines: 3,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal)),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        SizedBox(
                                                          width: 100.0,
                                                          child: Text(
                                                            data[index]
                                                                .productName,
                                                            softWrap: false,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                fontSize: 16.0),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                    }
                                  })
                              : const Center(
                                  child: CircularProgressIndicator()),
                        ),
                ],
              )
            : Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: Text(
                            'Filter with',
                            style: TextStyle(
                                color: Appcolor.primaryColor,
                                fontSize: 25,
                                fontWeight: FontWeight.normal),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text('CATEGORY',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal)),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          margin: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 20),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Appcolor.primaryColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: DropdownButton<String>(
                            onChanged: (value2) {
                              setState(() {
                                selectedCategory = value2!;

                                //showToast();
                              });
                            },
                            value: selectedCategory,

                            hint: Center(
                                child: Text(
                              selectedCategory ?? 'Select Category',
                              style: TextStyle(color: Colors.white),
                            )),

                            // Hide the default underline
                            underline: Container(),
                            // set the color of the dropdown menu
                            dropdownColor: Colors.white,
                            icon: const Icon(
                              Icons.arrow_downward,
                              color: Colors.white,
                            ),
                            isExpanded: true,

                            items: _category.map((item) {
                              if (item == selectedCategory) {
                                return DropdownMenuItem(
                                  value: item,
                                  child: Container(
                                      height: 48.0,
                                      width: double.infinity,
                                      color: Colors.grey,
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          item,
                                        ),
                                      )),
                                );
                              } else {
                                return DropdownMenuItem(
                                  value: item,
                                  child: Text(item),
                                );
                              }
                            }).toList(),

                            // Customize the selected item
                            selectedItemBuilder: (BuildContext context) =>
                                _category.map((e) {
                              return Center(
                                child: Text(
                                  e,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.bold),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text('PLATS',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal)),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          margin: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 20),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Appcolor.primaryColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: DropdownButton<String>(
                            onChanged: (value2) {
                              setState(() {
                                selectedCity = value2!;

                                //showToast();
                              });
                            },
                            value: selectedCity,

                            hint: Center(
                                child: Text(
                              selectedCity ?? 'Select City',
                              style: TextStyle(color: Colors.white),
                            )),

                            // Hide the default underline
                            underline: Container(),
                            // set the color of the dropdown menu
                            dropdownColor: Colors.white,
                            icon: const Icon(
                              Icons.arrow_downward,
                              color: Colors.white,
                            ),
                            isExpanded: true,

                            items: _city.map((item) {
                              if (item == selectedCity) {
                                return DropdownMenuItem(
                                  value: item,
                                  child: Container(
                                      height: 48.0,
                                      width: double.infinity,
                                      color: Colors.grey,
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          item,
                                        ),
                                      )),
                                );
                              } else {
                                return DropdownMenuItem(
                                  value: item,
                                  child: Text(item),
                                );
                              }
                            }).toList(),

                            // Customize the selected item
                            selectedItemBuilder: (BuildContext context) =>
                                _city.map((e) {
                              return Center(
                                child: Text(
                                  e,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.bold),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text('Price Range',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal)),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          margin: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 20),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Appcolor.primaryColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: DropdownButton<String>(
                            onChanged: (value2) {
                              setState(() {
                                selectedPrice = value2!;

                                //showToast();
                              });
                            },
                            value: selectedPrice,

                            hint: Center(
                                child: Text(
                              selectedPrice ?? 'Select Price',
                              style: TextStyle(color: Colors.white),
                            )),

                            // Hide the default underline
                            underline: Container(),
                            // set the color of the dropdown menu
                            dropdownColor: Colors.white,
                            icon: const Icon(
                              Icons.arrow_downward,
                              color: Colors.white,
                            ),
                            isExpanded: true,

                            items: _priceRan.map((item) {
                              if (item == selectedPrice) {
                                return DropdownMenuItem(
                                  value: item,
                                  child: Container(
                                      height: 48.0,
                                      width: double.infinity,
                                      color: Colors.grey,
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          item,
                                        ),
                                      )),
                                );
                              } else {
                                return DropdownMenuItem(
                                  value: item,
                                  child: Text(item),
                                );
                              }
                            }).toList(),

                            // Customize the selected item
                            selectedItemBuilder: (BuildContext context) =>
                                _priceRan.map((e) {
                              return Center(
                                child: Text(
                                  e,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.bold),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        //const SizedBox(
                        //   height: 20,
                        // ),

                        // RadioListTile(
                        //   title: Text("Highest Price"),
                        //   value: "highest",
                        //   groupValue: priceRange,
                        //   onChanged: (value) {
                        //     setState(() {
                        //       priceRange = value.toString();
                        //       print(priceRange);
                        //     });
                        //   },
                        // ),

                        // RadioListTile(
                        //   title: Text("Lowest Price"),
                        //   value: "lowest",
                        //   groupValue: priceRange,
                        //   onChanged: (value) {
                        //     setState(() {
                        //       priceRange = value.toString();
                        //       print(priceRange);
                        //     });
                        //   },
                        // ),
                        SizedBox(
                          height: 50,
                        ),

                        //Filter button
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 100),
                          child: Container(
                            alignment: Alignment.center,
                            width: size.width * 1,
                            height: size.height / 20,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Appcolor.buttonColor),
                            child: TextButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  if (selectedCategory != null &&
                                      selectedCity != null &&
                                      selectedPrice != null) {
                                    print(selectedCategory! +
                                        selectedCity! +
                                        selectedPrice!);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MarketFilter(
                                              token: tokenp,
                                              selectedCategory:
                                                  selectedCategory!,
                                              cityName: selectedCity!,
                                              priceRange: selectedPrice)),
                                    );
                                    // _category.clear();
                                  } else {
                                    Get.snackbar(
                                      "Please select all fields",
                                      "",
                                      snackPosition: SnackPosition.BOTTOM,
                                    );
                                  }
                                }
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  // SizedBox(width: size.width * 0.15),
                                  Text(
                                    'Filter',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18,
                                        color: Appcolor.textColor),
                                  ),
                                  // SizedBox(width: 30),
                                  // const Icon(
                                  //   FontAwesome.sliders,
                                  //   color: Colors.white,
                                  //   size: 20.0,
                                  //   //weight: IconWeight.bold
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // barrierColor: Colors.white,
                  // shape: RoundedRectangleBorder(
                  //   borderRadius: BorderRadius.circular(0),
                  //   //side: BorderSide(width: 5, color: Colors.black),
                  // ),
                ],
              ),
      ),
    ));
  }
}
