import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:sv_craft/Features/add_market_product/controller/add_product_con.dart';
import 'package:sv_craft/Features/add_market_product/view/add_product_screen.dart';
import 'package:sv_craft/Features/home/controller/home_controller.dart';
import 'package:sv_craft/Features/market_place/controller/category_controller.dart';
import 'package:sv_craft/Features/market_place/model/market_category.dart';
import 'package:sv_craft/constant/color.dart';

import '../../market_place/controller/city_controller.dart';

class AddCategoryCity extends StatefulWidget {
  const AddCategoryCity({Key? key}) : super(key: key);

  @override
  State<AddCategoryCity> createState() => _AddCategoryCityState();
}

class _AddCategoryCityState extends State<AddCategoryCity> {
  final _formKey = GlobalKey<FormState>();

  final MarketCategoryController _marketCategoryController =
      Get.put(MarketCategoryController());
  HomeController _homeController = Get.put(HomeController());
  final MarketCityController _cityController = Get.put(MarketCityController());
  AddProductController _addProductController = Get.put(AddProductController());

  final TextEditingController _cityNameController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  final List<mCategory> _categoryList = [];
  final List<String> _brandName = ["Honda", "Toyota", "Suzuki", "Nissan"];
  final List<String> _city = [];

  int? selectedCard;

  // String? selectedCategory;
  // String? selectedCity;

