import 'package:flutter/material.dart';

import '../../../../constant/color.dart';

class FilterSubCatogory extends StatelessWidget {
  FilterSubCatogory({Key? key, required this.category}) : super(key: key);
  final String category;
  // Generate a massive list of dummy products
  final myProducts = List<String>.generate(10, (i) => 'category $i');

  @override
  Widget build(BuildContext context) {
    var list = [
      "Moviing",
      "Assembly",
      "Mounting",
      "rice",
      "Assistant",
      "Delivery",
      "pasta",
      "Practice",
      "Painting",
      "Cleaning",
      "Liffing"
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Subategories'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Wrap(
          children: list
              .map((f) => InkWell(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      margin: const EdgeInsets.only(
                          left: 5.0, right: 5.0, top: 10.0, bottom: 10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12, //color of shadow
                            spreadRadius: 1, //spread radius
                            blurRadius: 0, // blur radius
                            offset: Offset(0, 0), // changes position of shadow
                          )
                        ],
                      ),
                      child: Text(
                        '$f',
                        style: const TextStyle(
                          color: Appcolor.textColor,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    onTap: () {},
                  ))
              .toList(),
        ),
      ),

      // ListView.builder(
      //     itemCount: myProducts.length,
      //     itemBuilder: (context, index) {
      //       return Text('$category ${myProducts[index]}');
      //     }),
    );
  }
}
