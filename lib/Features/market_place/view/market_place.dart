import 'dart:async';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:sv_craft/Features/add_market_product/view/category_city.dart';
import 'package:sv_craft/Features/home/home_screen.dart';
import 'package:sv_craft/Features/market_place/controller/all_product_controller.dart';
import 'package:sv_craft/Features/market_place/controller/category_controller.dart';
import 'package:sv_craft/Features/market_place/controller/market_search_controller.dart';
import 'package:sv_craft/Features/market_place/model/all_product_model.dart';
import 'package:sv_craft/Features/market_place/model/market_category.dart';
import 'package:sv_craft/Features/market_place/view/filter_box_screen.dart';
import 'package:sv_craft/Features/market_place/view/market_product_details.dart';
import 'package:sv_craft/Features/profile/view/profile_screen.dart';
import 'package:sv_craft/constant/api_link.dart';
import 'package:sv_craft/constant/color.dart';

class MarketPlace extends StatefulWidget {
  const MarketPlace({Key? key}) : super(key: key);

  @override
  State<MarketPlace> createState() => _MarketPlaceState();
}

class _MarketPlaceState extends State<MarketPlace> {
  final MarketSearchController _maeketSearchController =
      Get.put(MarketSearchController());
  final MarketCategoryController _marketCategoryController =
      Get.put(MarketCategoryController());
  final AllProductController _allProductController =
      Get.put(AllProductController());

  final TextEditingController _searchController = TextEditingController();

  var tokenp;

  bool _searchBoolean = false;
  var searchedData;
  bool _showfilter = false;
  String? priceRange;
  var _selectedIndex = 2;
  PageController? _pageController;

  final List<mCategory> _categoryList = [];
  var _categoryData;
  var matchCategory;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      await setTokenToVariable();
    });
  }

  Future<void> setTokenToVariable() async {
    final token = await _allProductController.getToken();
    // print('token = ' + token);
    setState(() {
      tokenp = token;
      _allProductController.tokenGlobal = token;
    });

    // Market Category
    final responce =
        await _marketCategoryController.getmarketCategoryProduct(tokenp);
    _categoryList.clear();
    if (responce != null) {
      setState(() {
        _categoryData = responce;
      });
      for (var task in responce) {
        // _categoryList.name.add(task.categoryName);
        _categoryList.add(
          mCategory(
            categoryName: task.categoryName,
            image: task.image,
          ),
        );
      }
    }
  }

  @override
  dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Widget _searchTextField() {
    return TextField(
      controller: _searchController,
      onSubmitted: (_) async {
        final searchProduct = await _maeketSearchController
            .getmarketSearchProduct(tokenp, _searchController.text);

        if (searchProduct != null) {
          setState(() {
            searchedData = searchProduct;
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddCategoryCity(),
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
        backgroundColor: Color.fromARGB(255, 143, 211, 231),
        appBar: AppBar(
          leadingWidth: 300,
          automaticallyImplyLeading: false,
          backgroundColor: Appcolor.primaryColor,
          elevation: 1,
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
                              Get.to(() => FilterBoxScreen());
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
                              color: Colors.blue,
                              size: 20,
                            ),
                            onPressed: () {
                              setState(() {
                                Future.delayed(Duration(microseconds: 200),
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
                          // Future.delayed(
                          //     Duration(microseconds: 200), () async {});
                          //searchedData = null;
                          _searchBoolean = false;
                          //       _isSearched = false;
                          _searchController.text = "";
                          // _searchController.clear();
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
              color: Color.fromARGB(255, 143, 211, 231),
              height: 50,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    _searchController.text == null ||
                            _searchController.text == ''
                        ? Text('Today\'s Picks',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 22,
                                fontWeight: FontWeight.normal))
                        : Text(_searchController.text,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 22,
                                fontWeight: FontWeight.normal)),
                    Spacer(),
                  ],
                ),
              ),
            ),
            searchedData != null && _searchBoolean == true
                ? Container(
                    color: Color.fromARGB(255, 143, 211, 231),
                    height: size.height - 120,
                    // color: Colors.white,
                    child: GridView.builder(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 20, bottom: 10),
                      itemCount: searchedData.length,
                      scrollDirection: Axis.vertical,
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
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
                              offset:
                                  Offset(1, 1), // changes position of shadow
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
                                  '${Appurl.baseURL}${searchedData[index].image[0].filePath}',
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
                : tokenp != null && _categoryData != null
                    ? ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: _categoryData.length,
                        itemBuilder: (BuildContext context, int index) {
                          return FutureBuilder<List<Datum>?>(
                              future: _allProductController.getCategoryProduct(
                                  tokenp, _categoryData[index].id),
                              builder: (context, snapshot) {
                                // print(
                                //     'matchCategory ${snapshot.data![0].category.categoryName}');

                                if (!snapshot.hasData ||
                                    snapshot.data == null) {
                                  return Center(
                                    child: Container(),
                                  );
                                } else {
                                  if (snapshot.data!.isEmpty) {
                                    return const Center(
                                        child: Text('No Product Found'));
                                  } else {
                                    final data = snapshot.data;

                                    return Column(
                                      children: [
                                        Container(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Row(
                                              children: [
                                                Text(
                                                    _categoryData[index]
                                                        .categoryName,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 22,
                                                        fontWeight:
                                                            FontWeight.normal)),
                                              ],
                                            ),
                                          ),
                                        ),
                                        GridView.builder(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          padding: const EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                              top: 10,
                                              bottom: 30),
                                          itemCount: data!.length < 6
                                              ? data.length
                                              : 6,
                                          scrollDirection: Axis.vertical,
                                          gridDelegate:
                                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                            maxCrossAxisExtent: 200,
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
                                                      data[index]
                                                                  .image[0]
                                                                  .filePath !=
                                                              null
                                                          ? 'http://mamun.click/${data[index].image[0].filePath}'
                                                          : "",
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
                                        ),
                                      ],
                                    );
                                  }
                                }
                              });
                        })
                    : Column(
                        children: [
                          SizedBox(
                            height: size.height * .40,
                          ),
                          Center(
                            child: CircularProgressIndicator(),
                          )
                        ],
                      ),
          ],
        )),
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
              setState(() {
                _showfilter = true;
              });
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
              // Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(builder: (context) => ProfileScreen()),
              // );
            } else if (_selectedIndex == 4) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => ProfileScreen(
                          from: "market",
                        )),
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
                icon: Icon(Icons.search),
                title: Text('Search'),
                activeColor: Colors.white),
            BottomNavyBarItem(
                icon: Icon(Icons.favorite),
                title: Text(
                  'M. Place',
                  overflow: TextOverflow.ellipsis,
                ),
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
    );
  }
}
