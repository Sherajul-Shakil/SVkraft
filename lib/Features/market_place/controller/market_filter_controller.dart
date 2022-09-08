import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/market_filter_model.dart';

class MarketFilterController extends GetxController {
  // getToken() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? token = prefs.getString('auth-token');

  //   return token;
  // }

  Future<List<MarketFilterdata>?> getFilterProduct(
      String token, selectedCategory, cityName) async {
    try {
      print('token $token');
      print('selectedCategory $selectedCategory');
      print('cityName $cityName');
      String url =
          "http://mamun.click/api/search/category/$selectedCategory/location/$cityName";

      http.Response response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });

      // print(response.body);
      if (response.statusCode == 200) {
        final allProduct = marketFilterFromJson(response.body);

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
