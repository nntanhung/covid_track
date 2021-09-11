import 'package:flutter/material.dart';

import '../resources/consts.dart';

class CounterDetail extends StatelessWidget {
  final int number;
  final Color color;
  final String title;
  final int subtitle;

  CounterDetail({this.number, this.color, this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shadowColor: kShadowColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        width: 150,
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "$title",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Text(
                '$number'.replaceAllMapped(reg, mathFunc),
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ),
            Text(
              '+$subtitle'.replaceAllMapped(reg, mathFunc),
              style: kSubTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
