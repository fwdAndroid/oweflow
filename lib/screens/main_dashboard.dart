import 'package:flutter/material.dart';
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
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: textColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
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
          backgroundColor: Color(0xff5d3237),
          currentIndex: _currentIndex,
          elevation: 0,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(
                _currentIndex == 0 ? 'assets/homecolor.png' : 'assets/home.png',
                height: 33,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                _currentIndex == 1
                    ? 'assets/statscolor.png'
                    : 'assets/stats.png',
                height: 33,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              label: "",
              icon: Image.asset(
                _currentIndex == 2
                    ? 'assets/walletcolor.png'
                    : 'assets/wallet.png',
                height: 33,
              ),
            ),
            BottomNavigationBarItem(
              label: "",
              icon: Image.asset(
                _currentIndex == 3 ? 'assets/usercolor.png' : 'assets/user.png',
                height: 33,
              ),
            ),
          ],
          // Set the color for unselected items
        ),
      ),
    );
  }
}
