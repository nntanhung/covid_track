import 'package:covid_track/infor_screen/call.dart';
import 'package:covid_track/resources/consts.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountryLoading extends StatelessWidget {
  final bool inputTextLoading;

  CountryLoading({@required this.inputTextLoading});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          loadingCard(context),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Cập nhật: " + '-- / --  -  --:--',
                  style: kDescribeStyle,
                ),
                InkWell(
                  onTap: launchURL,
                  child: Text.rich(
                    TextSpan(
                      text: 'Nguồn: ',
                      children: [
                        TextSpan(
                          text: 'Bộ Y Tế, WHO',
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget loadingCard(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  containerBox(context),
                  const SizedBox(height: 10),
                  containerBox(context),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  containerBox(context),
                  const SizedBox(height: 10),
                  containerBox(context),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget containerBox(BuildContext context) {
    return Container(
      height: 120,
      width: MediaQuery.of(context).size.width / 2.3,
      decoration: BoxDecoration(
        color: kBackgroundColor,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: kShadowColor,
            blurRadius: 5,
            offset: Offset(1, 3),
          ),
        ],
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.white,
        highlightColor: Colors.grey[200],
        child: Container(
          height: 120,
          width: MediaQuery.of(context).size.width / 2.5,
          decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
        ),
      ),
    );
  }
}

class CountryChartLoading extends StatelessWidget {
  final bool inputTextLoading;

  CountryChartLoading({@required this.inputTextLoading});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding:
              const EdgeInsets.only(top: 25, left: 15, right: 15, bottom: 5),
          alignment: Alignment.centerLeft,
          child: Text(
            'Biểu đồ tổng số ca mắc Covid-19',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: kTitleTextColor,
            ),
          ),
        ),
        loadingChartCard(),
      ],
    );
  }

  Widget loadingChartCard() {
    return Column(
      children: [
        Card(
          elevation: 5,
          shadowColor: kShadowColor,
          child: Container(
            height: 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Shimmer.fromColors(
              baseColor: Colors.white,
              highlightColor: Colors.grey[200],
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Text("Cập nhật từ: " + '--/-- đến --/--'),
        ),
      ],
    );
  }
}
