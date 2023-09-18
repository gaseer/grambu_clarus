import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void navigateScreen(BuildContext context, Widget screen) {
  Navigator.of(context).push(CupertinoPageRoute(builder: (context) => screen));
}

void showSnackBar(BuildContext context, String message, Color color) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
        content: Text(
          message,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: color),
  );
}
