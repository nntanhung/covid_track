import 'package:flutter/material.dart';

import '../resources/consts.dart';

class Counter extends StatelessWidget {
  final int number;
  final Color color;
  final String title;
  final int subtitle;

  Counter({this.number, this.color, this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2.2,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: kBackgroundColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: kShadowColor,
            blurRadius: 5,
            offset: Offset(1, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            height: 24,
            width: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color.withOpacity(0.26),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              '$number'.replaceAllMapped(reg, mathFunc),
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 3.0),
            child: Text(
              "+$subtitle".replaceAllMapped(reg, mathFunc),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: kTextLightColor,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 0),
            child: Text(
              "$title",
              style: kSubTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}
