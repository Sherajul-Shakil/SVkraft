import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sv_craft/Features/grocery/model/sub_category_model.dart';

import '../models/logout_model.dart';

class LogoutController extends GetxController {
  Future<String?> logout(String textToken) async {
    try {
      var url = "http://mamun.click/api/logout";

      http.Response response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $textToken',
      });
      print(response.statusCode);
      if (response.statusCode == 200) {
        final marketCategory = logoutFromJson(response.body);

        return marketCategory.message;
      } else {
        print('Logout Error');
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
