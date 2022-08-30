import 'package:flutter/material.dart';

import 'home_caroucel.dart';

class Testpage extends StatefulWidget {
  const Testpage({Key? key}) : super(key: key);

  @override
  State<Testpage> createState() => _TestpageState();
}

class _TestpageState extends State<Testpage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: size.height * .22,
            width: size.width,
            color: Colors.red,
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
                    'SHOP',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.white, //<-- SEE HERE
                    child: IconButton(
                      icon: Icon(
                        Icons.shopping_cart,
                        color: Colors.black,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: new EdgeInsets.only(top: 20),
            child: CarouselImage(),
          )
        ],
      ),
    );
    // return GridView.builder(
    //   padding: const EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 10),
    //   itemCount: 100,
    //   scrollDirection: Axis.vertical,
    //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    //     crossAxisCount: 2,
    //     childAspectRatio: 1,
    //     mainAxisSpacing: 10,
    //     crossAxisSpacing: 10,
    //   ),
    //   itemBuilder: (BuildContext context, int index) => Container(
    //     color: Colors.red,
    //     height: 100,
    //     width: 100,
    //   ),
    // );
  }
}
