import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
    return Scaffold(
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
                      color: black, fontWeight: FontWeight.w600, fontSize: 32),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RadioListTile<SingingCharacter>(
                title: Text(
                  'Online Mode',
                  style: GoogleFonts.plusJakartaSans(
                      color: black, fontWeight: FontWeight.w500, fontSize: 19),
                ),
                subtitle: Text(
                  "Use this mode to access your data across devices, receive real-time notifications, and enjoy cloud backup and synchronization.  Your data will be securely stored on our servers, ensuring accessibility and convenience.",
                  style: GoogleFonts.plusJakartaSans(
                      color: black, fontWeight: FontWeight.w400, fontSize: 13),
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
                    color: black, fontWeight: FontWeight.w500, fontSize: 19),
              ),
              subtitle: Text(
                "Choose this mode for enhanced privacy and to keep your   data exclusively on your device. You won't receive real-time notifications, but you can manage your transactions and profiles locally, ensuring  complete control over your information.",
                style: GoogleFonts.plusJakartaSans(
                    color: black, fontWeight: FontWeight.w400, fontSize: 13),
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (builder) => SignInPage()));
                  }),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
