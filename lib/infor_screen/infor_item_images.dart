import 'package:flutter/material.dart';

import '../resources/consts.dart';
import '../data/list_data.dart';

class InfoItemImages extends StatelessWidget {
  final String title;
  final List<ListDataInfor> listDataInfors;

  InfoItemImages({this.title, this.listDataInfors});

  _builCard(int index) {
    return Container(
      width: 120,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: kShadowColor,
            spreadRadius: 1,
            blurRadius: 10,
            offset: Offset(1, 2),
          ),
        ],
        color: kBackgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Image.asset(
            listDataInfors[index].img,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Text(
              listDataInfors[index].description,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      child: Container(
        height: 220,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: kShadowColor,
              spreadRadius: 1,
              blurRadius: 10,
              offset: Offset(1, 2),
            ),
          ],
          color: kBackgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 10),
              child: Text(title,
                  style: TextStyle(
                    fontSize: 16,
                    color: kTitleTextColor,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: listDataInfors.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 0, 12),
                          child: _builCard(index)),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
