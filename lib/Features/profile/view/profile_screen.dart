import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sv_craft/constant/color.dart';
import 'package:icons_plus/icons_plus.dart';
import 'custom_shape.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
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
                    style:
                        TextStyle(fontSize: 30, color: Appcolor.uperTextColor),
                  )
                ],
              )),
        ),
        Positioned(
          top: 35,
          //left: 120,
          right: 10,
          child: IconButton(
              onPressed: () {},
              icon: Icon(
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
                          Icons.edit_road,
                          color: Appcolor.uperTextColor,
                          size: 25,
                        )
                      ],
                    ),
                    onTap: () {
                      Get.toNamed("/editprofile");
                      print("object");
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
