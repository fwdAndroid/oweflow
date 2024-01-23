import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:oweflow/screens/accountpages/noti.dart';
import 'package:oweflow/utils/colors.dart';

class CurrencyExchange extends StatefulWidget {
  @override
  _CurrencyExchangeState createState() => _CurrencyExchangeState();
}

class _CurrencyExchangeState extends State<CurrencyExchange> {
  double amount = 1.0;
  String baseCurrency = 'USD';
  String targetCurrency = 'EUR';
  double exchangeRate = 0.0;

  Future<void> fetchExchangeRate() async {
    final response = await http.get(Uri.parse(
      'https://v6.exchangerate-api.com/v6/da45de2cd29056b5f078f9e9/latest/USD',
    ));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      // Ensure 'conversion_rates' is not null and contains the target currency
      if (data != null &&
          data['conversion_rates'] != null &&
          data['conversion_rates'][targetCurrency] != null) {
        setState(() {
          exchangeRate = data['conversion_rates'][targetCurrency];
        });
      } else {
        // Handle the case where the expected data is not available
        print('Error: Unexpected API response structure');
      }
    } else {
      // Handle the case where the API call was not successful
      print('Error: Failed to load exchange rate');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchExchangeRate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  "assets/back.png",
                ),
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high)),
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: colorwhite,
                      )),
                  Text(
                    'Change Currency',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      color: colorwhite,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (builder) => Noti()));
                    },
                    child: Image.asset(
                      "assets/noti.png",
                      height: 30,
                      width: 30,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: AlignmentDirectional.topStart,
                child: Text(
                  'Enter Amount',
                  style: GoogleFonts.dmSans(
                    color: colorwhite,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    height: 0.14,
                    letterSpacing: 0.42,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                style: TextStyle(color: colorwhite),
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: borderColor)),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: borderColor)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: borderColor)),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: borderColor)),
                    hintText: "Enter Amount",
                    hintStyle:
                        GoogleFonts.dmSans(color: colorwhite, fontSize: 12)),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    amount = double.tryParse(value) ?? 0.0;
                  });
                },
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'From:',
                  style: TextStyle(color: colorwhite),
                ),
                DropdownButton<String>(
                  value: baseCurrency,
                  onChanged: (String? newValue) {
                    setState(() {
                      baseCurrency = newValue!;
                      fetchExchangeRate();
                    });
                  },
                  items: <String>['USD', 'EUR', 'GBP', 'JPY', 'CAD']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(color: black),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'To:',
                  style: TextStyle(color: colorwhite),
                ),
                DropdownButton<String>(
                  style: TextStyle(
                      color: Colors.black), // Set the global text color
                  value: targetCurrency,
                  onChanged: (String? newValue) {
                    setState(() {
                      targetCurrency = newValue!;
                      fetchExchangeRate();
                    });
                  },
                  items: <String>['USD', 'EUR', 'GBP', 'JPY', 'CAD']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(
                            color: Colors
                                .black), // Set the dropdown item text color
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Exchange Rate: 1 $baseCurrency = $exchangeRate $targetCurrency',
              style: TextStyle(color: colorwhite),
            ),
            SizedBox(height: 20),
            Text(
              'Converted Amount: ${amount * exchangeRate} $targetCurrency',
              style: TextStyle(color: colorwhite),
            ),
          ],
        ),
      ),
    );
  }
}
