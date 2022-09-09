import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sv_craft/Features/market_place/model/all_product_model.dart';
import 'package:sv_craft/Features/market_place/model/product_details.dart';

class ProductDetailsController extends GetxController {
  Future<ProductDetailsData?> getProductDetails(
      String textToken, int id) async {
    try {
      print('tokennnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn $id   $textToken');
      const url = "http://mamun.click/api/product/find/";

      http.Response response = await http.get(Uri.parse('$url$id'), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $textToken',
      });
      // print(response.body);
      print(response.statusCode);

      if (response.statusCode == 200) {
        print("object");
        final productDetails = productDetailsFromJson(response.body);
        print("******");
        print(productDetails.data);
        return productDetails.data;
      } else {
        print('Product Not Found');
        return null;
      }
    } catch (e) {
      print('Try exception ${e.toString()}');
      return null;
    }
  }
}
