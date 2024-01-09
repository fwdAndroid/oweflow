import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oweflow/screens/auth/sign_in_page.dart';
import 'package:oweflow/screens/auth/sign_up_account.dart';
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
    return Scaffold(
      backgroundColor: black,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  "assets/splash.png",
                ),
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              "assets/uiux logos 1.png",
              height: 300,
              width: 300,
            ),
            RadioListTile<SingingCharacter>(
              title: Text(
                'Online Mode',
                style: GoogleFonts.dmSans(
                    color: colorwhite,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              subtitle: Text(
                "Use this mode to access your data across devices, receive real-time notifications, and enjoy cloud backup and synchronization.  Your data will be securely stored on our servers, ensuring accessibility and convenience.",
                style: GoogleFonts.dmSans(color: colorwhite, fontSize: 8),
              ),
              value: SingingCharacter.lafayette,
              groupValue: _character,
              onChanged: (SingingCharacter? value) {
                setState(() {
                  _character = value;
                });
              },
            ),
            RadioListTile<SingingCharacter>(
              title: Text(
                'Offline Mode',
                style: GoogleFonts.dmSans(
                    color: colorwhite,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              subtitle: Text(
                "Choose this mode for enhanced privacy and to keep your   data exclusively on your device. You won't receive real-time notifications, but you can manage your transactions and profiles locally, ensuring  complete control over your information.",
                style: GoogleFonts.dmSans(color: colorwhite, fontSize: 8),
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
            SaveButton(
                title: "Continue",
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (builder) => SignInPage()));
                }),
            Flexible(child: Container()),
          ],
        ),
      ),
    );
  }
}
