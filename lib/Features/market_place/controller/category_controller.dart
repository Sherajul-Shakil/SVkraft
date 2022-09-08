import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sv_craft/Features/market_place/model/market_category.dart';

class MarketCategoryController extends GetxController {
  Future<List<mCategory>?> getmarketCategoryProduct(String textToken) async {
    try {
      const url = "http://mamun.click/api/product/category";

      http.Response response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $textToken',
      });

      if (response.statusCode == 200) {
        final marketCategory = marketCategoryFromJson(response.body);

        print('proooooooooooooooooooo ${marketCategory.data[0].categoryName}');
        // print(marketCategory.data[1].categoryName);s
        return marketCategory.data;
      } else {
        print('User not found');
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
