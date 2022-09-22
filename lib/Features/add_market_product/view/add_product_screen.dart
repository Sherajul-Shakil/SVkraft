import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sv_craft/Features/add_market_product/controller/add_product_con.dart';
import 'package:sv_craft/Features/add_market_product/view/widgets/custom_textfield.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  AddProductController _addProductController = Get.put(AddProductController());
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  // final AdminServices adminServices = AdminServices();

  List<File> images = [];
  final _addProductFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    productNameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    quantityController.dispose();
  }

  void sellProduct() {
    // if (_addProductFormKey.currentState!.validate() && images.isNotEmpty) {
    //   adminServices.sellProduct(
    //     context: context,
    //     name: productNameController.text,
    //     description: descriptionController.text,
    //     price: double.parse(priceController.text),
    //     quantity: double.parse(quantityController.text),
    //     category: category,
    //     images: images,
    //   );
    // }
  }

  void selectImages() async {
    var res = await _addProductController.pickImages();
    setState(() {
      images = res;
    });
  }

  //   Future<void> uploadImage() async {
  //   setState(() {
  //     showSpinner = true;
  //   });

  //   var stream = new http.ByteStream(image!.openRead());
  //   stream.cast();

  //   var length = await image!.length();

  //   var uri = Uri.parse('https://fakestoreapi.com/products');

  //   var request = new http.MultipartRequest('POST', uri);

  //   request.fields['title'] = "Static title";

  //   var multiport = new http.MultipartFile('image', stream, length);

  //   request.files.add(multiport);

  //   var response = await request.send();

  //   print(response.stream.toString());
  //   if (response.statusCode == 200) {
  //     setState(() {
  //       showSpinner = false;
  //     });
  //     print('image uploaded');
  //   } else {
  //     print('failed');
  //     setState(() {
  //       showSpinner = false;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    print('images = ' + images.toString());
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          title: const Text(
            'Add Product',
            style: TextStyle(
                color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _addProductFormKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                images.isNotEmpty
                    ? CarouselSlider(
                        items: images.map(
                          (i) {
                            return Builder(
                              builder: (BuildContext context) => Image.file(
                                i,
                                fit: BoxFit.cover,
                                height: 200,
                              ),
                            );
                          },
                        ).toList(),
                        options: CarouselOptions(
                          viewportFraction: 1,
                          height: 200,
                        ),
                      )
                    : GestureDetector(
                        onTap: selectImages,
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(10),
                          dashPattern: const [10, 4],
                          strokeCap: StrokeCap.round,
                          child: Container(
                            width: double.infinity,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.folder_open,
                                  size: 40,
                                ),
                                const SizedBox(height: 15),
                                Text(
                                  'Select at least 4 Product Images',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey.shade400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                const SizedBox(height: 30),
                CustomTextField(
                  controller: productNameController,
                  hintText: 'Product Name',
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: descriptionController,
                  hintText: 'Description',
                  maxLines: 7,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: priceController,
                  hintText: 'Price',
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: quantityController,
                  hintText: 'Quantity',
                ),
                const SizedBox(height: 10),
                const SizedBox(height: 10),
                ElevatedButton(
                  child: const Text(
                    'Sell',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  onPressed: sellProduct,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(150, 50),
                    primary: Colors.yellow,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
