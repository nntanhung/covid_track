import "package:flutter/material.dart";

class GradientAppBar extends StatelessWidget {
  final String title;

  GradientAppBar(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: new EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: new Padding(
        padding: const EdgeInsets.only(left: 15.0, top: 15.0, bottom: 15.0),
        child: Text(
          title,
          style: new TextStyle(
              fontSize: 18.0, fontWeight: FontWeight.w500, color: Colors.white),
        ),
      ),
      decoration: new BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color(0xFF3383CD),
            Color(0xFF11249F),
          ],
        ),
      ),
    );
  }
}
