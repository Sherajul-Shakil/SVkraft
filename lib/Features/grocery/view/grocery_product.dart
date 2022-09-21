import 'dart:async';
import 'dart:ui';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:sv_craft/Features/bookmarks/controller/add_to_bookmarks_con.dart';
import 'package:sv_craft/Features/grocery/controllar/all_product_controller.dart';
import 'package:sv_craft/Features/grocery/controllar/category_controller.dart';
import 'package:sv_craft/Features/grocery/controllar/searched_product_con.dart';
import 'package:sv_craft/Features/grocery/model/all_product_model.dart';
import 'package:sv_craft/Features/grocery/view/widgets/filter_category.dart';
import 'package:sv_craft/Features/grocery/view/widgets/grocery_drawer.dart';
import 'package:sv_craft/Features/grocery/view/widgets/grocery_count.dart';
import 'package:sv_craft/Features/home/bottom_bar.dart';
import 'package:sv_craft/Features/home/grocery_nav.dart';
import 'package:sv_craft/Features/home/home_screen.dart';
import 'package:sv_craft/Features/market_place/controller/all_product_controller.dart';
import 'package:sv_craft/Features/profile/view/profile_screen.dart';
import 'package:sv_craft/constant/api_link.dart';
import 'package:sv_craft/constant/constant.dart';

import '../../../constant/color.dart';

class GroceryProduct extends StatefulWidget {
  @override
  _GroceryProductState createState() {
    return _GroceryProductState();
  }
}

class _GroceryProductState extends State<GroceryProduct> {
  final AllProductController _allProductController =
      Get.put(AllProductController());
  final GroceryAllProductController _groceryAllProductController =
      Get.put(GroceryAllProductController());
  final GrocerySearchController _grocerySearchController =
      Get.put(GrocerySearchController());
  final AddtoBookmarksController _addtoBookmarksController =
      Get.put(AddtoBookmarksController());

  // Variable
  var tokenp;
  late int userId;
  bool _isSearched = false;
  var searchedData;
  var _selectedIndex = 1;

  final TextEditingController _searchController = TextEditingController();

  // @override
  // void onDispose() {
  //   _searchController.dispose();
  //   super.dispose();
  // }

  Future<void> setTokenToVariable() async {
    final token = await _allProductController.getToken();

    setState(() {
      tokenp = token;
    });

    final userid = await _allProductController.getUserId();

    setState(() {
      userId = userid;
    });
  }

  bool _searchBoolean = false;
  List<int> _searchIndexList = [];
  var product = 0;

