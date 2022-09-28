import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class BookmarkController extends GetxController {
  addBookmarkProduct(String textToken, productId) async {
    try {
      print('productId = $productId');
      http.Response response = await http.post(
          Uri.parse('http://mamun.click/api/marketplace/add-to-bookmark'),
          body: {
            'product_id': productId.toString(),
          },
          headers: {
            // 'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $textToken',
          });

      if (response.statusCode == 200) {
        print('Bookmark Product Added');
        return response.statusCode;
      } else {
        print('failed');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
