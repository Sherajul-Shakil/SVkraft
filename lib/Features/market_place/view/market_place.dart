import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:sv_craft/Features/auth/controllar/signin_controllar.dart';
import 'package:sv_craft/Features/market_place/controller/all_product_controller.dart';
import 'package:sv_craft/Features/market_place/controller/category_controller.dart';
import 'package:sv_craft/Features/market_place/controller/market_search_controller.dart';
import 'package:sv_craft/Features/market_place/model/all_product_model.dart';
import 'package:sv_craft/Features/market_place/view/market_filter.dart';
import 'package:sv_craft/Features/market_place/view/market_product_details.dart';
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
  final AllProductController _allProductController =
      Get.put(AllProductController());

  TextEditingController _cityNameController = TextEditingController();
  TextEditingController _categoryController = TextEditingController();
  TextEditingController _searchController = TextEditingController();
  String? selectedCategory;

  var tokenp;
  bool _isSearched = false;
  var searchedData;

  final _formKey = GlobalKey<FormState>();

  final List<String> _category = [];
//"All", "Mobile", "iPhone", "Laptop", "Watch"
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      setTokenToVariable();
    }); //.then((value) => _allProductController.GetAllProduct(tokenp))
  }

  @override
  ondispose() {
    _cityNameController.dispose();
    _categoryController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> setTokenToVariable() async {
    final token = await _allProductController.getToken();
    // print('token = ' + token);
    setState(() {
      tokenp = token;
    });
  }

  bool _searchBoolean = false;
  List<int> _searchIndexList = [];

  // ignore: prefer_final_fields
  final List<String> _list = [
    'English Textbook',
    'Japanese Textbook',
    'English Vocabulary',
    'Japanese Vocabulary'
  ];

  Widget _searchTextField() {
    return TextField(
      controller: _searchController,
      onChanged: (String s) async {
        final searchProduct =
            await _maeketSearchController.getmarketSearchProduct(tokenp, s);

        if (searchProduct != null) {
          setState(() {
            _isSearched = true;
            searchedData = searchProduct;
            // print('searchProduct = ${searchProduct[0].productName}');
          });
        }
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
                    fontSize: 30,
                    fontWeight: FontWeight.bold))
            : _searchTextField(),
        actions: !_searchBoolean
            ? [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Appcolor.iconShadowColor, //<-- SEE HERE
                  child: IconButton(
                    icon: const Icon(
                      Icons.search,
                      color: Appcolor.iconColor,
                    ),
                    onPressed: () {
                      setState(() {
                        _searchBoolean = true;
                        _searchIndexList = [];
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: size.width * .02,
                ),
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Appcolor.iconShadowColor, //<-- SEE HERE
                  child: IconButton(
                    icon: const Icon(
                      FontAwesome.sliders,
                      color: Appcolor.iconColor,
                    ),
                    onPressed: () async {
                      // Get.toNamed('/marketfilter');
                      final category = await _marketCategoryController
                          .getmarketCategoryProduct(tokenp);
                      print(category.toString());
                      _category.clear();
                      if (category != null) {
                        for (var task in category) {
                          _category.add(task.categoryName);
                        }
                      }

                      // _category.add(category![0].categoryName.toString());
                      // category.then(
                      //     (value) => _category.add(value![0].categoryName));
                      // category.then(
                      //     (value) => _category.add(value![0].categoryName));
                      // category.then(
                      //     (value) => _category.add(value![0].categoryName));

                      Get.defaultDialog(
                        title: '',

                        content: Form(
                          key: _formKey,
                          child: Container(
                            // height: size.height * .8,
                            width: size.width,
                            color: Colors.white,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: Text(
                                    'Filter with Category and Area name',
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 20),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Colors.indigo,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: DropdownButton<String>(
                                    onChanged: (value2) {
                                      setState(() {
                                        selectedCategory = value2!;
                                        print(selectedCategory);
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

                                    // The list of options
                                    // items: _category
                                    //     .map((e) =>
                                    //     selectedCategory==e? DropdownMenuItem(
                                    //           value: e,
                                    //           child: Container(
                                    //             alignment:
                                    //                 Alignment.centerLeft,
                                    //             child: Text(
                                    //               e,
                                    //               style: const TextStyle(
                                    //                   fontSize: 18),
                                    //             ),
                                    //           ),
                                    //         ))
                                    //     .toList(),
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
                                    selectedItemBuilder:
                                        (BuildContext context) =>
                                            _category.map((e) {
                                      print('inside selected builder : $e');
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
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      new BoxShadow(
                                        color: Colors.white,
                                        blurRadius: 20.0,
                                      ),
                                    ],
                                  ),
                                  child: Card(
                                    child: TextFormField(
                                      controller: _cityNameController,
                                      decoration: const InputDecoration(
                                        //labelText: 'Username',
                                        hintText: "Area Name",
                                        prefixIcon: Icon(Icons.location_city),
                                        border: InputBorder.none,
                                      ),

                                      validator: (value) {
                                        if (value == null ||
                                            value.trim().isEmpty) {
                                          return 'This field is required';
                                        }
                                        // if (value.trim().length < 4) {
                                        //   return 'Username must be at least 4 characters in length';
                                        // }
                                        // Return null if the entered username is valid
                                        return null;
                                      },
                                      //onChanged: (value) => _userName = value,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 80),
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: size.width * 1,
                                    height: size.height / 20,
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Appcolor.circleColor,
                                          Color.fromARGB(255, 253, 251, 250),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: TextButton(
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          if (selectedCategory != null) {
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      MarketFilter(
                                                          token: tokenp,
                                                          selectedCategory:
                                                              selectedCategory!,
                                                          cityName:
                                                              _cityNameController
                                                                  .text)),
                                            );
                                            // _category.clear();
                                          }
                                        }
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          // SizedBox(width: size.width * 0.15),
                                          Text(
                                            'Filter',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 18,
                                                color: Colors.white),
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
                        ),
                        // barrierColor: Colors.white,
                        // shape: RoundedRectangleBorder(
                        //   borderRadius: BorderRadius.circular(0),
                        //   //side: BorderSide(width: 5, color: Colors.black),
                        // ),
                        // enableDrag: false,
                      );
                    },
                  ),
                ),
                SizedBox(
                  width: size.width * .02,
                ),
              ]
            : [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Appcolor.iconShadowColor, //<-- SEE HERE
                  child: IconButton(
                    icon: const Icon(
                      Icons.clear,
                      color: Appcolor.iconColor,
                    ),
                    onPressed: () {
                      setState(() {
                        _searchBoolean = false;
                        _isSearched = false;
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
        child: Column(
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
                    Icon(Icons.location_on_sharp, color: Appcolor.primaryColor),
                    Text('Dhaka',
                        style: TextStyle(
                            color: Appcolor.primaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.normal)),
                  ],
                ),
              ),
            ),
            _isSearched
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
                        mainAxisSpacing: 1,
                        crossAxisSpacing: 1,
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
                              color: Colors.black12, //color of shadow
                              spreadRadius: 0, //spread radius
                              blurRadius: 0, // blur radius
                              offset:
                                  Offset(0, 0), // changes position of shadow
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
                                  builder: (context) => MarketProductDetails(
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
                                  'http://mamun.click/${searchedData[index].image[0].filePath}',
                                  fit: BoxFit.contain,
                                  height: 180,
                                  width: 170,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 6),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('${searchedData[index].price} Kr',
                                        maxLines: 3,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal)),
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
                            future: _allProductController.GetAllProduct(tokenp),
                            builder: (context, snapshot) {
                              // print(
                              //     'inside buildertrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr\n' +
                              //         snapshot.data.toString());

                              if (!snapshot.hasData || snapshot.data == null) {
                                return const Center(
                                    child: CircularProgressIndicator());
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
                                      mainAxisSpacing: 1,
                                      crossAxisSpacing: 1,
                                    ),
                                    itemBuilder:
                                        (BuildContext context, int index) =>
                                            Container(
                                      // color: Colors.red,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors
                                                .black12, //color of shadow
                                            spreadRadius: 0, //spread radius
                                            blurRadius: 0, // blur radius
                                            offset: Offset(0,
                                                0), // changes position of shadow
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
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5,
                                                      vertical: 5),
                                              child: Image.network(
                                                'http://mamun.click/${data[index].image[0].filePath}',
                                                fit: BoxFit.contain,
                                                height: 180,
                                                width: 170,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 6),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                      '${data[index].price} Kr',
                                                      maxLines: 3,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 16,
                                                          fontWeight: FontWeight
                                                              .normal)),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  SizedBox(
                                                    width: 110.0,
                                                    child: Text(
                                                      data[index].productName,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      softWrap: false,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.normal,
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
                                  );
                                }
                              }
                            })
                        : const Center(child: CircularProgressIndicator()),
                  ),
          ],
        ),
      ),
    ));
  }
}
