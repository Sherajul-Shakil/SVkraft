import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/color.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.white, //<-- SEE HERE
                    child: IconButton(
                      icon: const Icon(
                        Icons.menu,
                        color: Colors.black,
                      ),
                      onPressed: () {},
                    ),
                  ),
                  const Text(
                    'SV Kraft',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.white, //<-- SEE HERE
                    child: IconButton(
                      icon: const Icon(
                        Icons.favorite_border,
                        color: Colors.black,
                      ),
                      onPressed: () {},
                    ),
                  ),
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
              onTap: () {},
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
                      Color.fromARGB(255, 150, 67, 75),
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
                      Color.fromARGB(255, 124, 84, 88),
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
              onTap: () {},
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
                      Color.fromARGB(255, 155, 141, 132),
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
                    const Text("Child Care",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(255, 255, 255, 255))),
                    Spacer(),
                    Image.asset(
                      'images/child.png',
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
    ));
  }
}
