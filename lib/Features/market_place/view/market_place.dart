import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sv_craft/Features/auth/controllar/signin_controllar.dart';
import 'package:sv_craft/Features/market_place/controller/all_product_controller.dart';
import 'package:sv_craft/Features/market_place/model/all_product_model.dart';
import 'package:sv_craft/Features/market_place/view/market_product_details.dart';
import 'package:sv_craft/constant/color.dart';

import '../../../constant/constant.dart';

class MarketPlace extends StatefulWidget {
  const MarketPlace({Key? key}) : super(key: key);

  @override
  State<MarketPlace> createState() => _MarketPlaceState();
}

class _MarketPlaceState extends State<MarketPlace> {
  final SigninController _signinController = Get.put(SigninController());
  final AllProductController _allProductController =
      Get.put(AllProductController());
  var tokenp;
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      setTokenToVariable();
    }); //.then((value) => _allProductController.GetAllProduct(tokenp))
  }

  Future<void> setTokenToVariable() async {
    final token = await _allProductController.getToken();
    // print('token = ' + token);
    setState(() {
      tokenp = token;
    });
  }

  bool _searchBoolean = false;
  List<int> _searchIndexList = [];

  // ignore: prefer_final_fields
  final List<String> _list = [
    'English Textbook',
    'Japanese Textbook',
    'English Vocabulary',
    'Japanese Vocabulary'
  ];

  Widget _searchTextField() {
    return TextField(
      onChanged: (String s) {
        setState(() {
          _searchIndexList = [];
          for (int i = 0; i < _list.length; i++) {
            if (_list[i].contains(s)) {
              _searchIndexList.add(i);
            }
          }
        });
      },
      autofocus: true,
      cursorColor: Colors.black,
      style: TextStyle(
        color: Colors.black,
        fontSize: 20,
      ),
      textInputAction: TextInputAction.search,
      decoration: const InputDecoration(
        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
        enabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        focusedBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        hintText: 'Search',
        hintStyle: TextStyle(
          color: Appcolor.uperTextColor,
          fontSize: 20,
        ),
      ),
    );
  }

  Widget _searchListView() {
    return ListView.builder(
        itemCount: _searchIndexList.length,
        itemBuilder: (context, index) {
          index = _searchIndexList[index];
          return Card(child: ListTile(title: Text(_list[index])));
        });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    print(tokenp);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        leadingWidth: 300,
        automaticallyImplyLeading: false,
        backgroundColor: Appcolor.primaryColor,
        elevation: 1,
        // leading: const Text('Market Place',
        //     style: TextStyle(
        //         color: Colors.black,
        //         fontSize: 20,
        //         fontWeight: FontWeight.bold)),
        title: !_searchBoolean
            ? const Text('Market Place',
                style: TextStyle(
                    color: Appcolor.uperTextColor,
                    fontSize: 30,
                    fontWeight: FontWeight.bold))
            : _searchTextField(),
        actions: !_searchBoolean
            ? [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Appcolor.iconShadowColor, //<-- SEE HERE
                  child: IconButton(
                    icon: const Icon(
                      Icons.search,
                      color: Appcolor.iconColor,
                    ),
                    onPressed: () {
                      setState(() {
                        _searchBoolean = true;
                        _searchIndexList = [];
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: size.width * .02,
                ),
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Appcolor.iconShadowColor, //<-- SEE HERE
                  child: IconButton(
                    icon: const Icon(
                      Icons.filter_list,
                      color: Appcolor.iconColor,
                    ),
                    onPressed: () {
                      Get.toNamed('/marketfilter');
                    },
                  ),
                ),
                SizedBox(
                  width: size.width * .02,
                ),
              ]
            : [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Appcolor.iconShadowColor, //<-- SEE HERE
                  child: IconButton(
                    icon: const Icon(
                      Icons.clear,
                      color: Appcolor.iconColor,
                    ),
                    onPressed: () {
                      setState(() {
                        _searchBoolean = false;
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: size.width * .02,
                ),
              ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 50,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: const [
                    Text('Today\'s Picks',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.normal)),
                    Spacer(),
                    Icon(Icons.location_on_sharp, color: Appcolor.primaryColor),
                    Text('Dhaka',
                        style: TextStyle(
                            color: Appcolor.primaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.normal)),
                  ],
                ),
              ),
            ),
            Container(
              height: size.height - 120,
              color: Colors.white,
              child: tokenp != null
                  ? FutureBuilder<List<Datum>?>(
                      future: _allProductController.GetAllProduct(tokenp),
                      builder: (context, snapshot) {
                        print('inside buil;der\n' + snapshot.data.toString());

                        if (!snapshot.hasData || snapshot.data == null) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else {
                          if (snapshot.data!.isEmpty) {
                            return const Center(
                                child: Text('No Product Found'));
                          } else {
                            final data = snapshot.data;
                            return GridView.builder(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, top: 20, bottom: 10),
                              itemCount: data!.length,
                              scrollDirection: Axis.vertical,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: .79,
                                mainAxisSpacing: 1,
                                crossAxisSpacing: 1,
                              ),
                              itemBuilder: (BuildContext context, int index) =>
                                  Container(
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
                                      offset: Offset(
                                          0, 0), // changes position of shadow
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
                                          builder: (context) =>
                                              MarketProductDetails(
                                                imageLink: AppImage
                                                    .marketPlaceImage[index],
                                              )),
                                    );
                                  },
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 5),
                                        child: Image.network(
                                          'http://mamun.click/${data[index].image[0].filePath}',
                                          fit: BoxFit.contain,
                                          height: 180,
                                          width: 170,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 6),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('${data[index].price} Kr',
                                                maxLines: 3,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.normal)),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            SizedBox(
                                              width: 110.0,
                                              child: Text(
                                                data[index].productName,
                                                overflow: TextOverflow.ellipsis,
                                                softWrap: false,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.normal,
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
                            );
                          }
                        }
                      })
                  : const Center(child: CircularProgressIndicator()),
            ),
          ],
        ),
      ),
    ));
  }
}
