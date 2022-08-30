import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MarketProduct extends StatefulWidget {
  @override
  _MarketProductState createState() {
    return _MarketProductState();
  }
}

class _MarketProductState extends State<MarketProduct> {
  bool haveaccess = false;
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
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        //drawer: Drawer(backgroundColor: Colors.blue.withOpacity(0)),
        appBar: AppBar(
          leadingWidth: 100,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white10,
          elevation: 0,
          leading: Row(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              SizedBox(
                width: size.width * .02,
              ),
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.black, //<-- SEE HERE
                child: IconButton(
                  icon: const Icon(
                    Icons.menu,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                ),
              ),
              SizedBox(
                width: size.width * .02,
              ),
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.black, //<-- SEE HERE
                child: IconButton(
                  icon: const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
          actions: [
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.black, //<-- SEE HERE
              child: IconButton(
                icon: const Icon(
                  Icons.filter_list,
                  color: Colors.white,
                ),
                onPressed: () {},
              ),
            ),
            SizedBox(
              width: size.width * .02,
            ),
          ],
        ),
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
                    color: Colors.red,
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
                            style: const TextStyle(
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
          body: Container(
            height: 500,
            //color: Colors.blue,
            child: GridView.builder(
              padding: const EdgeInsets.only(
                  left: 15, right: 15, top: 20, bottom: 10),
              itemCount: 100,
              scrollDirection: Axis.vertical,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
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
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.list_alt),
                          color: Colors.black,
                        ),
                        const Spacer(),
                        Container(
                          height: 20,
                          width: 100,
                          color: Colors.black12,
                          child: const Text(
                            "100 BDT/kg",
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Image.network(
                        'https://images.unsplash.com/photo-1618354691373-d851c5c3a990?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Nnx8c2hpcnR8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60',
                        fit: BoxFit.cover,
                        width: 120,
                        height: 150,
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              "Product Name",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.start,
                            ),
                            Text(
                              "500 USD",
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
                    Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "when an unknown printer took",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              "also the leap into electronic",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              "also the leap into electronic",
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
                      height: size.height * .01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(0),
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
                            width: 40,
                            height: 40,
                            child: const Text(
                              '-',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 25),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(0),
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
                            width: 60,
                            height: 40,
                            child: const Text(
                              '10',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(0),
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
                            width: 40,
                            height: 40,
                            child: const Text(
                              '+',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 25),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                // height: 147,
                // width: ,
              ),
            ),
          ),
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
