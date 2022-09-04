import 'package:flutter/material.dart';

import '../../../constant/constant.dart';
import 'market_product_details.dart';

class MarketFilter extends StatefulWidget {
  const MarketFilter({Key? key}) : super(key: key);

  @override
  State<MarketFilter> createState() => _MarketFilterState();
}

class _MarketFilterState extends State<MarketFilter> {
  final List<String> _locaion = ["Flen", "Gothenburg", "Gränna", "Gävle"];
  String? _selectedLocation;

  final List<String> _categoty = ["Mobile", "iPhone", "Laptop", "Watch"];
  String? _selectedCategory;

  //Container visibility
  bool _isVisible = true;
  void showToast() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color.fromARGB(200, 32, 31, 36), //#201F24
      appBar: AppBar(
        title: const Text('vad vill du soka etter?'),
        backgroundColor: const Color.fromARGB(255, 48, 48, 48),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 2,
            ),
            Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 48, 48, 48),
                borderRadius: BorderRadius.circular(0),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Saljes i Stockhome',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.normal)),
                  _isVisible
                      ? IconButton(onPressed: null, icon: const Icon(null))
                      : IconButton(
                          onPressed: () {
                            showToast();
                          },
                          icon: const Icon(Icons.close, color: Colors.white)),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Visibility(
              visible: _isVisible,
              child: Container(
                height: size.height * .25,
                width: size.width,
                // color: Colors.red,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text('PLATS',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
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
                          color: Colors.indigo,
                          borderRadius: BorderRadius.circular(10)),
                      child: DropdownButton<String>(
                        value: _selectedLocation,
                        onChanged: (value) {
                          setState(() {
                            _selectedLocation = value;
                          });
                        },
                        hint: const Center(
                            child: Text(
                          'Select location',
                          style: TextStyle(color: Colors.white),
                        )),
                        // Hide the default underline
                        underline: Container(),
                        // set the color of the dropdown menu
                        dropdownColor: Colors.white,
                        icon: const Icon(
                          Icons.arrow_downward,
                          color: Colors.white,
                        ),
                        isExpanded: true,

                        // The list of options
                        items: _locaion
                            .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      e,
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                  ),
                                ))
                            .toList(),

                        // Customize the selected item
                        selectedItemBuilder: (BuildContext context) => _locaion
                            .map((e) => Center(
                                  child: Text(
                                    e,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text('CATEGORY',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
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
                          color: Colors.indigo,
                          borderRadius: BorderRadius.circular(10)),
                      child: DropdownButton<String>(
                        value: _selectedCategory,
                        onChanged: (value) {
                          setState(() {
                            _selectedCategory = value;
                            showToast();
                          });
                        },
                        hint: const Center(
                            child: Text(
                          'Select Category',
                          style: TextStyle(color: Colors.white),
                        )),
                        // Hide the default underline
                        underline: Container(),
                        // set the color of the dropdown menu
                        dropdownColor: Colors.white,
                        icon: const Icon(
                          Icons.arrow_downward,
                          color: Colors.white,
                        ),
                        isExpanded: true,

                        // The list of options
                        items: _categoty
                            .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      e,
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                  ),
                                ))
                            .toList(),

                        // Customize the selected item
                        selectedItemBuilder: (BuildContext context) => _categoty
                            .map((e) => Center(
                                  child: Text(
                                    e,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            //filtered product
            Container(
              height: size.height - 150,
              color: Colors.white,
              child: GridView.builder(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 20, bottom: 10),
                itemCount: AppImage.marketPlaceImage.length,
                scrollDirection: Axis.vertical,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: .79,
                  mainAxisSpacing: 1,
                  crossAxisSpacing: 1,
                ),
                itemBuilder: (BuildContext context, int index) => Container(
                  // color: Colors.red,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12, //color of shadow
                        spreadRadius: 0, //spread radius
                        blurRadius: 0, // blur radius
                        offset: Offset(0, 0), // changes position of shadow
                        //first paramerter of offset is left-right
                        //second parameter is top to down
                      )
                    ],
                  ),

                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MarketProductDetails(
                                  imageLink: AppImage.marketPlaceImage[index],
                                )),
                      );
                    },
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 5),
                          child: Image.network(
                            AppImage.marketPlaceImage[index],
                            fit: BoxFit.cover,
                            height: 200,
                            width: 180,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text('500 kr',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal)),
                              SizedBox(
                                width: 5,
                              ),
                              SizedBox(
                                width: 130.0,
                                child: Text(
                                  "Super Drone LR574",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: false,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 16.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
