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
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: kShadowColor.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 10,
            offset: Offset(1, 1),
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
          Padding(
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
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      child: Container(
        height: 230,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: kShadowColor.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 5,
              offset: Offset(2, 2),
            ),
          ],
          color: kBackgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 12),
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
                  return Container(
                    padding: index == listDataInfors.length - 1
                        ? const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 12)
                        : const EdgeInsets.fromLTRB(15, 12, 0, 12),
                    child: _builCard(index),
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
