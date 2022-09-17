import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sv_craft/Features/cart/view/cart_screen.dart';
import 'package:sv_craft/Features/home/controller/home_controller.dart';
import 'package:sv_craft/Features/profile/view/profile_screen.dart';

import '../../constant/color.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController _homeController = Get.put(HomeController());
  var _selectedIndex = 0;

  late int userId;
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      setTokenToVariable();
    }); //.then((value) => _allProductController.GetAllProduct(tokenp))
  }

  Future<void> setTokenToVariable() async {
    final token = await _homeController.getToken();
    // print('token = ' + token);
    setState(() {
      _homeController.tokenGlobal = token;
    });

    final userid = await _homeController.getUserId();
    // print('token = ' + token);
    setState(() {
      _homeController.userId = userid;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Container(
              height: size.height * .08,
              width: size.width,
              color: Appcolor.primaryColor,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    // CircleAvatar(
                    //   radius: 20,
                    //   backgroundColor: Colors.white, //<-- SEE HERE
                    //   child: IconButton(
                    //     icon: const Icon(
                    //       Icons.menu,
                    //       color: Colors.black,
                    //     ),
                    //     onPressed: () {},
                    //   ),
                    // ),
                    Text(
                      'SV Kraft',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                          color: Appcolor.uperTextColor),
                    ),
                    // CircleAvatar(
                    //   radius: 20,
                    //   backgroundColor: Colors.white, //<-- SEE HERE
                    //   child: IconButton(
                    //     icon: const Icon(
                    //       Icons.favorite_border,
                    //       color: Colors.black,
                    //     ),
                    //     onPressed: () {},
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                child: Container(
                  height: size.height * .25,
                  width: size.width,
                  //color: const Color.fromARGB(255, 70, 192, 230),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color.fromARGB(255, 66, 163, 192),
                        Color.fromARGB(255, 253, 251, 250),
                      ],
                    ),
                    //borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 30,
                      ),
                      const Text("Market Place",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 255, 255, 255))),
                      Spacer(),
                      Image.asset(
                        'images/market.png',
                        fit: BoxFit.cover,
                        width: 140,
                        height: size.height * .25,
                      ),
                      SizedBox(
                        width: 30,
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Get.toNamed('/marketplace');
                },
              ),
            ),
            Expanded(
              child: InkWell(
                child: Container(
                  height: size.height * .25,
                  width: size.width,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color.fromARGB(255, 145, 31, 42),
                        Color.fromARGB(255, 253, 251, 250),
                      ],
                    ),
                    //borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 30,
                      ),
                      const Text("Grocery",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 255, 255, 255))),
                      Spacer(),
                      Image.asset(
                        'images/grocery.png',
                        fit: BoxFit.cover,
                        width: 140,
                        height: size.height * .25,
                      ),
                      SizedBox(
                        width: 30,
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Get.toNamed('/groceryproduct');
                },
              ),
            ),
            Expanded(
              child: InkWell(
                child: Container(
                  height: size.height * .25,
                  width: size.width,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color.fromARGB(255, 158, 30, 105),
                        Color.fromARGB(255, 253, 251, 250),
                      ],
                    ),
                    //borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 30,
                      ),
                      const Text("Special Day",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 255, 255, 255))),
                      Spacer(),
                      Image.asset(
                        'images/special.png',
                        fit: BoxFit.cover,
                        width: 140,
                        height: size.height * .25,
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Get.toNamed("/specialhome");
                },
              ),
            ),
            Expanded(
              child: InkWell(
                child: Container(
                  height: size.height * .25,
                  width: size.width,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color.fromARGB(255, 35, 117, 53),
                        Color.fromARGB(255, 253, 251, 250),
                      ],
                    ),
                    //borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 30,
                      ),
                      const Text("Restaurant",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 255, 255, 255))),
                      Spacer(),
                      Image.asset(
                        'images/restaurant.png',
                        fit: BoxFit.cover,
                        width: 140,
                        height: size.height * .25,
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                    ],
                  ),
                ),
                onTap: () {},
              ),
            ),
          ],
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
              } else if (_selectedIndex == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CartScreen()),
                );
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
              icon: Icon(Icons.shopping_cart),
              label: 'Cart',
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
