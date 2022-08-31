import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          Container(
            height: size.height * .25,
            width: size.width,
            // color: Colors.red,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Varukorg 37",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  const Text(
                    "Neque porro quisquam est qui dolorem ipsum quia dolor sit amet.",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(0),
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
                      width: size.width,
                      height: 50,
                      child: const Text(
                        'Hantera ersattnongsvaror',
                        style: TextStyle(color: Colors.black, fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Container(
                    // key: ValueKey(myProducts[index]),
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                    child: Column(
                      children: [
                        Container(
                          color: Color.fromARGB(31, 134, 129, 129),
                          height: 40,
                          child: Row(
                            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "FRYST",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black54),
                              ),
                              Spacer(),
                              Text(
                                "SUMMA",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black54),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            children: [
                              Container(
                                height: 100,
                                width: size.width / 6,
                                color: Colors.redAccent,
                                child: Image.network(
                                  'https://chaldn.com/_mpimage/roast-chicken-10-gm-275-gm?src=https%3A%2F%2Feggyolk.chaldal.com%2Fapi%2FPicture%2FRaw%3FpictureId%3D74658&q=low&v=1&m=400',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                height: 100,
                                width: size.width / 3,
                                //color: Colors.black87,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        "Product Name",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black54),
                                      ),
                                      Text(
                                        "Products 350g",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.black54),
                                      ),
                                      Text(
                                        "Price in kr",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.black54),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Color.fromARGB(31, 145, 140, 140),
                                    width: 1,
                                  ),
                                ),
                                height: 74,
                                width: size.width / 4,
                                //color: Colors.redAccent,
                                child: Row(
                                  children: [
                                    const Text("13 st",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black54)),
                                    Spacer(),
                                    Column(
                                      children: [
                                        InkWell(
                                          onTap: () {},
                                          child: Container(
                                            padding: const EdgeInsets.all(5),
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: Color.fromARGB(
                                                  31, 228, 224, 224),
                                              borderRadius:
                                                  BorderRadius.circular(0),
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: Colors
                                                      .black12, //color of shadow
                                                  spreadRadius:
                                                      2, //spread radius
                                                  blurRadius: 5, // blur radius
                                                  offset: Offset(0,
                                                      2), // changes position of shadow
                                                  //first paramerter of offset is left-right
                                                  //second parameter is top to down
                                                )
                                              ],
                                            ),
                                            width: 35,
                                            height: 35,
                                            child: const Text(
                                              '+',
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 20),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        InkWell(
                                          onTap: () {},
                                          child: Container(
                                            padding: const EdgeInsets.all(5),
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: Color.fromARGB(
                                                  31, 228, 224, 224),
                                              borderRadius:
                                                  BorderRadius.circular(0),
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: Colors
                                                      .black12, //color of shadow
                                                  spreadRadius:
                                                      2, //spread radius
                                                  blurRadius: 5, // blur radius
                                                  offset: Offset(0,
                                                      2), // changes position of shadow
                                                  //first paramerter of offset is left-right
                                                  //second parameter is top to down
                                                )
                                              ],
                                            ),
                                            width: 35,
                                            height: 35,
                                            child: const Text(
                                              '-',
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 20),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                height: 100,
                                width: size.width / 4,
                                // color: Colors.blue,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.delete),
                                      color: Colors.black54,
                                    ),
                                    const Text(
                                      "20,350 kr",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black54),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
    ));
  }
}
