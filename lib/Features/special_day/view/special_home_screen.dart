import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sv_craft/Features/home/home_screen.dart';
import 'package:sv_craft/Features/market_place/controller/all_product_controller.dart';
import 'package:sv_craft/Features/profile/view/profile_screen.dart';
import 'package:sv_craft/Features/special_day/controllar/category_1_con.dart';
import 'package:sv_craft/Features/special_day/controllar/special_all_product_con.dart';
import 'package:sv_craft/Features/special_day/model/category_1.dart';
import 'package:sv_craft/Features/special_day/model/special_all_product_model.dart';
import 'package:sv_craft/Features/special_day/view/category_product.dart';
import 'package:sv_craft/Features/special_day/view/product_details.dart';
import 'package:sv_craft/constant/api_link.dart';

import '../../../constant/color.dart';
import '../../../constant/constant.dart';
import 'widgets/category_card.dart';
import 'widgets/special_drawer.dart';

class SpecialHomeScreen extends StatefulWidget {
  SpecialHomeScreen({Key? key}) : super(key: key);

  @override
  State<SpecialHomeScreen> createState() => _SpecialHomeScreenState();
}

class _SpecialHomeScreenState extends State<SpecialHomeScreen> {
  final AllProductController _allProductController =
      Get.put(AllProductController());
  final SpecialAllProductController _specialAllProductController =
      Get.put(SpecialAllProductController());
  final SpecialCategoryController _specialCategory1Controller =
      Get.put(SpecialCategoryController());
  bool _searchBoolean = false;
  List<int> _searchIndexList = [];
  var id;
  var _selectedIndex = 1;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  var tokenp;
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      setTokenToVariable();
    }); //.then((value) => _allProductController.GetAllProduct(tokenp))
  }

  Future<void> setTokenToVariable() async {
    final token = await _allProductController.getToken();
    print('token = ' + token);
    setState(() {
      tokenp = token;
    });
  }

  List<String> _list = [
    'English Textbook',
    'Japanese Textbook',
    'English Vocabulary',
    'Japanese Vocabulary'
  ];

  Widget _searchTextField() {
    return TextField(
      onChanged: (String s) {
        // setState(() {
        //   _searchIndexList = [];
        //   for (int i = 0; i < _list.length; i++) {
        //     if (_list[i].contains(s)) {
        //       _searchIndexList.add(i);
        //     }
        //   }
        // });
      },
      autofocus: true,
      cursorColor: Colors.black,
      style: TextStyle(
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
          color: Appcolor.uperTextColor,
          fontSize: 20,
        ),
      ),
    );
  }

  Widget _searchListView() {
    return ListView.builder(
        itemCount: _searchIndexList.length,
        itemBuilder: (context, index) {
          index = _searchIndexList[index];
          return Card(child: ListTile(title: Text(_list[index])));
        });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        drawer: buildDrawer(),
        appBar: AppBar(
          // leadingWidth: 300,
          // automaticallyImplyLeading: false,
          backgroundColor: Appcolor.primaryColor,
          elevation: 1,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(
                  Icons.menu,
                  color: Appcolor.iconColor,
                  size: 20,
                  // size: 44, // Changing Drawer Icon Size
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),

          title: const Text('Special Day',
              style: TextStyle(
                color: Appcolor.uperTextColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              )),
          //!_searchBoolean ? : _searchTextField(),
          actions: !_searchBoolean
              ? [
                  IconButton(
                    icon: const Icon(
                      Icons.search,
                      color: Appcolor.iconColor,
                      size: 20,
                    ),
                    onPressed: () {
                      // setState(() {
                      //   _searchBoolean = true;
                      //   _searchIndexList = [];
                      // });
                    },
                  ),
                  SizedBox(
                    width: size.width * .02,
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.shopping_cart,
                      color: Appcolor.iconColor,
                      size: 20,
                    ),
                    onPressed: () {
                      // Get.toNamed('/marketfilter');
                    },
                  ),
                  SizedBox(
                    width: size.width * .02,
                  ),
                ]
              : [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.black54, //<-- SEE HERE
                    child: IconButton(
                      icon: const Icon(
                        Icons.clear,
                        color: Appcolor.iconColor,
                        size: 20,
                      ),
                      onPressed: () {
                        setState(() {
                          _searchBoolean = false;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    width: size.width * .02,
                  ),
                ],
        ),
        body: tokenp == null
            ? const Center(
                child: Center(
                    child: Center(
                        child: const SpinKitFadingCircle(
                  color: Colors.black,
                ))),
              )
            : SingleChildScrollView(
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
                      padding: const EdgeInsets.all(10.0),
                      child: FutureBuilder<List<SpecialCategory1Datum>?>(
                          future: _specialCategory1Controller
                              .getCategory1Product(tokenp),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return const Center(
                                  child: Center(
                                      child: Center(
                                          child: const SpinKitFadingCircle(
                                color: Colors.black,
                              ))));
                            } else {
                              if (snapshot.data == null) {
                                return const Center(
                                    child: Center(
                                        child: Center(
                                            child: const SpinKitFadingCircle(
                                  color: Colors.black,
                                ))));
                              } else {
                                final data = snapshot.data;

                                return GridView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 200,
                                    childAspectRatio: 1.4,
                                    mainAxisSpacing: 0.0,
                                    crossAxisSpacing: 0.0,
                                  ),
                                  itemCount: data!.length,
                                  itemBuilder: (context, index) {
                                    return CategoryCard(
                                      text: data[index].name,
                                      imageLink:
                                          '${Appurl.baseURL}${data[index].image}',
                                      textColor: Colors.white,
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CategoryProuctScreen(
                                                    token: tokenp,
                                                    id: data[index].id,
                                                  )),
                                        );
                                      },
                                    );
                                  },
                                );
                              }
                            }
                          }),
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
                                  onTap: () {
                                    Get.toNamed("/specialcategoryproduct");
                                  },
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            child: Container(
                              height: size.height * .3,
                              // color: Colors.blue,
                              child: FutureBuilder<
                                      List<SpecialAllProductData>?>(
                                  future: _specialAllProductController
                                      .getSpecialAllProduct(tokenp, 2),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData ||
                                        snapshot.data == null) {
                                      return const Center(
                                          child: Center(
                                              child: Center(
                                                  child:
                                                      const SpinKitFadingCircle(
                                        color: Colors.black,
                                      ))));
                                    } else {
                                      if (snapshot.data!.isEmpty) {
                                        //snapshot.data!.isEmpty
                                        return const Center(
                                            child: Text('No Product Found'));
                                      } else {
                                        final data = snapshot.data;
                                        id = data![0].id;
                                        return GridView.builder(
                                          padding: const EdgeInsets.only(
                                              left: 15,
                                              right: 15,
                                              top: 20,
                                              bottom: 10),
                                          itemCount: data.length,
                                          scrollDirection: Axis.horizontal,
                                          gridDelegate:
                                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                            maxCrossAxisExtent: 400,
                                            childAspectRatio: 1.35,
                                            mainAxisSpacing: 10,
                                            crossAxisSpacing: 10,
                                          ),
                                          itemBuilder: (BuildContext context,
                                                  int index) =>
                                              Container(
                                            // color: Colors.red,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: Colors
                                                      .black12, //color of shadow
                                                  spreadRadius:
                                                      2, //spread radius
                                                  blurRadius: 5, // blur radius
                                                  offset: Offset(0,
                                                      1), // changes position of shadow
                                                  //first paramerter of offset is left-right
                                                  //second parameter is top to down
                                                )
                                              ],
                                            ),

                                            child: Column(
                                              children: [
                                                //SizedBox(height: size.height * .01),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10,
                                                      vertical: 10),
                                                  child: Image.network(
                                                    'http://mamun.click/${data[index].image}',
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
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          width:
                                                              size.width * .4,
                                                          child: Text(
                                                            data[index].name,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                            textAlign:
                                                                TextAlign.start,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Text(
                                                          "Price: ${data[index].price}",
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w500,
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
                                        );
                                      }
                                    }
                                  }),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductDetails(
                                          id: id,
                                          token: tokenp,
                                        )),
                              );
                            },
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
                                  onTap: () {
                                    Get.toNamed("/specialcategoryproduct");
                                  },
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            child: Container(
                              height: size.height * .3,
                              // color: Colors.blue,
                              child: FutureBuilder<
                                      List<SpecialAllProductData>?>(
                                  future: _specialAllProductController
                                      .getSpecialAllProduct(tokenp, 2),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData ||
                                        snapshot.data == null) {
                                      return const Center(
                                          child: Center(
                                              child: Center(
                                                  child:
                                                      const SpinKitFadingCircle(
                                        color: Colors.black,
                                      ))));
                                    } else {
                                      if (snapshot.data!.isEmpty) {
                                        //snapshot.data!.isEmpty
                                        return const Center(
                                            child: Text('No Product Found'));
                                      } else {
                                        final data = snapshot.data;
                                        id = data![0].id;
                                        return GridView.builder(
                                          padding: const EdgeInsets.only(
                                              left: 15,
                                              right: 15,
                                              top: 20,
                                              bottom: 10),
                                          itemCount: data.length,
                                          scrollDirection: Axis.horizontal,
                                          gridDelegate:
                                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                            maxCrossAxisExtent: 400,
                                            childAspectRatio: 1.35,
                                            mainAxisSpacing: 10,
                                            crossAxisSpacing: 10,
                                          ),
                                          itemBuilder: (BuildContext context,
                                                  int index) =>
                                              Container(
                                            // color: Colors.red,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: Colors
                                                      .black12, //color of shadow
                                                  spreadRadius:
                                                      2, //spread radius
                                                  blurRadius: 5, // blur radius
                                                  offset: Offset(0,
                                                      1), // changes position of shadow
                                                  //first paramerter of offset is left-right
                                                  //second parameter is top to down
                                                )
                                              ],
                                            ),

                                            child: Column(
                                              children: [
                                                //SizedBox(height: size.height * .01),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10,
                                                      vertical: 10),
                                                  child: Image.network(
                                                    'http://mamun.click/${data[index].image}',
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
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          width:
                                                              size.width * .4,
                                                          child: Text(
                                                            data[index].name,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                            textAlign:
                                                                TextAlign.start,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Text(
                                                          "Price: ${data[index].price}",
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w500,
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
                                        );
                                      }
                                    }
                                  }),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductDetails(
                                          id: id,
                                          token: tokenp,
                                        )),
                              );
                            },
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
                                  onTap: () {
                                    Get.toNamed("/specialcategoryproduct");
                                  },
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            child: Container(
                              height: size.height * .3,
                              // color: Colors.blue,
                              child: FutureBuilder<
                                      List<SpecialAllProductData>?>(
                                  future: _specialAllProductController
                                      .getSpecialAllProduct(tokenp, 2),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData ||
                                        snapshot.data == null) {
                                      return const Center(
                                          child: Center(
                                              child: Center(
                                                  child:
                                                      const SpinKitFadingCircle(
                                        color: Colors.black,
                                      ))));
                                    } else {
                                      if (snapshot.data!.isEmpty) {
                                        //snapshot.data!.isEmpty
                                        return const Center(
                                            child: Text('No Product Found'));
                                      } else {
                                        final data = snapshot.data;
                                        id = data![0].id;
                                        return GridView.builder(
                                          padding: const EdgeInsets.only(
                                              left: 15,
                                              right: 15,
                                              top: 20,
                                              bottom: 10),
                                          itemCount: data.length,
                                          scrollDirection: Axis.horizontal,
                                          gridDelegate:
                                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                            maxCrossAxisExtent: 400,
                                            childAspectRatio: 1.35,
                                            mainAxisSpacing: 10,
                                            crossAxisSpacing: 10,
                                          ),
                                          itemBuilder: (BuildContext context,
                                                  int index) =>
                                              Container(
                                            // color: Colors.red,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: Colors
                                                      .black12, //color of shadow
                                                  spreadRadius:
                                                      2, //spread radius
                                                  blurRadius: 5, // blur radius
                                                  offset: Offset(0,
                                                      1), // changes position of shadow
                                                  //first paramerter of offset is left-right
                                                  //second parameter is top to down
                                                )
                                              ],
                                            ),

                                            child: Column(
                                              children: [
                                                //SizedBox(height: size.height * .01),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10,
                                                      vertical: 10),
                                                  child: Image.network(
                                                    'http://mamun.click/${data[index].image}',
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
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          width:
                                                              size.width * .4,
                                                          child: Text(
                                                            data[index].name,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                            textAlign:
                                                                TextAlign.start,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Text(
                                                          "Price: ${data[index].price}",
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w500,
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
                                        );
                                      }
                                    }
                                  }),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductDetails(
                                          id: id,
                                          token: tokenp,
                                        )),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
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
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              } else if (_selectedIndex == 1) {
                print("This is Special day");
              } else if (_selectedIndex == 2) {
                Navigator.pushReplacement(
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
              icon: Icon(Icons.favorite),
              label: 'Special Day',
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
}
