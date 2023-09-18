import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../screens/home_screen.dart';

class Screen {
  static const appBar = 'Grambu Task';
  static const color = '';
}

TextStyle simpleTextStyle = GoogleFonts.poppins(
    color: Colors.brown,
    fontSize: w * .04,
    fontWeight: FontWeight.w500,
    letterSpacing: .55);

void navigateScreen(BuildContext context, Widget screen) {
  Navigator.of(context).push(CupertinoPageRoute(builder: (context) => screen));
}

void showSnackBar(BuildContext context, String message, Color color) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
          duration: const Duration(seconds: 2),
          content: Text(
            message,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.w500,
                letterSpacing: 1),
          ),
          backgroundColor: color),
    );
}
