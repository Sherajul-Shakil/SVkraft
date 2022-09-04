import 'package:flutter/material.dart';

class MarketProductDetails extends StatefulWidget {
  const MarketProductDetails({
    Key? key,
    required this.imageLink,
  }) : super(key: key);
  final String imageLink;

  @override
  State<MarketProductDetails> createState() => _MarketProductDetailsState();
}

class _MarketProductDetailsState extends State<MarketProductDetails> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color.fromARGB(255, 32, 32, 32),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              widget.imageLink,
              fit: BoxFit.cover,
              height: size.height * 0.5,
              width: size.width,
            ),
            Container(
              padding: const EdgeInsets.all(20),
              height: size.height * 0.5,
              width: size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text('DJI camera, Canon 200',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.normal)),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                      'DJI camera drones contain the best drone technology for every type of user and shooting scenario. If you are looking for a beginner drone, professional drone, or simply want to upgrade to the latest technology.',
                      style: TextStyle(
                          color: Colors.white60,
                          fontSize: 18,
                          fontWeight: FontWeight.normal)),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text('3,900 kr',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.normal)),
                  const SizedBox(
                    height: 70,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12, //color of shadow
                                spreadRadius: 2, //spread radius
                                blurRadius: 5, // blur radius
                                offset:
                                    Offset(0, 2), // changes position of shadow
                                //first paramerter of offset is left-right
                                //second parameter is top to down
                              )
                            ],
                          ),
                          width: 200,
                          height: 55,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                'Add to cart',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 25),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.shopping_cart,
                                color: Colors.black,
                                size: 25,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