  Widget _searchTextField() {
    return TextField(
      controller: _searchController,
      onChanged: (String name) async {
        Future.delayed(const Duration(seconds: 1), () async {
          final searchProduct = await _grocerySearchController
              .getGrocerySearchProduct(tokenp, name);
          print(name);

          if (searchProduct != null) {
            setState(() {
              _isSearched = true;
              searchedData = searchProduct;
              // print('searchProduct = ${searchedData[0].name}');
            });
          }
        });
        // final searchProduct = await _grocerySearchController
        //     .getGrocerySearchProduct(tokenp, name);
        // print(name);

        // if (searchProduct != null) {
        //   setState(() {
        //     _isSearched = true;
        //     searchedData = searchProduct;
        //     // print('searchProduct = ${searchedData[0].name}');
        //   });
        // }
      },
      autofocus: true,
      cursorColor: Colors.black,
      style: const TextStyle(
        color: Colors.black,
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
          color: Appcolor.textColor,
          fontSize: 20,
        ),
      ),
    );
  }

  //Access confirmation dialog
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool haveaccess = true;
  bool accessreq = false;
  bool accessgrant = false;
  @override
  void initState() {
    super.initState();

    haveaccess
        ? print('have access')
        : accessreq
            ? Timer(const Duration(seconds: 1), () {
                _showaccessbegged();
              })
            : accessgrant
                ? print("Access granted")
                : Timer(const Duration(seconds: 1), () {
                    _showMyDialog();
                  });
    Future.delayed(Duration.zero, () async {
      setTokenToVariable();
    });
    Future.delayed(const Duration(seconds: 2), () async {
      const Center(
          child: Center(
              child: SpinKitFadingCircle(
        color: Colors.black,
      )));
    });
  }

  @override
  Widget build(BuildContext context) {
    print('tokenp = ' + tokenp.toString());
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 135, 235, 157),
        key: _scaffoldKey,
        drawer: buildDrawer(),
        //drawer: Drawer(backgroundColor: Colors.blue.withOpacity(0)),

        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed('/cart');
          },
          child: Badge(
            elevation: 0,
            badgeContent: const Text(
              '',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
            badgeColor: Colors.transparent,
            child: const Icon(
              Icons.shopping_cart_outlined,
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

        //AppBar code
        appBar: AppBar(
          leadingWidth: 100,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0,
          leading: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: size.width * .02,
              ),
              CircleAvatar(
                radius: 18,
                backgroundColor: Colors.black, //<-- SEE HERE
                child: IconButton(
                  icon: const Icon(
                    Icons.menu,
                    color: Colors.white,
                    size: 20,
                  ),
                  onPressed: () {
                    _scaffoldKey.currentState!.openDrawer();
                  },
                ),
              ),
              SizedBox(
                width: size.width * .02,
              ),
              CircleAvatar(
                radius: 18,
                backgroundColor: Colors.black, //<-- SEE HERE
                child: IconButton(
                  icon: const Icon(
                    FontAwesome.sliders,
                    color: Colors.white,
                    size: 20,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FilterCatogory(
                                  token: tokenp,
                                )));
                  },
                ),
              ),
            ],
          ),
          title: !_searchBoolean
              ? const Text(
                  "Grocery Products",
                  style: const TextStyle(
                    color: Appcolor.primaryColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : _searchTextField(),
          actions: !_searchBoolean
              ? [
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.black, //<-- SEE HERE
                    child: IconButton(
                      icon: const Icon(
                        Icons.search,
                        color: Colors.white,
                        size: 20,
                      ),
                      onPressed: () {
                        setState(() {
                          Future.delayed(const Duration(microseconds: 500),
                              () async {
                            _searchBoolean = true;
                          });

                          // _searchIndexList = [];
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
                    backgroundColor: Colors.black, //<-- SEE HERE
                    child: IconButton(
                      icon: const Icon(
                        Icons.clear,
                        color: Colors.white,
                        size: 20,
                      ),
                      onPressed: () {
                        setState(() {
                          Future.delayed(const Duration(microseconds: 500),
                              () async {
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

        //Body code
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                automaticallyImplyLeading: false,
                expandedHeight: size.height * .30,
                pinned: false,
                floating: true,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Container(),
                  background: Container(
                    color: Appcolor.primaryColor,
                    child: Column(
                      children: [
                        SizedBox(height: size.height * .1),
                        const Text("It is a long established",
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w500,
                                color: Colors.white)),
                        SizedBox(height: size.height * .03),
                        const Text("The point of using Lorem",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.white)),
                        SizedBox(height: size.height * .03),
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
                                  offset: Offset(
                                      0, 2), // changes position of shadow
                                  //first paramerter of offset is left-right
                                  //second parameter is top to down
                                )
                              ],
                            ),
                            width: 153,
                            height: 37,
                            child: const Text('SHOP NOW'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ];
          },
          body: _isSearched
              ? GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(
                      left: 15, right: 15, top: 20, bottom: 10),
                  itemCount: searchedData!.length,
                  scrollDirection: Axis.vertical,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
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
                        // SizedBox(height: size.height * .01),
                        Row(
                          children: [
                            SizedBox(width: size.width * .01),
                            IconButton(
                                onPressed: () {
                                  //var message = _addtoBookmarksController.addToBookmarks(userid : userId, pro , token: tokenp,);
                                },
                                icon: const Icon(
                                  FontAwesome.bookmark,
                                  color: Colors.black,
                                  size: 18,
                                )),
                            const Spacer(),
                            Text(
                              searchedData[index].marketPrice.toString(),
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
                                '${Appurl.baseURL}${searchedData[index].image}',
                                // AppImage.carouselImages[index],
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
                                    "${searchedData[index].offPrice.toString()}% off",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
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
                                  searchedData[index].name,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                                Text(
                                  "${searchedData[index].price} kr",
                                  style: const TextStyle(
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
                                    searchedData[index].description ?? "",
                                    style: const TextStyle(
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
                        searchedData != null
                            ? GroceryCount(
                                index: index,
                                productId: searchedData[index].id,
                                price: searchedData[index].price,
                              )
                            : const Center(
                                child: Center(
                                    child: SpinKitFadingCircle(
                                color: Colors.black,
                              ))),
                      ],
                    ),
                    // height: 147,
                    // width: ,
                  ),
                )
              : tokenp == null
                  ? const Center(
                      child: Center(
                          child: Center(
                              child: const SpinKitFadingCircle(
                        color: Colors.black,
                      ))),
                    )
                  : FutureBuilder<List<GroceryAllProductData>?>(
                      future: _groceryAllProductController
                          .getGroceryAllProduct(tokenp),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData || snapshot.data == null) {
                          return const Center(
                              child: Center(
                                  child: Center(
                                      child: const SpinKitFadingCircle(
                            color: Colors.black,
                          ))));
                        } else {
                          if (snapshot.data!.isEmpty) {
                            return const Center(
                                child: Text('No Product Found'));
                          } else {
                            final data = snapshot.data;
                            return GridView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, top: 20, bottom: 10),
                              itemCount: data!.length,
                              scrollDirection: Axis.vertical,
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 200,
                                // crossAxisCount: 2,
                                childAspectRatio: .48,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                              ),
                              itemBuilder: (BuildContext context, int index) =>
                                  Container(
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
                                      offset: Offset(
                                          0, 2), // changes position of shadow
                                      //first paramerter of offset is left-right
                                      //second parameter is top to down
                                    )
                                  ],
                                ),

                                child: Column(
                                  children: [
                                    // SizedBox(height: size.height * .01),
                                    Row(
                                      children: [
                                        SizedBox(width: size.width * .01),
                                        IconButton(
                                            onPressed: () async {
                                              var message =
                                                  await _addtoBookmarksController
                                                      .addToBookmarks(
                                                          userId,
                                                          data[index].id,
                                                          "grocery",
                                                          tokenp);

                                              if (message != null) {
                                                Get.snackbar(
                                                    "Product Added to Bookmarks",
                                                    message);
                                              } else {
                                                print("Not Added");
                                              }
                                            },
                                            icon: const Icon(
                                              FontAwesome.bookmark,
                                              color: Colors.black,
                                              size: 18,
                                            )),
                                        const Spacer(),
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
                                            'http://mamun.click/${data[index].image}',
                                            fit: BoxFit.cover,
                                            width: 140,
                                            height: 160,
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
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.red),
                                              ),
                                            ))
                                      ],
                                    ),
                                    // SizedBox(
                                    //   height: size.height * .02,
                                    // ),
                                    Row(
                                      children: [
                                        SizedBox(width: size.width * .03),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              data[index].name,
                                              style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black,
                                              ),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              "${data[index].price} kr",
                                              style: const TextStyle(
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
                                      height: size.height * .01,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(width: size.width * .03),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: size.height * .06,
                                              width: size.width * .4,
                                              child: Text(
                                                data[index].description,
                                                style: const TextStyle(
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
                                    data != null
                                        ? GroceryCount(
                                            index: index,
                                            // userId: userId,
                                            productId: data[index].id,
                                            price: data[index].price,
                                          )
                                        : const Center(
                                            child: Center(
                                                child: SpinKitFadingCircle(
                                            color: Colors.black,
                                          ))),
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
        // bottomNavigationBar: const GroceryNav(),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Appcolor.primaryColor,
          selectedItemColor: Appcolor.iconColor,
          unselectedItemColor: Colors.grey,
          currentIndex: _selectedIndex,
          onTap: (int index) {
            setState(() {
              _selectedIndex = index;
              print(_selectedIndex);
              if (_selectedIndex == 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              } else if (_selectedIndex == 1) {
                print('This is Grocery page');
              } else if (_selectedIndex == 2) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
                );
              }
            });
          },
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                FontAwesome.bag_shopping,
              ),
              label: 'Grocery',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showMyDialog() async {
    print("object");
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Container(
            color: Colors.black54,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "You don't have",
                  style: const TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    decoration: TextDecoration.none,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  "access for",
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    decoration: TextDecoration.none,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  "SVCRAFT SHOP",
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    decoration: TextDecoration.none,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();

                    _showaccessbegged();
                  },
                  child: const Text(
                    "Get Access",
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    primary: Colors.red,
                  ),
                )
              ],
            ));
      },
    );
  }

  Future<void> _showaccessbegged() async {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Container(
            color: Colors.black54,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Card(
                  color: Colors.redAccent,
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      "Your request in review\nplease wait!",
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        decoration: TextDecoration.none,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ));
      },
    );
  }
}

