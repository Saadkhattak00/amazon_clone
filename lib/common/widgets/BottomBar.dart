import 'package:amazon_clone/Provider/user_provider.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/account/screens/account_screen.dart';
import 'package:amazon_clone/features/cart/screens/cart_screen.dart';
import 'package:amazon_clone/features/home/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomBar extends StatefulWidget {
  static const String routeName = '/actual-home';
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _page = 0;
  double BottomBarWidth = 42;
  double BottomBarBorderWidth = 5;

  List<Widget> pages = [
    const HomeScreen(),
    const AccountScreen(),
    const cartScreen(),
  ];

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userCartLen = context.watch<UserProvider>().user.cart.length;

    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: GlobalVariables.backgroundColor,
        iconSize: 28,
        onTap: updatePage,
        items: [
          //HOME
          BottomNavigationBarItem(
              icon: Container(
                width: BottomBarWidth,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                        color: _page == 0
                            ? GlobalVariables.selectedNavBarColor
                            : GlobalVariables.backgroundColor,
                        width: BottomBarBorderWidth),
                  ),
                ),
                child: const Icon(Icons.home_outlined),
              ),
              label: ''),
          // ACCOUNT
          BottomNavigationBarItem(
              icon: Container(
                width: BottomBarWidth,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                        color: _page == 1
                            ? GlobalVariables.selectedNavBarColor
                            : GlobalVariables.backgroundColor,
                        width: BottomBarBorderWidth),
                  ),
                ),
                child: const Icon(Icons.person_outline_outlined),
              ),
              label: ''),
          // CART
          BottomNavigationBarItem(
              icon: Container(
                width: BottomBarWidth,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                        color: _page == 2
                            ? GlobalVariables.selectedNavBarColor
                            : GlobalVariables.backgroundColor,
                        width: BottomBarBorderWidth),
                  ),
                ),
                child: Badge(
                    label: Text(userCartLen.toString()),
                    backgroundColor: Colors.red,
                    child: const Icon(Icons.shopping_cart_outlined)),
              ),
              label: ''),
        ],
      ),
    );
  }
}
