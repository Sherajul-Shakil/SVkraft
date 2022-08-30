import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:sv_craft/Features/home/home_screen.dart';
import 'package:sv_craft/constant/color.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _page = 0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;

  List<Widget> pages = [
    const HomeScreen(),
    const HomeScreen(),
    const HomeScreen(),
  ];

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor: Appcolor.selectedNavBarColor,
        unselectedItemColor: Appcolor.unselectedNavBarColor,
        backgroundColor: Appcolor.backgroundColor,
        iconSize: 28,
        onTap: updatePage,
        items: [
          // HOME
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                    // top: BorderSide(
                    //   color: _page == 0
                    //       ? Appcolor.selectedNavBarColor
                    //       : Appcolor.backgroundColor,
                    //   //width: bottomBarBorderWidth,
                    // ),
                    ),
              ),
              child: const Icon(
                Icons.home_outlined,
              ),
            ),
            label: 'Home',
          ),
          // ACCOUNT
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(),
              ),
              child: const Icon(
                Icons.category_outlined,
              ),
            ),
            label: 'Category',
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(),
              ),
              child: const Icon(
                Icons.shopping_cart_outlined,
              ),
            ),
            label: 'Cart',
          ),

          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(),
              ),
              child: const Icon(
                Icons.view_list_outlined,
              ),
            ),
            label: 'Order list',
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(),
              ),
              child: const Icon(
                Icons.person,
              ),
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
