import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    var list = [
      "Help Moviing",
      "Furniture Assembly",
      "Mounting",
      "Home Repairs",
      "Personal Assistant",
      "Delivery",
      "Hard Work",
      "Practice & Unpacking",
      "Painting",
      "Cleaning",
      "Heavy Liffing"
    ];
    return SafeArea(
      child: Scaffold(
        body: Wrap(
          children: list
              .map((f) => GestureDetector(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      margin: const EdgeInsets.only(
                          left: 5.0, right: 5.0, top: 10.0, bottom: 10.0),
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Color(0xFF282f61), width: 2.0),
                        borderRadius: const BorderRadius.all(Radius.circular(
                                10.0) //                 <--- border radius here
                            ),
                      ),
                      child: Text(
                        f,
                        style: const TextStyle(
                          color: Color(0xFF17b01b),
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    onTap: () {},
                  ))
              .toList(),
        ),
      ),
    );
  }
}
