import 'package:flutter/material.dart';
import 'package:food_app/pages/auth/signin_page.dart';
import 'package:food_app/pages/cart/cart_page.dart';

import 'package:food_app/pages/cart_history/cart_history.dart';
import 'package:food_app/pages/cart_history/new_cart_history..dart';
import 'package:food_app/pages/home/main_food_page.dart';
import 'package:food_app/pages/profile/profile_page.dart';

import 'package:food_app/utils/app_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  List pages = const [
    MainFoodPage(),
    CartHistory(),
    CartHistory(),
   // NewHistory(),
   // NewHistory(),
    ProfilePage(),
  ];

  void onTapNav(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: pages[selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: AppColor.appMainColor,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          currentIndex: selectedIndex,
          onTap: onTapNav,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.history), label: 'history'),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart), label: 'cart'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'profile'),
          ],
        ));
  }
}
