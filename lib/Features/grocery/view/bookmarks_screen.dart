import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sv_craft/Features/grocery/controllar/bookmark_category_con.dart';
import 'package:sv_craft/Features/grocery/controllar/category_controller.dart';
import 'package:sv_craft/Features/grocery/model/bookmark_category_model.dart';
import 'package:sv_craft/Features/grocery/model/category_model.dart';
import 'package:sv_craft/Features/grocery/view/bookmark_product_get.dart';
import 'package:sv_craft/Features/home/controller/home_controller.dart';

class GroceryBookmarks extends StatefulWidget {
  GroceryBookmarks({Key? key}) : super(key: key);

  @override
  State<GroceryBookmarks> createState() => _GroceryBookmarksState();
}

class _GroceryBookmarksState extends State<GroceryBookmarks> {
  // final String token;
  BookmarkCategoryController _bookmarkCategoryController =
      Get.put(BookmarkCategoryController());
  HomeController _homeController = Get.put(HomeController());

  TextEditingController _searchController = TextEditingController();

  // Generate a massive list of dummy products
  final myProducts = List<String>.generate(10, (i) => 'Product $i');

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.dialog(
              AlertDialog(
                title: const Text('Add Bookmarks Category'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: _searchController,
                      decoration: const InputDecoration(
                        hintText: 'Category Name',
                      ),
                    ),
                    // TextFormField(
                    //   decoration: const InputDecoration(
                    //     hintText: 'Category Image',
                    //   ),
                    // ),
                  ],
                ),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () async {
                          var statusCode = await _bookmarkCategoryController
                              .addBookmarkCategory(_homeController.tokenGlobal,
                                  _searchController.text);

                          if (statusCode == 200) {
                            Get.back();
                            Get.snackbar('Success', 'Category Added');
                          } else {
                            Get.back();
                            Get.snackbar('Error', 'Category Not Added');
                          }
                        },
                        child: const Text('Add'),
                      ),
                    ],
                  ),
                ],
              ),
              barrierDismissible: false,
            );
          },
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        appBar: AppBar(
          title: const Text('Grocery Bookmarks'),
        ),
        body: FutureBuilder<List<BookmarkCategoryData>?>(
            future: _bookmarkCategoryController
                .getBookmarkCategory(_homeController.tokenGlobal),
            builder: (context, snapshot) {
              if (!snapshot.hasData || snapshot.data == null) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (snapshot.data!.isEmpty) {
                  return const Center(child: Text('No Product Found'));
                } else {
                  final data = snapshot.data;
                  return ListView.builder(
                      itemCount: data!.length,
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
                                offset:
                                    Offset(0, 0), // changes position of shadow
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
                                    builder: (context) =>
                                        BookmarkProductGetScreen(
                                            id: data[index].id,
                                            name: data[index].name)),
                              );
                            },
                            child: Row(
                              children: [
                                Icon(Icons.list),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  data[index].name,
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 15),
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
                      });
                }
              }
            }));
  }
}







// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:get/get.dart';
// import 'package:sv_craft/constant/constant.dart';

// class GroceryBookmarks extends StatefulWidget {
//   const GroceryBookmarks({Key? key}) : super(key: key);

//   @override
//   State<GroceryBookmarks> createState() => _GroceryBookmarksState();
// }

