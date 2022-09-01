import 'package:flutter/material.dart';
import 'package:sv_craft/Features/home/widgets/filter_subcategory.dart';

class FilterCatogory extends StatelessWidget {
  FilterCatogory({Key? key}) : super(key: key);

  // Generate a massive list of dummy products
  final myProducts = List<String>.generate(10, (i) => 'Product $i');

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Product Categories'),
        ),
        body: ListView.builder(
            itemCount: myProducts.length,
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                // margin: const EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12, //color of shadow
                      spreadRadius: 1, //spread radius
                      blurRadius: 0, // blur radius
                      offset: Offset(0, 0), // changes position of shadow
                    )
                  ],
                ),
                width: size.width,
                height: 60,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FilterSubCatogory(
                              category: myProducts[index].toString())),
                    );
                  },
                  child: Row(
                    children: [
                      Text(
                        myProducts[index],
                        style: TextStyle(color: Colors.black54, fontSize: 15),
                        textAlign: TextAlign.center,
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              );
              // Card(
              //   key: ValueKey(myProducts[index]),
              //   margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              //   child: InkWell(
              //     onTap: () {
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //             builder: (context) => FilterSubCatogory(
              //                 category: myProducts[index].toString())),
              //       );
              //     },
              //     child: Padding(
              //         padding: const EdgeInsets.all(10),
              //         child: Text(myProducts[index])),
              //   ),
              // );
            }));
  }
}
