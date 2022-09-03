import 'dart:ffi';

import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.text,
    required this.boxColor,
    required this.textColor,
    required VoidCallback this.onTap,
  }) : super(key: key);

  final String text;
  final Color boxColor;
  final Color textColor;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(5),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: boxColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12, //color of shadow
              spreadRadius: 1, //spread radius
              blurRadius: 0, // blur radius
              offset: Offset(0, 0), // changes position of shadow
              //first paramerter of offset is left-right
              //second parameter is top to down
            )
          ],
        ),
        width: size.width * .3,
        height: size.width * .38,
        child: Text(
          text,
          style: TextStyle(color: textColor, fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
