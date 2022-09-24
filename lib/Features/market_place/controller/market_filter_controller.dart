import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../model/market_filter_model.dart';

class MarketFilterController extends GetxController {
  Future<List<MarketFilterData>?> getFilterProduct(
      String token, selectedCategory, cityName, priceRange) async {
    try {
      print('tokeneeeeee: $token'
          'selectedCategoryeeeeee: $selectedCategory'
          'cityNameeeeeeeeeee: $cityName'
          'priceRangeeeee: $priceRange');
      String url =
          "http://mamun.click/api/search/$selectedCategory/$cityName/$priceRange";

      http.Response response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });

      // print(response.body);
      if (response.statusCode == 200) {
        final allProduct = marketFilterFromJson(response.body);

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
