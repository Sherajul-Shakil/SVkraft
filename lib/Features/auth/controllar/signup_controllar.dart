import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sv_craft/Features/common/typedefs.dart';

Future<String?> register(String phone, username, email, password) async {
  Map data = {
    'email': email,
    'phone': phone,
    'password': password,
    'username': username,
  };

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

  if (((jsonDecode(response.body) as JSON)['success'] as bool) == true) {
    final token = (jsonDecode(response.body) as JSON)['data']['token'];
    final userId = (jsonDecode(response.body) as JSON)['data']['user']['id'];

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth-token', token);
    await prefs.setInt('user-id', userId);

    return token;
  } else {
    print('Error from controller');
    return null;
  }
}
// class SignupController extends GetxController {
//   String initialCountry = 'BD';
//   PhoneNumber number = PhoneNumber(isoCode: 'BD');
//   var phone;
//   final TextEditingController phoneNumberController = TextEditingController();
//   final TextEditingController userNameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();

//   Future register(String phone, username, email, password) async {
//     int? id;
//     Map data = {
//       'email': email,
//       'phone': phone,
//       'password': password,
//       'username': username,
//     };
//     print(data);

//     String body = json.encode(data);
//     var url = 'http://mamun.click/api/register';
//     http.Response response = await http.post(
//       Uri.parse(url),
//       body: body,
//       headers: {
//         "Content-Type": "application/json",
//         "accept": "application/json",
//         "Access-Control-Allow-Origin": "*"
//       },
//     );
//     print(response.body);
//     print(response.statusCode);
//     if (response.statusCode == 200) {
//       final token = signupUserFromJson(response.body);

//       id = token.data.user.id;
//       print(id);
//       return id;
//     } else {
//       print('error');
//     }
//     return id;
//   }
// }
