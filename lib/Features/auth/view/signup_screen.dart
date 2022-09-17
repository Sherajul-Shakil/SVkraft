import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:sv_craft/Features/auth/view/signin_screen.dart';
import 'package:sv_craft/Features/home/home_screen.dart';
import 'package:sv_craft/common/bottom_button_column.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:sv_craft/constant/color.dart';

import '../../../common/otp_botton.dart';
import '../../home/bottom_bar.dart';
import '../controllar/signup_controllar.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  String initialCountry = 'BD';
  PhoneNumber number = PhoneNumber(isoCode: 'BD');
  var phone;
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  var otpUser;

  final _codeController = TextEditingController();

  Future loginUser(String phone, BuildContext context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    _auth.verifyPhoneNumber(
      phoneNumber: phone,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) async {
        Navigator.of(context).pop();

        UserCredential result = await _auth.signInWithCredential(credential);

        if (result.user != null) {
          var token = await register(
            phone.trim(),
            _userNameController.text.trim(),
            _emailController.text.trim(),
            _passwordController.text.trim(),
          );
          print('Token from ui $token');
          if (token != null) {
            print('11111111111111111111111111111111111111111111111111111');
            final snackBar = SnackBar(
              content: const Text('Registration Successful'),
              action: SnackBarAction(
                label: '',
                onPressed: () {},
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            // Get.toNamed('/signupotp');
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => LoginPage()),
            // );
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => HomeScreen()));
          }
        } else {
          print("Error from ui");
        }

        //This callback would gets called when verification is done auto maticlly
      },
      verificationFailed: (Exception exception) {
        print(exception);
      },
      codeSent: (String verificationId, int? resendToken) {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return AlertDialog(
                title: const Text("Insert the code?"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextField(
                      controller: _codeController,
                      keyboardType:
                          const TextInputType.numberWithOptions(signed: true),
                    ),
                  ],
                ),
                actions: <Widget>[
                  FlatButton(
                    child: const Text("Confirm"),
                    textColor: Colors.white,
                    color: Colors.blue,
                    onPressed: () async {
                      // String comingSms = (await AltSmsAutofill().listenForSms)!;
                      // String aStr =
                      //     comingSms.replaceAll(new RegExp(r'[^0-9]'), '');
                      // String otp = aStr.substring(0, 6);

                      // final code = otp;
                      // print(comingSms);

                      final code = _codeController.text.trim();
                      AuthCredential credential = PhoneAuthProvider.credential(
                          verificationId: verificationId, smsCode: code);

                      UserCredential result =
                          await _auth.signInWithCredential(credential);

                      if (result.user != null) {
                        var token = await register(
                          phone.trim(),
                          _userNameController.text.trim(),
                          _emailController.text.trim(),
                          _passwordController.text.trim(),
                        );

                        if (token != null) {
                          Navigator.of(context).pop();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()));
                        }
                      } else {
                        print("Error from ui 2");
                      }
                    },
                  )
                ],
              );
            });
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        print('Time Out');
      },
    );
  }

  // Future getUser({required String verificationId}) async {
  //   FirebaseAuth _auth = FirebaseAuth.instance;
  //   final code = _codeController.text.trim();
  //   AuthCredential credential = PhoneAuthProvider.credential(
  //       verificationId: verificationId, smsCode: code);

  //   UserCredential result = await _auth.signInWithCredential(credential);

  //   if (result.user != null) {
  //     var token = await register(
  //       phone.trim(),
  //       _userNameController.text.trim(),
  //       _emailController.text.trim(),
  //       _passwordController.text.trim(),
  //     );
  //     print(token);
  //     if (token != null) {
  //       final snackBar = SnackBar(
  //         content: const Text('Registration Successful 1'),
  //         action: SnackBarAction(
  //           label: '',
  //           onPressed: () {},
  //         ),
  //       );
  //       ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //       Get.toNamed('/signin');
  //       // Navigator.push(
  //       //   context,
  //       //   MaterialPageRoute(builder: (context) => LoginPage()),
  //       // );
  //     }
  //   } else {
  //     print("Error");
  //   }
  // }

  // Future loginUser(String phone, BuildContext context) async {
  //   FirebaseAuth _auth = FirebaseAuth.instance;

  //   _auth.verifyPhoneNumber(
  //     phoneNumber: phone,
  //     timeout: const Duration(seconds: 60),
  //     verificationCompleted: (PhoneAuthCredential credential) async {
  //       Navigator.of(context).pop();

  //       UserCredential result = await _auth.signInWithCredential(credential);

  //       if (result.user != null) {
  //         var token = await register(
  //           phone.trim(),
  //           _userNameController.text.trim(),
  //           _emailController.text.trim(),
  //           _passwordController.text.trim(),
  //         );
  //         print(token);
  //         if (token != null) {
  //           final snackBar = SnackBar(
  //             content: const Text('Registration Successful 2'),
  //             action: SnackBarAction(
  //               label: '',
  //               onPressed: () {},
  //             ),
  //           );
  //           ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //           Get.toNamed('/signin');
  //           // Navigator.push(
  //           //   context,
  //           //   MaterialPageRoute(builder: (context) => LoginPage()),
  //           // );
  //         }
  //       } else {
  //         print("Error");
  //       }
  //     },
  //     verificationFailed: (Exception exception) {
  //       print(exception);
  //     },
  //     codeSent: (String verificationId, int? resendToken) {
  //       showDialog(
  //           context: context,
  //           barrierDismissible: false,
  //           builder: (context) {
  //             return AlertDialog(
  //               title: const Text("Insert the code?"),
  //               content: Column(
  //                 mainAxisSize: MainAxisSize.min,
  //                 children: <Widget>[
  //                   TextField(
  //                     controller: _codeController,
  //                     keyboardType:
  //                         const TextInputType.numberWithOptions(signed: true),
  //                   ),
  //                 ],
  //               ),
  //               actions: <Widget>[
  //                 FlatButton(
  //                   child: const Text("Confirm"),
  //                   textColor: Colors.white,
  //                   color: Colors.blue,
  //                   onPressed: () async {
  //                     // var userValue =
  //                     getUser(verificationId: verificationId).then(
  //                       (value) async {
  //                         if (value != null) {
  //                           var token = await register(
  //                             phone.trim(),
  //                             _userNameController.text.trim(),
  //                             _emailController.text.trim(),
  //                             _passwordController.text.trim(),
  //                           );
  //                           print(token);
  //                           if (token != null) {
  //                             final snackBar = SnackBar(
  //                               content:
  //                                   const Text('Registration Successful 3'),
  //                               action: SnackBarAction(
  //                                 label: '',
  //                                 onPressed: () {},
  //                               ),
  //                             );
  //                             ScaffoldMessenger.of(context)
  //                                 .showSnackBar(snackBar);
  //                             Get.toNamed('/signin');
  //                             // Navigator.push(
  //                             //   context,
  //                             //   MaterialPageRoute(builder: (context) => LoginPage()),
  //                             // );
  //                           }
  //                         }
  //                       },
  //                     );

  //                   },
  //                 )
  //               ],
  //             );
  //           });
  //     },
  //     codeAutoRetrievalTimeout: (String verificationId) {
  //       print('Time Out');
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  SizedBox(
                    width: 20,
                  ),
                  Icon(
                    Icons.location_on_outlined,
                    size: 30,
                    color: Colors.black,
                  ),
                  Text(
                    "XYZ",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  const Text(
                    "Getting Started",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Create an account to continue!",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Colors.grey.withOpacity(0.8),
                    ),
                  ),
                  SizedBox(
                    height: 35,
                  ),

                  //fffffffffffffffffffffffffff
                  Padding(
                    padding: const EdgeInsets.all(0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Phone Number",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: Colors.grey.withOpacity(0.8),
                            ),
                            textAlign: TextAlign.left,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white.withOpacity(0.1),
                                    spreadRadius: 1,
                                    blurRadius: 1,
                                    offset: const Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: Container(
                                height: size.height / 15,
                                width: size.width,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.white.withOpacity(0.1),
                                      spreadRadius: 1,
                                      blurRadius: 1,
                                      offset: const Offset(0, 1),
                                    ),
                                  ],
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: InternationalPhoneNumberInput(
                                    onInputChanged: (PhoneNumber number) {
                                      phone = number.phoneNumber;
                                      print(number.phoneNumber);
                                      // setState(() {
                                      //   phone = number.phoneNumber;
                                      // });
                                    },
                                    onInputValidated: (bool value) {
                                      print(value);
                                    },
                                    selectorConfig: const SelectorConfig(
                                      selectorType:
                                          PhoneInputSelectorType.BOTTOM_SHEET,
                                    ),
                                    ignoreBlank: false,
                                    autoValidateMode: AutovalidateMode.disabled,
                                    selectorTextStyle:
                                        const TextStyle(color: Colors.black),
                                    initialValue: number,
                                    textFieldController: _phoneNumberController,
                                    formatInput: false,
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                      signed: true,
                                      decimal: true,
                                    ),
                                    // validator: (v) => v!.isEmpty
                                    //     ? "Field Can't be Empty"
                                    //     : null,
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return 'This field is required';
                                      }
                                      if (value.trim().length < 9) {
                                        return 'Number must be at least 11 characters in length';
                                      }
                                      // Return null if the entered username is valid
                                      return null;
                                    },
                                    inputBorder: InputBorder.none,
                                    onSaved: (PhoneNumber number) {
                                      print('On Saved: $number');
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Text(
                            "Username",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: Colors.grey.withOpacity(0.8),
                            ),
                            textAlign: TextAlign.left,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                new BoxShadow(
                                  color: Colors.white,
                                  blurRadius: 20.0,
                                ),
                              ],
                            ),
                            child: Card(
                              child: TextFormField(
                                controller: _userNameController,
                                decoration: const InputDecoration(
                                  //labelText: 'Username',
                                  hintText: "Username",
                                  prefixIcon: Icon(Icons.person_outline),
                                  border: InputBorder.none,
                                ),

                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'This field is required';
                                  }
                                  if (value.trim().length < 4) {
                                    return 'Username must be at least 4 characters in length';
                                  }
                                  // Return null if the entered username is valid
                                  return null;
                                },
                                //onChanged: (value) => _userName = value,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Text(
                            "Email",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: Colors.grey.withOpacity(0.8),
                            ),
                            textAlign: TextAlign.left,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                new BoxShadow(
                                  color: Colors.white,
                                  blurRadius: 20.0,
                                ),
                              ],
                            ),
                            child: Card(
                              child: TextFormField(
                                controller: _emailController,
                                decoration: const InputDecoration(
                                  //labelText: 'Username',
                                  hintText: "Email",
                                  prefixIcon: Icon(Icons.email),
                                  border: InputBorder.none,
                                ),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'This field is required';
                                  }
                                  if (!value.trim().contains("@")) {
                                    return 'Email must contain @ sign ';
                                  }
                                  // Return null if the entered username is valid
                                  return null;
                                },
                                //onChanged: (value) => _userName = value,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Text(
                            "Password",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: Colors.grey.withOpacity(0.8),
                            ),
                            textAlign: TextAlign.left,
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white,
                                  blurRadius: 20.0,
                                ),
                              ],
                            ),
                            child: Card(
                              child: TextFormField(
                                controller: _passwordController,
                                decoration: const InputDecoration(
                                  hintText: '* * * * * *',
                                  prefixIcon: Icon(Icons.lock),
                                  suffixIcon: Icon(Icons.remove_red_eye),
                                  border: InputBorder.none,
                                ),
                                obscureText: true,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'This field is required';
                                  }
                                  if (value.trim().length < 8) {
                                    return 'Password must be at least 8 characters in length';
                                  }
                                  // Return null if the entered password is valid
                                  return null;
                                },
                                //onChanged: (value) => _userName = value,
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Checkbox(
                                value: true,
                                onChanged: (value) {
                                  setState(() {
                                    //_isChecked = value;
                                  });
                                },
                                fillColor: MaterialStateProperty.all(
                                    Appcolor.primaryColor),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "By creating account, you are agree to our",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      color: Colors.grey.withOpacity(0.8),
                                    ),
                                  ),
                                  InkWell(
                                    child: Text("Term and Conditions"),
                                    onTap: () {},
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * .05,
                  ),
                  BottomButtonColumn(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        // var token = await register(
                        //   phone.trim(),
                        //   _userNameController.text.trim(),
                        //   _emailController.text.trim(),
                        //   _passwordController.text.trim(),
                        // );
                        // print(token);
                        // if (token != null) {
                        //   final snackBar = SnackBar(
                        //     content: const Text('Registration Successful'),
                        //     action: SnackBarAction(
                        //       label: '',
                        //       onPressed: () {},
                        //     ),
                        //   );
                        //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        //   // Get.toNamed('/signupotp');
                        //   // Navigator.push(
                        //   //   context,
                        //   //   MaterialPageRoute(builder: (context) => LoginPage()),
                        //   // );
                        // }

                        await loginUser(phone, context);
                        // var usercreated =
                        // if (usercreated != null) {
                        //   print('Print from ui ${otpUser}');
                        // }
                        //  else {
                        //   print(
                        //       'No userrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr');
                        // }

                        // Get.toNamed('/signupotp');
                      }
                    },
                    buttonText: "SIGN UP",
                    buttonIcon: Icons.login_outlined,
                  ),
                  SizedBox(
                    height: size.height * .02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Colors.grey.withOpacity(0.8),
                        ),
                      ),
                      TextButton(
                        child: const Text(
                          "Sign in",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        onPressed: () {
                          Get.toNamed('/signin');
                        },
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
