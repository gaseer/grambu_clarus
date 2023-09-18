import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../home_screen.dart';

class ProductWeightWidget extends StatelessWidget {
  final String text1, text2, text3, text4;
  const ProductWeightWidget(
      {Key? key,
      required this.text1,
      required this.text2,
      required this.text3,
      required this.text4})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 12.0,
        right: 10,
        top: 5,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(text1),
          Text(text2),
          Text(text3),
          Text(text4),
        ],
      ),
    );
  }
}
