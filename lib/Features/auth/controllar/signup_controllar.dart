import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

Future register(String phone, username, email, password) async {
  Map data = {
    'email': email,
    'phone': phone,
    'password': password,
    'username': username,
  };
  print(data);

  String body = json.encode(data);
  var url = 'http://mamun.click/api/register';
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
    //Or put here your next screen using Navigator.push() method
    print('success');
  } else {
    print('error');
  }
}
