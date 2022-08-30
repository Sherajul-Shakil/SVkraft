import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sv_craft/Features/auth/view/signin_screen.dart';
import 'package:sv_craft/Features/auth/view/signup_screen.dart';
import 'package:sv_craft/Features/home/home_screen.dart';
import 'package:sv_craft/Features/home/market_product.dart';
import 'package:sv_craft/Features/home/product_page_test.dart';
import 'package:sv_craft/Features/home/test.dart';
import 'package:sv_craft/splash_screen.dart';

import 'Features/auth/view/forgate_password_screen.dart';
import 'Features/auth/view/forgate_otp.dart';
import 'Features/auth/view/signup_otp.dart';
import 'Features/home/bottom_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SV Kraft',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        initialRoute: "/bottombar",
        getPages: [
          GetPage(name: "/", page: () => SplashScreen()),
          GetPage(name: "/signin", page: () => SigninScreen()),
          GetPage(name: "/signup", page: () => SignupScreen()),
          GetPage(name: "/forgatepass", page: () => ForgatePasswordScreen()),
          GetPage(name: "/forgateotp", page: () => OtpSendScreen()),
          GetPage(name: "/signupotp", page: () => OtpToHomeScreen()),
          GetPage(name: "/home", page: () => HomeScreen()),
          GetPage(name: "/bottombar", page: () => BottomBar()),
          GetPage(name: "/test", page: () => Testpage()),
          GetPage(name: "/marketproduct", page: () => MarketProduct()),
        ]
        //home: SplashScreen(),
        );
  }
}