// class _GroceryBookmarksState extends State<GroceryBookmarks> {
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return SafeArea(
//         child: Scaffold(
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Get.dialog(
//             AlertDialog(
//               title: const Text('Add Category'),
//               content: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   TextFormField(
//                     decoration: const InputDecoration(
//                       hintText: 'Category Name',
//                     ),
//                   ),
//                   // TextFormField(
//                   //   decoration: const InputDecoration(
//                   //     hintText: 'Category Image',
//                   //   ),
//                   // ),
//                 ],
//               ),
//               actions: [
//                 TextButton(
//                   onPressed: () {
//                     Get.back();
//                   },
//                   child: const Text('OK'),
//                 ),
//               ],
//             ),
//           );
//         },
//         child: const Icon(Icons.add),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             const SizedBox(
//               height: 20,
//             ),
//             Card(
//               child: Column(
//                 children: [
//                   ListTile(
//                     // tileColor: Colors.grey[200],
//                     title: Text(
//                       'Daily Grocery',
//                       style: TextStyle(
//                         fontSize: 20,
//                         color: Colors.black,
//                       ),
//                     ),
//                     onTap: () {},
//                   ),
//                   GridView.builder(
//                     physics: NeverScrollableScrollPhysics(),
//                     shrinkWrap: true,
//                     padding: const EdgeInsets.only(
//                         left: 15, right: 15, top: 20, bottom: 10),
//                     itemCount: 4,
//                     scrollDirection: Axis.vertical,
//                     gridDelegate:
//                         const SliverGridDelegateWithMaxCrossAxisExtent(
//                       maxCrossAxisExtent: 200,
//                       childAspectRatio: .55,
//                       mainAxisSpacing: 10,
//                       crossAxisSpacing: 10,
//                     ),
//                     itemBuilder: (BuildContext context, int index) => Container(
//                       //color: Colors.green,
//                       alignment: Alignment.center,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(10),
//                         boxShadow: const [
//                           BoxShadow(
//                             color: Colors.black12, //color of shadow
//                             spreadRadius: 2, //spread radius
//                             blurRadius: 5, // blur radius
//                             offset: Offset(0, 2), // changes position of shadow
//                             //first paramerter of offset is left-right
//                             //second parameter is top to down
//                           )
//                         ],
//                       ),

//                       child: Column(
//                         children: [
//                           // SizedBox(height: size.height * .01),
//                           Row(
//                             children: [
//                               SizedBox(width: size.width * .01),
//                               // IconButton(
//                               //     onPressed: () {
//                               //       print("object");
//                               //       Navigator.pushReplacement(
//                               //         context,
//                               //         MaterialPageRoute(
//                               //             builder: (context) =>
//                               //                 GroceryBookmarks()),
//                               //       );
//                               //       //var message = _addtoBookmarksController.addToBookmarks(userid : userId, pro , token: tokenp,);
//                               //     },
//                               //     icon: const Icon(
//                               //       FontAwesome.bookmark,
//                               //       color: Colors.black,
//                               //       size: 18,
//                               //     )),
//                               const Spacer(),
//                               Text(
//                                 300.toString(),
//                                 textAlign: TextAlign.center,
//                               ),
//                               const SizedBox(
//                                 width: 5,
//                               ),
//                               SizedBox(width: size.width * .01),
//                             ],
//                           ),
//                           Stack(
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 10, vertical: 10),
//                                 child: Image.network(
//                                   '${AppImage.carouselImages[index]}',
//                                   // AppImage.carouselImages[index],
//                                   fit: BoxFit.cover,
//                                   width: 120,
//                                   height: 150,
//                                 ),
//                               ),
//                               Positioned(
//                                   top: 20,
//                                   right: 0,
//                                   child: Container(
//                                     height: 50,
//                                     width: 50,
//                                     color: Colors.yellow,
//                                     child: Text(
//                                       "5% off",
//                                       textAlign: TextAlign.center,
//                                       style: const TextStyle(
//                                           fontSize: 20,
//                                           fontWeight: FontWeight.w500,
//                                           color: Colors.red),
//                                     ),
//                                   ))
//                             ],
//                           ),
//                           SizedBox(
//                             height: size.height * .02,
//                           ),
//                           Row(
//                             children: [
//                               const SizedBox(
//                                 width: 10,
//                               ),
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Text(
//                                     'Product Name',
//                                     style: const TextStyle(
//                                       fontSize: 12,
//                                       fontWeight: FontWeight.w500,
//                                       color: Colors.black,
//                                     ),
//                                     textAlign: TextAlign.start,
//                                   ),
//                                   Text(
//                                     "100 kr",
//                                     style: const TextStyle(
//                                       fontSize: 12,
//                                       fontWeight: FontWeight.w500,
//                                       color: Colors.black,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                           SizedBox(
//                             height: size.height * .02,
//                           ),
//                           Row(
//                             children: [
//                               const SizedBox(
//                                 width: 10,
//                               ),
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Container(
//                                     height: 50,
//                                     width: size.width * .4,
//                                     child: Text(
//                                       "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. ",
//                                       style: const TextStyle(
//                                         fontSize: 12,
//                                         fontWeight: FontWeight.w500,
//                                         color: Colors.black,
//                                       ),
//                                       overflow: TextOverflow.ellipsis,
//                                       maxLines: 3,
//                                     ),
//                                   ),
//                                   // Text(
//                                   //   "also the leap into electronic",
//                                   //   style: TextStyle(
//                                   //     fontSize: 12,
//                                   //     fontWeight: FontWeight.w500,
//                                   //     color: Colors.black,
//                                   //   ),
//                                   // ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                           // SizedBox(
//                           //   height: size.height * .01,
//                           // ),
//                         ],
//                       ),
//                       // height: 147,
//                       // width: ,
//                     ),
//                   )
//                 ],
//               ),
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             Card(
//               child: Column(
//                 children: [
//                   ListTile(
//                     // tileColor: Colors.grey[200],
//                     title: Text(
//                       'Monthly Grocery',
//                       style: TextStyle(
//                         fontSize: 20,
//                         color: Colors.black,
//                       ),
//                     ),
//                     onTap: () {},
//                   ),
//                   GridView.builder(
//                     physics: NeverScrollableScrollPhysics(),
//                     shrinkWrap: true,
//                     padding: const EdgeInsets.only(
//                         left: 15, right: 15, top: 20, bottom: 10),
//                     itemCount: 4,
//                     scrollDirection: Axis.vertical,
//                     gridDelegate:
//                         const SliverGridDelegateWithMaxCrossAxisExtent(
//                       maxCrossAxisExtent: 200,
//                       childAspectRatio: .55,
//                       mainAxisSpacing: 10,
//                       crossAxisSpacing: 10,
//                     ),
//                     itemBuilder: (BuildContext context, int index) => Container(
//                       //color: Colors.green,
//                       alignment: Alignment.center,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(10),
//                         boxShadow: const [
//                           BoxShadow(
//                             color: Colors.black12, //color of shadow
//                             spreadRadius: 2, //spread radius
//                             blurRadius: 5, // blur radius
//                             offset: Offset(0, 2), // changes position of shadow
//                             //first paramerter of offset is left-right
//                             //second parameter is top to down
//                           )
//                         ],
//                       ),

//                       child: Column(
//                         children: [
//                           // SizedBox(height: size.height * .01),
//                           Row(
//                             children: [
//                               SizedBox(width: size.width * .01),
//                               // IconButton(
//                               //     onPressed: () {
//                               //       print("object");
//                               //       Navigator.pushReplacement(
//                               //         context,
//                               //         MaterialPageRoute(
//                               //             builder: (context) =>
//                               //                 GroceryBookmarks()),
//                               //       );
//                               //       //var message = _addtoBookmarksController.addToBookmarks(userid : userId, pro , token: tokenp,);
//                               //     },
//                               //     icon: const Icon(
//                               //       FontAwesome.bookmark,
//                               //       color: Colors.black,
//                               //       size: 18,
//                               //     )),
//                               const Spacer(),
//                               Text(
//                                 300.toString(),
//                                 textAlign: TextAlign.center,
//                               ),
//                               const SizedBox(
//                                 width: 5,
//                               ),
//                               SizedBox(width: size.width * .01),
//                             ],
//                           ),
//                           Stack(
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 10, vertical: 10),
//                                 child: Image.network(
//                                   '${AppImage.marketPlaceImage[index]}',
//                                   // AppImage.carouselImages[index],
//                                   fit: BoxFit.cover,
//                                   width: 120,
//                                   height: 150,
//                                 ),
//                               ),
//                               Positioned(
//                                   top: 20,
//                                   right: 0,
//                                   child: Container(
//                                     height: 50,
//                                     width: 50,
//                                     color: Colors.yellow,
//                                     child: Text(
//                                       "5% off",
//                                       textAlign: TextAlign.center,
//                                       style: const TextStyle(
//                                           fontSize: 20,
//                                           fontWeight: FontWeight.w500,
//                                           color: Colors.red),
//                                     ),
//                                   ))
//                             ],
//                           ),
//                           SizedBox(
//                             height: size.height * .02,
//                           ),
//                           Row(
//                             children: [
//                               const SizedBox(
//                                 width: 10,
//                               ),
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Text(
//                                     'Product Name',
//                                     style: const TextStyle(
//                                       fontSize: 12,
//                                       fontWeight: FontWeight.w500,
//                                       color: Colors.black,
//                                     ),
//                                     textAlign: TextAlign.start,
//                                   ),
//                                   Text(
//                                     "100 kr",
//                                     style: const TextStyle(
//                                       fontSize: 12,
//                                       fontWeight: FontWeight.w500,
//                                       color: Colors.black,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                           SizedBox(
//                             height: size.height * .02,
//                           ),
//                           Row(
//                             children: [
//                               const SizedBox(
//                                 width: 10,
//                               ),
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Container(
//                                     height: 50,
//                                     width: size.width * .4,
//                                     child: Text(
//                                       "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. ",
//                                       style: const TextStyle(
//                                         fontSize: 12,
//                                         fontWeight: FontWeight.w500,
//                                         color: Colors.black,
//                                       ),
//                                       overflow: TextOverflow.ellipsis,
//                                       maxLines: 3,
//                                     ),
//                                   ),
//                                   // Text(
//                                   //   "also the leap into electronic",
//                                   //   style: TextStyle(
//                                   //     fontSize: 12,
//                                   //     fontWeight: FontWeight.w500,
//                                   //     color: Colors.black,
//                                   //   ),
//                                   // ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                           // SizedBox(
//                           //   height: size.height * .01,
//                           // ),
//                         ],
//                       ),
//                       // height: 147,
//                       // width: ,
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     ));
//   }
// }
