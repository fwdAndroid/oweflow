import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:oweflow/utils/buttons.dart';
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
    TextEditingController _amountController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: black,
            )),
        centerTitle: true,
        title: Text(
          "Change Currency",
          style: GoogleFonts.plusJakartaSans(
              color: black, fontWeight: FontWeight.w500, fontSize: 16),
        ),
      ),
      body: Column(
        children: [
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
                  color: black,
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
              controller: _amountController,
              style: TextStyle(color: black),
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
                  hintStyle: GoogleFonts.dmSans(color: black, fontSize: 12)),
              keyboardType: TextInputType.number,
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'From:',
                style: TextStyle(color: black),
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
                style: TextStyle(color: black),
              ),
              DropdownButton<String>(
                style:
                    TextStyle(color: Colors.black), // Set the global text color
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
                          color:
                              Colors.black), // Set the dropdown item text color
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
          SizedBox(height: 20),
          Text(
            'Exchange Rate: 1 $baseCurrency = $exchangeRate $targetCurrency',
            style: TextStyle(color: black),
          ),
          SizedBox(height: 20),
          Text(
            'Converted Amount: ${amount * exchangeRate} $targetCurrency',
            style: TextStyle(color: black),
          ),
          SaveButton(
              title: "Convert",
              onTap: () {
                amount = double.tryParse(_amountController.text) ?? 0.0;
              })
        ],
      ),
    );
  }
}
