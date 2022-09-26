import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sv_craft/Features/cart/view/cart_screen.dart';
import 'package:sv_craft/Features/home/home_screen.dart';
import 'package:sv_craft/Features/profile/view/profile_screen.dart';
import 'package:sv_craft/Features/special_day/controllar/special_all_product_con.dart';
import 'package:sv_craft/Features/special_day/view/product_details.dart';
import 'package:sv_craft/Features/special_day/view/special_home_screen.dart';
import 'package:sv_craft/constant/api_link.dart';
import 'package:sv_craft/constant/color.dart';
import '../model/special_all_product_model.dart';

class CategoryProuctScreen extends StatefulWidget {
  CategoryProuctScreen({
    Key? key,
    required this.id,
    required this.token,
  }) : super(key: key);
  final int id;
  final String token;
  @override
  State<CategoryProuctScreen> createState() => _CategoryProuctScreenState();
}

class _CategoryProuctScreenState extends State<CategoryProuctScreen> {
  final SpecialAllProductController _specialAllProductController =
      Get.put(SpecialAllProductController());
  var id;
  var _selectedIndex = 2;
  PageController? _pageController;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // final productCount = AppImage.carouselImages.length;
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   title: Text(''),
        // ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: size.height - 80,
                // color: Colors.blue,
                child: FutureBuilder<List<SpecialAllProductData>?>(
                    future: _specialAllProductController.getSpecialAllProduct(
                        widget.token, widget.id),
                    builder: (context, snapshot) {
                      // print('Print from ui ${snapshot.data}');
                      if (!snapshot.hasData || snapshot.data == []) {
                        return const Center(
                            child: Center(
                                child: Center(
                                    child: const SpinKitFadingCircle(
                          color: Colors.black,
                        ))));
                      } else {
                        if (!snapshot.hasData) {
                          //snapshot.data!.isEmpty
                          return const Center(child: Text('No Product Found'));
                        } else {
                          final data = snapshot.data;

                          return GridView.builder(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 20, bottom: 10),
                            itemCount: data!.length,
                            scrollDirection: Axis.vertical,
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 200,
                              childAspectRatio: .65,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                            ),
                            itemBuilder: (BuildContext context, int index) =>
                                InkWell(
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
                                          0, 1), // changes position of shadow
                                      //first paramerter of offset is left-right
                                      //second parameter is top to down
                                    )
                                  ],
                                ),

                                child: Column(
                                  children: [
                                    SizedBox(height: size.height * .01),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 5),
                                      child: Image.network(
                                        data[index].image != null
                                            ? '${Appurl.baseURL}${data[index].image}'
                                            : 'https://upload.wikimedia.org/wikipedia/commons/d/dd/Avatar_flower.png',
                                        fit: BoxFit.cover,
                                        width: size.width * .4,
                                        height: size.height * .22,
                                      ),
                                    ),
                                    SizedBox(
                                      height: size.height * .01,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: size.width * .03,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: size.width * .4,
                                              child: Text(
                                                data[index].name,
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black,
                                                ),
                                                textAlign: TextAlign.start,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            SizedBox(height: size.height * .01),
                                            Text(
                                              'Price : ${data[index].price} kr',
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
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProductDetails(
                                            id: data[index].id,
                                            token: widget.token,
                                          )),
                                );
                              },
                            ),
                          );
                        }
                      }
                    }),
              ),
              SizedBox(height: size.height * .02),
            ],
          ),
        ),
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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const CartScreen()),
              );
            } else if (_selectedIndex == 2) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => SpecialHomeScreen()),
              );
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
                          from: "special",
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
                icon: Icon(Icons.shopping_cart),
                title: Text('Cart'),
                activeColor: Colors.white),
            BottomNavyBarItem(
                icon: Icon(Icons.favorite),
                title: Text('Special Day'),
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
