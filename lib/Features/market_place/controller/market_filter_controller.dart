import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../model/market_filter_model.dart';

class MarketFilterController extends GetxController {
  Future<List<MarketFilterdata>?> getFilterProduct(
      String token, selectedCategory, cityName) async {
    try {
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
