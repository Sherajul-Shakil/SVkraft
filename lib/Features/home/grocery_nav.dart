// import 'package:flutter/material.dart';

// class BottomNavigation extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//       int _page = 0;
//   double bottomBarWidth = 42;
//   double bottomBarBorderWidth = 5;

//     void updatePage(int page) {
//     setState(() {
//       _page = page;
//     });
//   }
//     return BottomNavigationBar(
//         currentIndex: _page,
//         selectedItemColor: Colors.red,
//         unselectedItemColor: Colors.grey,
//         backgroundColor: Colors.red,
//         // fixedColor: Colors.red,
//         iconSize: 28,
//         onTap: updatePage,
//         items: [
//           // HOME
//           BottomNavigationBarItem(
//             icon: Container(
//               width: bottomBarWidth,
//               decoration: const BoxDecoration(
//                 border: Border(
//                     // top: BorderSide(
//                     //   color: _page == 0
//                     //       ? Appcolor.selectedNavBarColor
//                     //       : Appcolor.backgroundColor,
//                     //   //width: bottomBarBorderWidth,
//                     // ),
//                     ),
//               ),
//               child: const Icon(
//                 Icons.home_outlined,
//               ),
//             ),
//             label: 'Home',
//           ),
//           // ACCOUNT
//           BottomNavigationBarItem(
//             icon: Container(
//               width: bottomBarWidth,
//               decoration: BoxDecoration(
//                 border: Border(),
//               ),
//               child: const Icon(
//                 Icons.category_outlined,
//               ),
//             ),
//             label: 'Category',
//           ),
//           BottomNavigationBarItem(
//             icon: Container(
//               width: bottomBarWidth,
//               decoration: BoxDecoration(
//                 border: Border(),
//               ),
//               child: Badge(
//                 elevation: 0,
//                 badgeContent: Text(
//                   3.toString(),
//                   style: TextStyle(
//                     color: Appcolor.primaryColor,
//                     fontSize: 15,
//                   ),
//                 ),
//                 badgeColor: Colors.white,
//                 child: const Icon(
//                   Icons.shopping_cart_outlined,
//                 ),
//               ),
//             ),
//             label: 'Cart',
//           ),

//           BottomNavigationBarItem(
//             icon: Container(
//               width: bottomBarWidth,
//               decoration: BoxDecoration(
//                 border: Border(),
//               ),
//               child: const Icon(
//                 Icons.view_list_outlined,
//               ),
//             ),
//             label: 'Order list',
//           ),
//           BottomNavigationBarItem(
//             icon: Container(
//               width: bottomBarWidth,
//               decoration: BoxDecoration(
//                 border: Border(),
//               ),
//               child: const Icon(
//                 Icons.person,
//               ),
//             ),
//             label: 'Profile',
//           ),
//         ],
//       );
//   }