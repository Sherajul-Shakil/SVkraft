import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                      icon: Icon(
                        Icons.menu,
                        color: Colors.black,
                      ),
                      onPressed: () {},
                    ),
                  ),
                  Text(
                    'Categories',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.white, //<-- SEE HERE
                    child: IconButton(
                      icon: Icon(
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
                color: Color.fromARGB(255, 70, 192, 230),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Market Place",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(255, 255, 255, 255))),
                    Image.asset(
                      'images/market.png',
                      fit: BoxFit.cover,
                      width: 120,
                      height: size.height * .25,
                    ),
                  ],
                ),
              ),
              onTap: () {
                Get.toNamed('/marketproduct');
              },
            ),
          ),
          Expanded(
            child: InkWell(
              child: Container(
                height: size.height * .25,
                width: size.width,
                color: Color.fromARGB(255, 45, 114, 218),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Grocery",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(255, 255, 255, 255))),
                    Image.asset(
                      'images/grocery.png',
                      fit: BoxFit.cover,
                      width: 120,
                      height: size.height * .25,
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
                color: Color.fromARGB(255, 116, 33, 194),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Special Day",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(255, 255, 255, 255))),
                    Image.asset(
                      'images/special.png',
                      fit: BoxFit.cover,
                      width: 120,
                      height: size.height * .25,
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
                color: Color.fromARGB(255, 155, 43, 90),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Child Care",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(255, 255, 255, 255))),
                    Image.asset(
                      'images/child.png',
                      fit: BoxFit.cover,
                      width: 120,
                      height: size.height * .25,
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
