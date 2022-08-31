import 'package:flutter/material.dart';

class FilterSubCatogory extends StatelessWidget {
  FilterSubCatogory({Key? key, required this.category}) : super(key: key);
  final String category;
  // Generate a massive list of dummy products
  final myProducts = List<String>.generate(10, (i) => 'category $i');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Product Categories'),
        ),
        body: ListView.builder(
            itemCount: myProducts.length,
            itemBuilder: (context, index) {
              return Text('$category ${myProducts[index]}');
            }));
  }
}
