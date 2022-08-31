import 'package:flutter/material.dart';
import 'package:sv_craft/Features/home/widgets/filter_subcategory.dart';

class FilterCatogory extends StatelessWidget {
  FilterCatogory({Key? key}) : super(key: key);

  // Generate a massive list of dummy products
  final myProducts = List<String>.generate(10, (i) => 'Product $i');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Product Categories'),
        ),
        body: ListView.builder(
            itemCount: myProducts.length,
            itemBuilder: (context, index) {
              return Card(
                key: ValueKey(myProducts[index]),
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FilterSubCatogory(
                              category: myProducts[index].toString())),
                    );
                  },
                  child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(myProducts[index])),
                ),
              );
            }));
  }
}
