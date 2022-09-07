import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sv_craft/Features/auth/model/auth_user.dart';

class SigninController extends GetxController {
  final _formKey = GlobalKey<FormState>();

  final _formKeyP = GlobalKey<FormState>();

  String initialCountry = 'BD';

  PhoneNumber number = PhoneNumber(isoCode: 'BD');

  var phone;

  final TextEditingController phoneNumberController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  Future<String?> login(String phone, password) async {
    var tokenid;
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

      tokenid = token.data.token;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth-token', tokenid);

      print('token idddddddddddddddddddddddddddddddddd $tokenid');
      return tokenid;
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

    return tokenid;
  }
}
