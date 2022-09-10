import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sv_craft/Features/special_day/model/special_all_product_model.dart';

class SpecialAllProductController extends GetxController {
  Future<List<SpecialAllProductData>?> getSpecialAllProduct(
      String textToken, int id) async {
    try {
      var url = "http://mamun.click/api/special-day/$id";

      http.Response response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $textToken',
      });

      print(response.body);
      if (response.statusCode == 200) {
        final allProduct = specialAllProductFromJson(response.body);

        //print('proooooooooooooooooooo ${allProduct.data.toString()}');

        return allProduct.data;
      } else {
        print('User not found');
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