// class GroceryCount extends StatelessWidget {
//   const GroceryCount({
//     Key? key,
//     required this.index,
//   }) : super(key: key);

//   final int index;
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         InkWell(
//           onTap: () {},
//           child: Container(
//             alignment: Alignment.center,
//             decoration: BoxDecoration(
//               color: Appcolor.primaryColor,
//               borderRadius: BorderRadius.circular(100),
//               boxShadow: const [
//                 BoxShadow(
//                   color: Colors.black12, //color of shadow
//                   spreadRadius: 2, //spread radius
//                   blurRadius: 5, // blur radius
//                   offset: Offset(0, 2), // changes position of shadow
//                   //first paramerter of offset is left-right
//                   //second parameter is top to down
//                 )
//               ],
//             ),
//             width: 35,
//             height: 35,
//             child: const Text(
//               '-',
//               style: TextStyle(color: Colors.white, fontSize: 25),
//               textAlign: TextAlign.center,
//             ),
//           ),
//         ),
//         const SizedBox(
//           width: 8,
//         ),
//         InkWell(
//           onTap: () {},
//           child: Container(
//             alignment: Alignment.center,
//             decoration: BoxDecoration(
//               color: Appcolor.primaryColor,
//               borderRadius: BorderRadius.circular(8),
//               boxShadow: const [
//                 BoxShadow(
//                   color: Colors.black12, //color of shadow
//                   spreadRadius: 2, //spread radius
//                   blurRadius: 5, // blur radius
//                   offset: Offset(0, 2), // changes position of shadow
//                   //first paramerter of offset is left-right
//                   //second parameter is top to down
//                 )
//               ],
//             ),
//             width: 50,
//             height: 35,
//             child: const Text(
//               '10',
//               style: TextStyle(color: Colors.white, fontSize: 20),
//               textAlign: TextAlign.center,
//             ),
//           ),
//         ),
//         const SizedBox(
//           width: 8,
//         ),
//         InkWell(
//           onTap: () {},
//           child: Container(
//             padding: const EdgeInsets.all(5),
//             alignment: Alignment.center,
//             decoration: BoxDecoration(
//               color: Appcolor.primaryColor,
//               borderRadius: BorderRadius.circular(100),
//               boxShadow: const [
//                 BoxShadow(
//                   color: Colors.black12, //color of shadow
//                   spreadRadius: 2, //spread radius
//                   blurRadius: 5, // blur radius
//                   offset: Offset(0, 2), // changes position of shadow
//                   //first paramerter of offset is left-right
//                   //second parameter is top to down
//                 )
//               ],
//             ),
//             width: 35,
//             height: 35,
//             child: const Text(
//               '+',
//               style: TextStyle(color: Colors.white, fontSize: 20),
//               textAlign: TextAlign.center,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
