import 'package:flutter/material.dart';

import '../infor_screen/call.dart';
import '../resources/consts.dart';
import '../infor_screen/infor_item_images.dart';
import '../infor_screen/faqs.dart';
import '../data/list_data.dart';
import '../widgets/my_header.dart';

class InfoPage extends StatefulWidget {
  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  final controller = ScrollController();

  double offset = 8;

  @override
  void initState() {
    super.initState();
    controller.addListener(onScroll);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void onScroll() {
    setState(() {
      offset = (controller.hasClients) ? controller.offset : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: controller,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            MyHeader(
              image: "assets/icons/coronadr.svg",
              textTop: "Thông tin về\nCOVID-19",
              offset: offset,
            ),
            InfoItemImages(
              title: 'Triệu chứng',
              listDataInfors: symptoms,
            ),
            InfoItemImages(
              title: 'Nguồn lây nhiễm',
              listDataInfors: contagion,
            ),
            InfoItemImages(
              title: 'Phòng ngừa',
              listDataInfors: prevention,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 5),
              child: Column(
                children: <Widget>[
                  Text(
                    'Câu hỏi thường gặp',
                    style: kHeadingTextStyle,
                  ),
                  _faqsListView(),
                  const SizedBox(height: 25),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: callPhone,
        tooltip: 'Gọi ngay',
        child: new Icon(Icons.call),
      ),
    );
  }
}

Widget _faqsListView() {
  return ListView.builder(
    itemCount: DataSource.questionAnswers.length,
    physics: NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemBuilder: (context, index) {
      return Card(
        elevation: 2,
        shadowColor: kShadowColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: ExpansionTile(
          title: Text(
            "Hỏi: " + DataSource.questionAnswers[index]['question'],
            style: TextStyle(
              fontSize: 15,
              color: kTitleTextColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text.rich(
                TextSpan(
                  text: 'Trả lời: ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: DataSource.questionAnswers[index]['answer'],
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                        color: kBodyTextColor,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      );
    },
  );
}
