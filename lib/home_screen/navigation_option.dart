import 'package:covid_track/resources/consts.dart';
import 'package:flutter/material.dart';

class NavigationOption extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool selected;
  final Function() onSelected;

  NavigationOption(
      {@required this.title,
      @required this.icon,
      @required this.selected,
      @required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onSelected();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            icon,
            color: selected ? kPrimaryColor : Colors.grey[400],
          ),
          Text(
            title,
            style: TextStyle(
              color: selected ? kPrimaryColor : Colors.grey[400],
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
