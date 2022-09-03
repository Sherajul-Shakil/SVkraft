import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'post_model.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  // List<Photos> photosList = [];

  // Future<List<Photos>> getPhotos() async {
  //   final response = await http
  //       .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
  //   var data = jsonDecode(response.body.toString());

  //   print("Photo data $data");
  //   if (response.statusCode == 200) {
  //     setState(() {
  //       for (Map i in data) {
  //         Photos photos = Photos(title: i['title'], url: i['url'], id: i['id']);
  //         photosList.add(photos);
  //       }
  //     });
  //     return photosList;
  //   } else {
  //     return photosList;
  //   }
  // }

  List<PostsModel> postList = [];

  Future<List<PostsModel>> getPostApi() async {
    final resposne =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data = jsonDecode(resposne.body.toString());

    if (resposne.statusCode == 200) {
      setState(() {
        postList.clear();

        for (var i in data) {
          postList.add(PostsModel.fromJson(i));
        }
      });

      return postList;
    } else {
      return postList;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Future.delayed(Duration(seconds: 5), () {
    //   getPhotos();
    // });
    bool val = true;
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          FutureBuilder<List<PostsModel>>(
            future: getPostApi(),
            builder: (context, snapshot) {
              print("Snapshot data ${snapshot.data}");
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Expanded(
                  child: ListView.builder(
                      itemCount: postList.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  postList[index].title.toString(),
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  postList[index].body.toString(),
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                );
              }
            },
          ),
        ],
      )),
    );
  }
}

class Photos {
  String title, url;
  int id;
  Photos({required this.title, required this.url, required this.id});
}
