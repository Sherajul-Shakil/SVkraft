import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sv_craft/Features/auth/view/signin_screen.dart';
import 'package:sv_craft/Features/cart/view/cart_screen.dart';
import 'package:sv_craft/Features/grocery/view/grocery_product.dart';
import 'package:sv_craft/Features/home/bottom_bar.dart';
import 'package:sv_craft/Features/home/home_screen.dart';
import 'package:sv_craft/Features/market_place/controller/all_product_controller.dart';
import 'package:sv_craft/constant/color.dart';
import 'package:icons_plus/icons_plus.dart';
import '../controller/logout_controller.dart';
import 'custom_shape.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final LogoutController _logoutController = Get.put(LogoutController());
  var tokenp;
  var _selectedIndex = 2;

  final AllProductController _allProductController =
      Get.put(AllProductController());

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
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    print('tokenp = ' + tokenp);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                ClipPath(
                  clipper: Customshape(),
                  child: Container(
                      height: 350,
                      width: MediaQuery.of(context).size.width,
                      color: Appcolor.primaryColor,
                      child: Column(
                        children: const [
                          SizedBox(
                            height: 100,
                          ),
                          Text(
                            "Sherajul Islam",
                            style: TextStyle(
                                fontSize: 30, color: Appcolor.uperTextColor),
                          )
                        ],
                      )),
                ),
                Positioned(
                  top: 35,
                  //left: 120,
                  right: 10,
                  child: IconButton(
                      onPressed: () async {
                        // var message = await _logoutController.logout(tokenp);
                        // print(message);
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();

                        await prefs.remove('auth-token');
                        await prefs.remove('user-id');

                        Get.offAll(() => SigninScreen());
                      },
                      icon: const Icon(
                        FontAwesome.power_off,
                        color: Appcolor.uperTextColor,
                        size: 30,
                      )),
                ),
                Positioned(
                  top: 210,
                  left: 120,
                  right: 120,
                  child: Container(
                    height: 130.0,
                    width: 130.0,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('images/child.png'),
                          fit: BoxFit.fill,
                        ),
                        shape: BoxShape.circle,
                        color: Colors.white),
                  ),
                ),
                Positioned(
                  top: 350,
                  child: Container(
                    height: size.height,
                    width: size.width,
                    // color: Colors.red,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ListTile(
                          leading: const Icon(
                            Icons.person,
                            size: 30,
                          ),
                          title: const Text(
                            'Sherajul Islam',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black54,
                            ),
                          ),
                          onTap: () {
                            // Navigator.pop(context);
                          },
                        ),
                        Divider(
                          color: Colors.black12,
                          thickness: 2,
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.calendar_month,
                            size: 30,
                          ),
                          title: const Text(
                            'Birthday',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black54,
                            ),
                          ),
                          onTap: () async {
                            // Navigator.pop(context);
                            // _logoutController.logout();
                          },
                        ),
                        Divider(
                          color: Colors.black12,
                          thickness: 2,
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.phone_android,
                            size: 30,
                          ),
                          title: const Text(
                            '01988578353',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black54,
                            ),
                          ),
                          onTap: () {
                            // Navigator.pop(context);
                          },
                        ),
                        Divider(
                          color: Colors.black12,
                          thickness: 2,
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.email_rounded,
                            size: 30,
                          ),
                          title: const Text(
                            'shakil@gmail.com',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black54,
                            ),
                          ),
                          onTap: () {
                            // Navigator.pop(context);
                          },
                        ),
                        Divider(
                          color: Colors.black12,
                          thickness: 2,
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.location_city_sharp,
                            size: 30,
                          ),
                          title: const Text(
                            'Address',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black54,
                            ),
                          ),
                          onTap: () {
                            // Navigator.pop(context);
                          },
                        ),
                        const Divider(
                          color: Colors.black12,
                          thickness: 2,
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size.height * .45,
            ),
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Appcolor.circleColor,
                    Color.fromARGB(255, 128, 118, 175),
                  ],
                ),
                borderRadius: BorderRadius.circular(30),
              ),
              width: 200,
              height: 50,
              child: InkWell(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Edit Profile',
                      style: TextStyle(
                          color: Appcolor.uperTextColor, fontSize: 25),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      FontAwesome.pen_to_square,
                      color: Appcolor.uperTextColor,
                      size: 22,
                    )
                  ],
                ),
                onTap: () {
                  // Get.toNamed("/editprofile");
                },
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            } else if (_selectedIndex == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartScreen()),
              );
            } else if (_selectedIndex == 2) {
              print("This is Profile page");
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
    );
  }
}
