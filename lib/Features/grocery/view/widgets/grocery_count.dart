import 'package:flutter/material.dart';
import 'package:sv_craft/constant/color.dart';

class GroceryCount extends StatefulWidget {
  const GroceryCount({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  State<GroceryCount> createState() => _GroceryCountState();
}

class _GroceryCountState extends State<GroceryCount> {
  var count = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              count > 0 ? count-- : count = 0;
            });
          },
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Appcolor.primaryColor,
              borderRadius: BorderRadius.circular(100),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12, //color of shadow
                  spreadRadius: 2, //spread radius
                  blurRadius: 5, // blur radius
                  offset: Offset(0, 2), // changes position of shadow
                  //first paramerter of offset is left-right
                  //second parameter is top to down
                )
              ],
            ),
            width: 35,
            height: 35,
            child: const Text(
              '-',
              style: TextStyle(color: Colors.white, fontSize: 25),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        InkWell(
          onTap: () {},
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Appcolor.primaryColor,
              borderRadius: BorderRadius.circular(8),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12, //color of shadow
                  spreadRadius: 2, //spread radius
                  blurRadius: 5, // blur radius
                  offset: Offset(0, 2), // changes position of shadow
                  //first paramerter of offset is left-right
                  //second parameter is top to down
                )
              ],
            ),
            width: 50,
            height: 35,
            child: Text(
              count.toString(),
              style: TextStyle(color: Colors.white, fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        InkWell(
          onTap: () {
            setState(() {
              count++;
            });
          },
          child: Container(
            padding: const EdgeInsets.all(5),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Appcolor.primaryColor,
              borderRadius: BorderRadius.circular(100),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12, //color of shadow
                  spreadRadius: 2, //spread radius
                  blurRadius: 5, // blur radius
                  offset: Offset(0, 2), // changes position of shadow
                  //first paramerter of offset is left-right
                  //second parameter is top to down
                )
              ],
            ),
            width: 35,
            height: 35,
            child: const Text(
              '+',
              style: TextStyle(color: Colors.white, fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
