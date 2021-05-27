import 'package:covid_track/resources/consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../data/list_data.dart';

class InfoItemImages extends StatelessWidget {
  final String title;
  final List<ListDataInfor> listDataInfors;

  InfoItemImages({this.title, this.listDataInfors});

  _builCard(int index) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            listDataInfors[index].img,
            width: 120,
          ),
          Flexible(
            child: Container(
              width: 120,
              padding: EdgeInsets.all(5),
              child: Text(
                listDataInfors[index].description,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Container(
        padding: EdgeInsets.only(top: 10, left: 0, right: 5),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: kShadowColor,
              spreadRadius: 1,
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
              padding: EdgeInsets.only(left: 20, bottom: 5),
              child: Text(title,
                  style: TextStyle(
                    fontSize: 16,
                    color: kTitleTextColor,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            Container(
              padding: EdgeInsets.only(left: 5, bottom: 5),
              height: MediaQuery.of(context).size.width * 0.5,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: listDataInfors.length,
                itemBuilder: (context, index) {
                  return _builCard(index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
