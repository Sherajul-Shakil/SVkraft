import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sv_craft/Features/market_place/controller/market_filter_controller.dart';
import 'package:sv_craft/Features/market_place/model/market_filter_model.dart';
import 'package:sv_craft/Features/market_place/view/market_product_details.dart';

class MarketFilter extends StatefulWidget {
  MarketFilter(
      {Key? key,
      required this.token,
      required this.cityName,
      required this.selectedCategory})
      : super(key: key);

  String token;
  String cityName;
  String selectedCategory;

  @override
  State<MarketFilter> createState() => _MarketFilterState();
}

class _MarketFilterState extends State<MarketFilter> {
  final MarketFilterController _marketFilterController =
      Get.put(MarketFilterController());
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
                children: const [
                  Text('Saljes i Stockhome',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.normal)),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),

            //filtered product
            Container(
              height: size.height - 150,
              color: Colors.white,
              child: FutureBuilder<List<MarketFilterdata>?>(
                  future: _marketFilterController.getFilterProduct(
                      widget.token, widget.selectedCategory, widget.cityName),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData || snapshot.data == null) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      if (snapshot.data!.isEmpty) {
                        return const Center(child: Text('No Product Found'));
                      } else {
                        var data = snapshot.data;
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
                                            id: data[index].id,
                                            token: widget.token,
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
                                      height: 200,
                                      width: 180,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('${data[index].price} kr',
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.normal)),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        SizedBox(
                                          width: 110.0,
                                          child: Text(
                                            '${data[index].productName}',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: false,
                                            style: const TextStyle(
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
                        );
                      }
                    }
                  }),
            ),
          ],
        ),
      ),
    ));
  }
}
