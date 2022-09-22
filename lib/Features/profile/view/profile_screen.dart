import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sv_craft/Features/auth/view/signin_screen.dart';
import 'package:sv_craft/Features/cart/view/cart_screen.dart';
import 'package:sv_craft/Features/home/controller/home_controller.dart';
import 'package:sv_craft/Features/home/home_screen.dart';
import 'package:sv_craft/Features/profile/controller/get_profile_con.dart';
import 'package:sv_craft/Features/profile/view/edit_profile.dart';
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
  HomeController _homeController = Get.put(HomeController());
  GetProfileController _getProfileController = Get.put(GetProfileController());
  PageController? _pageController;
  var _selectedIndex = 4;
  var Profile;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(microseconds: 00), () async {
      setTokenToVariable();
    });
  }

  Future<void> setTokenToVariable() async {
    var profile =
        await _getProfileController.getProfile(_homeController.tokenGlobal);
    if (profile != null) {
      setState(() {
        Profile = profile;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Profile != null
              ? Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 50.0,
                          width: 50.0,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('images/child.png'),
                                fit: BoxFit.fill,
                              ),
                              shape: BoxShape.circle,
                              color: Colors.white),
                        ),
                        Spacer(),
                        IconButton(
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
                              color: Colors.black54,
                              size: 30,
                            )),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: size.height * .02,
                        ),
                        ListTile(
                          tileColor: Colors.grey[200],
                          leading: const Icon(
                            Icons.person,
                            size: 25,
                          ),
                          title: Text(
                            Profile.name,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black54,
                            ),
                          ),
                          onTap: () {
                            // Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.list_alt_outlined,
                            size: 25,
                          ),
                          title: const Text(
                            'My ads',
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
                        ListTile(
                          leading: const Icon(
                            Icons.person,
                            size: 25,
                          ),
                          title: const Text(
                            'My Profile',
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
                        ListTile(
                          leading: const Icon(
                            Icons.card_membership,
                            size: 25,
                          ),
                          title: const Text(
                            'My Membership',
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
                        ListTile(
                          leading: const Icon(
                            Icons.calendar_month,
                            size: 25,
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

                        ListTile(
                          leading: const Icon(
                            Icons.transgender,
                            size: 25,
                          ),
                          title: const Text(
                            'Gender',
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

                        ListTile(
                          leading: const Icon(
                            Icons.phone_android,
                            size: 25,
                          ),
                          title: Text(
                            Profile.phone,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black54,
                            ),
                          ),
                          onTap: () {
                            // Navigator.pop(context);
                          },
                        ),

                        ListTile(
                          leading: const Icon(
                            Icons.email_rounded,
                            size: 25,
                          ),
                          title: Text(
                            Profile.email,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black54,
                            ),
                          ),
                          onTap: () {
                            // Navigator.pop(context);
                          },
                        ),
                        // Divider(
                        //   color: Colors.black12,
                        //   thickness: 2,
                        // ),
                        ListTile(
                          leading: const Icon(
                            Icons.location_city_sharp,
                            size: 25,
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
                        // const Divider(
                        //   color: Colors.black12,
                        //   thickness: 2,
                        // ),
                        // const SizedBox(
                        //   height: 30,
                        // ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * .48,
                    ),
                    TextButton(
                        onPressed: () {
                          Get.to(() => EditProfile());
                        },
                        child: Text("EDIT")),
                    // Container(
                    //   alignment: Alignment.center,
                    //   decoration: BoxDecoration(
                    //     gradient: const LinearGradient(
                    //       begin: Alignment.topCenter,
                    //       end: Alignment.bottomCenter,
                    //       colors: [
                    //         Appcolor.circleColor,
                    //         Color.fromARGB(255, 128, 118, 175),
                    //       ],
                    //     ),
                    //     borderRadius: BorderRadius.circular(30),
                    //   ),
                    //   width: 200,
                    //   height: 50,
                    //   child: InkWell(
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: const [
                    //         Text(
                    //           'Edit Profile',
                    //           style: TextStyle(
                    //               color: Appcolor.uperTextColor, fontSize: 25),
                    //           textAlign: TextAlign.center,
                    //         ),
                    //         SizedBox(
                    //           width: 10,
                    //         ),
                    //         Icon(
                    //           FontAwesome.pen_to_square,
                    //           color: Appcolor.uperTextColor,
                    //           size: 22,
                    //         )
                    //       ],
                    //     ),
                    //     onTap: () {
                    //       // Get.toNamed("/editprofile");
                    //     },
                    //   ),
                    // ),
                    SizedBox(
                      height: size.height * .08,
                    ),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: size.height * .45,
                    ),
                    Center(child: CircularProgressIndicator()),
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
              // Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(builder: (context) => ProfileScreen()),
              // );

            } else if (_selectedIndex == 3) {
              // Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(builder: (context) => ProfileScreen()),
              // );
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
