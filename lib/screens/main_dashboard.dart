import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oweflow/screens/pages/account_page.dart';
import 'package:oweflow/screens/pages/home_page.dart';
import 'package:oweflow/screens/pages/stats_page.dart';
import 'package:oweflow/screens/pages/transaction_form.dart';
import 'package:oweflow/screens/pages/wallet_page.dart';
import 'package:oweflow/utils/colors.dart';

class MainDashboard extends StatefulWidget {
  const MainDashboard({super.key});

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomePage(), // Replace with your screen widgets
    StatsPage(),
    WalletPage(),
    AccountPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await _showExitDialog(context);
        return shouldPop ?? false;
      },
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: buttonColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (builder) => TransactionForm()));
          },
          child: Icon(
            Icons.add,
            color: colorwhite,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: _screens[_currentIndex],
        bottomNavigationBar: Container(
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: colorwhite,
            currentIndex: _currentIndex,
            elevation: 0,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: _currentIndex == 0
                    ? Image.asset(
                        "assets/home.png",
                        height: 24,
                      )
                    : Icon(
                        Icons.home_filled,
                        size: 24,
                        color: Color(0xffDBE0E0),
                      ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  _currentIndex == 1
                      ? 'assets/walletcolor.png'
                      : 'assets/wallet.png',
                  height: 24,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                label: "",
                icon: _currentIndex == 2
                    ? Icon(
                        Icons.waves,
                        size: 24,
                        color: Color(0xff7C5CFC),
                      )
                    : Image.asset(
                        'assets/wave.png',
                        height: 24,
                      ),
              ),
              BottomNavigationBarItem(
                  label: "",
                  icon: _currentIndex == 3
                      ? Icon(
                          Icons.person,
                          size: 24,
                          color: Color(0xff7C5CFC),
                        )
                      : Image.asset(
                          'assets/p.png',
                          height: 24,
                        )),
            ],
            // Set the color for unselected items
          ),
        ),
      ),
    );
  }

  Future<bool?> _showExitDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Exit App'),
        content: Text('Do you want to exit the app?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('No'),
          ),
          TextButton(
            onPressed: () {
              if (Platform.isAndroid) {
                SystemNavigator.pop(); // For Android
              } else if (Platform.isIOS) {
                exit(0); // For iOS
              }
            },
            child: Text('Yes'),
          ),
        ],
      ),
    );
  }
}