  var _categoryData;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      setTokenToVariable();
    });
  }

  Future<void> setTokenToVariable() async {
    //Market Category
    final responce = await _marketCategoryController
        .getmarketCategoryProduct(_homeController.tokenGlobal);
    _categoryList.clear();
    if (responce != null) {
      setState(() {
        _categoryData = responce;
      });
      for (var task in responce) {
        // _categoryList.name.add(task.categoryName);
        _categoryList.add(
          mCategory(
            categoryName: task.categoryName,
            image: task.image,
          ),
        );
        print(_categoryList);
      }
    }

    final city =
        await _cityController.getmarketCity(_homeController.tokenGlobal);

    _city.clear();
    if (city != null) {
      for (var task in city) {
        _city.add(task.name);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
      ),
      body: _categoryData != null && _city != null
          ? SingleChildScrollView(
              child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      // const Padding(
                      //   padding: EdgeInsets.symmetric(horizontal: 5),
                      //   child: Text(
                      //     'Filter with',
                      //     style: TextStyle(
                      //         color: Appcolor.primaryColor,
                      //         fontSize: 25,
                      //         fontWeight: FontWeight.normal),
                      //     textAlign: TextAlign.center,
                      //   ),
                      // ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text('CATEGORY',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.normal)),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, top: 10, bottom: 10),
                        itemCount:
                            _categoryData.length > 6 ? 6 : _categoryData.length,
                        scrollDirection: Axis.vertical,
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 150,
                          childAspectRatio: 1.20,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                        ),
                        itemBuilder: (BuildContext context, int index) =>
                            Container(
                          // color: Colors.red,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: selectedCard == index
                                ? Colors.blue[300]
                                : Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black38, //color of shadow
                                spreadRadius: 1, //spread radius
                                blurRadius: 1, // blur radius
                                offset:
                                    Offset(1, 1), // changes position of shadow
                                //first paramerter of offset is left-right
                                //second parameter is top to down
                              )
                            ],
                          ),

                          child: InkWell(
                            onTap: () {
                              setState(() {
                                selectedCard = index;
                              });
                              // _isPressed[index] = true;
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => MarketProductDetails(
                              //             id: searchedData[index].id,
                              //             token: tokenp,
                              //           )),
                              // );
                            },
                            child: Column(children: [
                              SizedBox(
                                height: size.height * .01,
                              ),
                              Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        "http://mamun.click/${_categoryData[index].image}" ??
                                            "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                _categoryData[index].categoryName,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal),
                              ),
                            ]),
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      // Container(
                      //   padding: const EdgeInsets.symmetric(horizontal: 20),
                      //   margin:
                      //       const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                      //   width: double.infinity,
                      //   decoration: BoxDecoration(
                      //       color: Appcolor.primaryColor,
                      //       borderRadius: BorderRadius.circular(10)),
                      //   child: DropdownButton<String>(
                      //     onChanged: (value2) {
                      //       setState(() {
                      //         _addProductController.selectedCategory = value2!;

                      //         //showToast();
                      //       });
                      //     },
                      //     value: _addProductController.selectedCategory,

                      //     hint: Center(
                      //         child: Text(
                      //       _addProductController.selectedCategory ??
                      //           'Select Category',
                      //       style: TextStyle(color: Colors.white),
                      //     )),

                      //     // Hide the default underline
                      //     underline: Container(),
                      //     // set the color of the dropdown menu
                      //     dropdownColor: Colors.white,
                      //     icon: const Icon(
                      //       Icons.arrow_downward,
                      //       color: Colors.white,
                      //     ),
                      //     isExpanded: true,

                      //     items: _categoryList.map((item) {
                      //       if (item.categoryName ==
                      //           _addProductController.selectedCategory) {
                      //         return DropdownMenuItem(
                      //           value: item.categoryName,
                      //           child: Container(
                      //               padding: EdgeInsets.symmetric(horizontal: 20),
                      //               decoration: BoxDecoration(
                      //                   color: Colors.blue,
                      //                   borderRadius: BorderRadius.circular(10)),
                      //               height: 48.0,
                      //               width: double.infinity,
                      //               child: Align(
                      //                 alignment: Alignment.centerLeft,
                      //                 child: ListTile(
                      //                   leading: Image.network(
                      //                     item.image!,
                      //                     height: 20,
                      //                     width: 20,
                      //                     fit: BoxFit.cover,
                      //                   ),
                      //                   title: Text(item.categoryName),
                      //                 ),
                      //               )),
                      //         );
                      //       } else {
                      //         return DropdownMenuItem(
                      //           value: item.categoryName,
                      //           child: ListTile(
                      //             leading: Image.network(
                      //               item.image!,
                      //               height: 20,
                      //               width: 20,
                      //               fit: BoxFit.cover,
                      //             ),
                      //             title: Text(item.categoryName),
                      //           ),
                      //         );
                      //       }
                      //     }).toList(),

                      //     // Customize the selected item
                      //     selectedItemBuilder: (BuildContext context) =>
                      //         _categoryList.map((e) {
                      //       return Center(
                      //         child: Text(
                      //           e.categoryName,
                      //           style: const TextStyle(
                      //               fontSize: 18,
                      //               color: Colors.white,
                      //               fontStyle: FontStyle.italic,
                      //               fontWeight: FontWeight.bold),
                      //         ),
                      //       );
                      //     }).toList(),
                      //   ),
                      // ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text('Brand Name',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.normal)),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        margin: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 20),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Appcolor.primaryColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: DropdownButton<String>(
                          onChanged: (value2) {
                            setState(() {
                              _addProductController.selectedBrand = value2!;

                              //showToast();
                            });
                          },
                          value: _addProductController.selectedBrand,

                          hint: Center(
                              child: Text(
                            _addProductController.selectedBrand ??
                                'Select Brand',
                            style: TextStyle(color: Colors.white),
                          )),

                          // Hide the default underline
                          underline: Container(),
                          // set the color of the dropdown menu
                          dropdownColor: Colors.white,
                          focusColor: Colors.red,

                          icon: const Icon(
                            FontAwesome.chevron_down,
                            color: Colors.white,
                          ),
                          isExpanded: true,

                          items: _brandName.map((item) {
                            if (item == _addProductController.selectedBrand) {
                              return DropdownMenuItem(
                                value: item,
                                child: Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    height: 48.0,
                                    width: double.infinity,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: ListTile(
                                        // leading: Icon(
                                        //   Icons.location_on,
                                        //   color: Appcolor.primaryColor,
                                        // ),
                                        title: Text(
                                          item,
                                        ),
                                      ),
                                    )),
                              );
                            } else {
                              return DropdownMenuItem(
                                value: item,
                                child: ListTile(
                                  // leading: Icon(
                                  //   Icons.location_on,
                                  //   color: Appcolor.primaryColor,
                                  // ),
                                  title: Text(
                                    item,
                                  ),
                                ),
                              );
                            }
                          }).toList(),

                          // Customize the selected item
                          selectedItemBuilder: (BuildContext context) =>
                              _brandName.map((e) {
                            return Center(
                              child: Text(
                                e,
                                style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text('Condition',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.normal)),
                      ),
                      RadioListTile(
                        title: Text("New"),
                        value: "new",
                        groupValue: _addProductController.condition,
                        onChanged: (value) {
                          setState(() {
                            _addProductController.condition = value.toString();
                          });
                        },
                      ),

                      RadioListTile(
                        title: Text("Used"),
                        value: "used",
                        groupValue: _addProductController.condition,
                        onChanged: (value) {
                          setState(() {
                            _addProductController.condition = value.toString();
                          });
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text('PLATS',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.normal)),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        margin: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 20),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Appcolor.primaryColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: DropdownButton<String>(
                          onChanged: (value2) {
                            setState(() {
                              _addProductController.selectedCity = value2!;

                              //showToast();
                            });
                          },
                          value: _addProductController.selectedCity,

                          hint: Center(
                              child: Text(
                            _addProductController.selectedCity ?? 'Select City',
                            style: TextStyle(color: Colors.white),
                          )),

                          // Hide the default underline
                          underline: Container(),
                          // set the color of the dropdown menu
                          dropdownColor: Colors.white,
                          focusColor: Colors.red,

                          icon: const Icon(
                            FontAwesome.chevron_down,
                            color: Colors.white,
                          ),
                          isExpanded: true,

                          items: _city.map((item) {
                            if (item == _addProductController.selectedCity) {
                              return DropdownMenuItem(
                                value: item,
                                child: Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    height: 48.0,
                                    width: double.infinity,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: ListTile(
                                        leading: Icon(
                                          Icons.location_on,
                                          color: Appcolor.primaryColor,
                                        ),
                                        title: Text(
                                          item,
                                        ),
                                      ),
                                    )),
                              );
                            } else {
                              return DropdownMenuItem(
                                value: item,
                                child: ListTile(
                                  leading: Icon(
                                    Icons.location_on,
                                    color: Appcolor.primaryColor,
                                  ),
                                  title: Text(
                                    item,
                                  ),
                                ),
                              );
                            }
                          }).toList(),

                          // Customize the selected item
                          selectedItemBuilder: (BuildContext context) =>
                              _city.map((e) {
                            return Center(
                              child: Text(
                                e,
                                style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      SizedBox(
                        height: 50,
                      ),

                      //Filter button
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 100),
                        child: Container(
                          alignment: Alignment.center,
                          width: size.width * 1,
                          height: size.height / 20,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Appcolor.buttonColor),
                          child: TextButton(
                            onPressed: () async {
                              //_addProductController.selectedCategory !=null &&

                              if (_formKey.currentState!.validate()) {
                                if (_addProductController.selectedCity !=
                                        null &&
                                    _addProductController.selectedBrand !=
                                        null &&
                                    _addProductController.condition != null) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            AddProductScreen()),
                                  );
                                } else {
                                  Get.snackbar(
                                    "Please select all fields",
                                    "",
                                    snackPosition: SnackPosition.BOTTOM,
                                  );
                                }
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                // SizedBox(width: size.width * 0.15),
                                Text(
                                  'Next',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18,
                                      color: Appcolor.textColor),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ))
          : Center(
              child: CircularProgressIndicator(),
            ),
    ));
  }
}
