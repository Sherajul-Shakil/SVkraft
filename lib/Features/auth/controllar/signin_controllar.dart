import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sv_craft/Features/auth/model/auth_user.dart';

Future<int?> login(String phone, password) async {
  int? id;
  Map data = {
    'phone': phone,
    'password': password,
  };
  print(data);

  String body = json.encode(data);
  var url = 'http://mamun.click/api/login';

  http.Response response = await http.post(
    Uri.parse(url),
    body: body,
    headers: {
      "Content-Type": "application/json",
      "accept": "application/json",
      "Access-Control-Allow-Origin": "*"
    },
  );
  print(response.body);
  print(response.statusCode);
  if (response.statusCode == 200) {
    final token = authUserFromJson(response.body);
    print(token);
    id = token.data.user.id;
    return id;
  } else {
    print('failed');
  }

  // try {
  //   http.Response response = await http.post(
  //     Uri.parse(url),
  //     body: body,
  //   );
  //   print(response.statusCode);
  //   if (response.statusCode == 200) {
  //     final token = authUserFromJson(response.body);
  //     print(token);
  //     id = token.data.user.id;
  //     return id;
  //   } else {
  //     print('failed');
  //   }
  // } catch (e) {
  //   print(e.toString());
  // }

  return id;
}
