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
  List<File> images = [];

  //pick images in add product page
  Future<List<File>> pickImages() async {
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

  void uploadProduct({name, description, price, quantity}) async {
    if (images.isNotEmpty) {
      var request = http.MultipartRequest(
          'POST', Uri.parse('http://mamun.click/api/product/create'));
      request.headers.addAll({
        'Authorization': 'Bearer 31|CSTDHfyWAJyATK3QJNafQEDHDElHZgTpOrjwtKQg'
      });
      request.fields['category_id'] = '27';
      request.fields['location'] = "$selectedCity";
      request.fields['product_name'] = '$name';
      request.fields['price'] = '$price';
      request.fields['description'] = '$description';
      request.fields['quantity'] = '$quantity';
      for (int i = 0; i < images.length; i++) {
        request.files.add(
          await http.MultipartFile.fromPath('image[]', images[i].path),
        );
      }

      var response = await request.send();
      print(response.statusCode);
      response.stream.transform(utf8.decoder).listen((value) {
        print(value);
      });
    }
  }
}
