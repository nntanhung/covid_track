import 'package:flutter/material.dart';

import '../resources/consts.dart';
import '../infor_screen/faqs.dart';
import '../widgets/my_header.dart';

class InforAppPage extends StatefulWidget {
  @override
  _InforAppPageState createState() => _InforAppPageState();
}

class _InforAppPageState extends State<InforAppPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          MyHeader(
            image: "assets/icons/people.svg",
            textTop: "Thông tin về\nỨNG DỤNG",
            offset: 1,
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 5,
                  shadowColor: kShadowColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'ĐỒ ÁN TỐT NGHIỆP'.toUpperCase(),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              // color: kPrimaryColor,
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            'NGHIÊN CỨU KỸ THUẬT LẬP TRÌNH FLUTTER VÀ '
                            'XÂY DỰNG ỨNG DỤNG THEO DÕI TÌNH HÌNH DỊCH BỆNH COVID-19',
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              // color: kPrimaryColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Ngô Nguyễn Tấn Hưng'.toUpperCase(),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'MSSV: 16DDS0603217',
                          style: kSubTextStyle,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              _inforListView(),
            ],
          ),
        ],
      ),
    );
  }
}

Widget _inforListView() {
  return ListView.builder(
    itemCount: DataInfor.questionAnswers.length,
    physics: NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemBuilder: (context, index) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Card(
          elevation: 5,
          shadowColor: kShadowColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: ExpansionTile(
            title: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Container(
                    width: 30,
                    child: Image.asset('assets/api.png'),
                  ),
                ),
                Text(
                  DataInfor.questionAnswers[index]['question'],
                  style: kTitleTextStyle,
                ),
              ],
            ),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 25, bottom: 15),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    DataInfor.questionAnswers[index]['answer'],
                    style: kSubTextStyle.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}
