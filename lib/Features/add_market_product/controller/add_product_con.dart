import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AddProductController extends GetxController {
  String? selectedCategory;
  String? selectedCity;
  String? selectedBrand;
  String? condition;

  //pick images in add product page
  Future<List<File>> pickImages() async {
    List<File> images = [];
    try {
      var files = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: true,
      );
      if (files != null && files.files.isNotEmpty) {
        for (int i = 0; i < files.files.length; i++) {
          images.add(File(files.files[i].path!));
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return images;
  }

  multipartProdecudre(String category, city, productName, description, price,
      image, token, int quantity) async {
    try {
      //for multipartrequest
      var request = http.MultipartRequest('POST', Uri.parse('YOUR URL'));

      //for token
      request.headers.addAll({"Authorization": token});

      //for image and videos and files

      request.files.add(await http.MultipartFile.fromPath("image", "$image"));

      //for completeing the request
      var response = await request.send();

      //for getting and decoding the response into json format
      var responsed = await http.Response.fromStream(response);
      final responseData = json.decode(responsed.body);

      if (response.statusCode == 200) {
        print("SUCCESS");
        print(responseData);
      } else {
        print("ERROR");
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
