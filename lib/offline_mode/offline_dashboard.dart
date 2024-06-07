import 'package:flutter/material.dart';
import 'package:oweflow/offline_mode/dashboard/off_line_home_page.dart';
import 'package:oweflow/offline_mode/dashboard/offline_account_page.dart';
import 'package:oweflow/offline_mode/dashboard/offline_stat_page.dart';
import 'package:oweflow/offline_mode/dashboard/offline_wallet_page.dart';
import 'package:oweflow/offline_mode/offline_transaction_form/offline_transaction_form.dart';
import 'package:oweflow/utils/colors.dart';

class OfflineDashboard extends StatefulWidget {
  const OfflineDashboard({super.key});

  @override
  State<OfflineDashboard> createState() => _OfflineDashboardState();
}

class _OfflineDashboardState extends State<OfflineDashboard> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    OfflineHomePage(), // Replace with your screen widgets
    StatsPageOffline(),
    WalletPageOffline(),
    AccountPageOffline(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: buttonColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (builder) => OfflineTransactionForm()));
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
              icon: Image.asset(
                _currentIndex == 2 ? 'assets/vs.png' : 'assets/wave.png',
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
    );
  }
}
