import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oweflow/offline_mode/offline_dashboard.dart';
import 'package:oweflow/screens/auth/sign_in_page.dart';
import 'package:oweflow/utils/buttons.dart';
import 'package:oweflow/utils/colors.dart';

enum SingingCharacter { lafayette, jefferson }

class SelectionScreen extends StatefulWidget {
  const SelectionScreen({super.key});

  @override
  State<SelectionScreen> createState() => _SelectionScreenState();
}

class _SelectionScreenState extends State<SelectionScreen> {
  SingingCharacter? _character = SingingCharacter.lafayette;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          final shouldPop = await _showExitDialog(context);
          return shouldPop ?? false;
        },
        child: Scaffold(
          backgroundColor: colorwhite,
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Text(
                      'Choose Mode',
                      style: GoogleFonts.plusJakartaSans(
                          color: black,
                          fontWeight: FontWeight.w600,
                          fontSize: 32),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RadioListTile<SingingCharacter>(
                    title: Text(
                      'Online Mode',
                      style: GoogleFonts.plusJakartaSans(
                          color: black,
                          fontWeight: FontWeight.w500,
                          fontSize: 19),
                    ),
                    subtitle: Text(
                      "Use this mode to access your data across devices, receive real-time notifications, and enjoy cloud backup and synchronization. Your data will be securely stored on our servers, ensuring accessibility and convenience.",
                      style: GoogleFonts.plusJakartaSans(
                          color: black,
                          fontWeight: FontWeight.w400,
                          fontSize: 13),
                    ),
                    value: SingingCharacter.lafayette,
                    groupValue: _character,
                    onChanged: (SingingCharacter? value) {
                      setState(() {
                        _character = value;
                      });
                    },
                  ),
                ),
                RadioListTile<SingingCharacter>(
                  title: Text(
                    'Offline Mode',
                    style: GoogleFonts.plusJakartaSans(
                        color: black,
                        fontWeight: FontWeight.w500,
                        fontSize: 19),
                  ),
                  subtitle: Text(
                    "Choose this mode for enhanced privacy and to keep your data exclusively on your device. You won't receive real-time notifications, but you can manage your transactions and profiles locally, ensuring complete control over your information.",
                    style: GoogleFonts.plusJakartaSans(
                        color: black,
                        fontWeight: FontWeight.w400,
                        fontSize: 13),
                  ),
                  value: SingingCharacter.jefferson,
                  groupValue: _character,
                  onChanged: (SingingCharacter? value) {
                    setState(() {
                      _character = value;
                    });
                  },
                ),
                Flexible(child: Container()),
                Center(
                  child: SaveButton(
                    title: "Continue",
                    onTap: () {
                      if (_character == SingingCharacter.lafayette) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (builder) => SignInPage()),
                        );
                      } else if (_character == SingingCharacter.jefferson) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => OfflineDashboard()),
                        );
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ));
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
