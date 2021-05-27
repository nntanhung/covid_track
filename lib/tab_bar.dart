import 'package:covid_track/app_infor/info_app_screen.dart';
import 'package:covid_track/resources/consts.dart';
import 'package:covid_track/youtube_screen/youtube_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'home_screen/home_page.dart';
import 'infor_screen/infor_page.dart';
import 'news_screen/news_page.dart';

class TabBarPage extends StatefulWidget {
  @override
  _TabBarPageState createState() => _TabBarPageState();
}

class _TabBarPageState extends State<TabBarPage>
    with SingleTickerProviderStateMixin {
  TabController controller;
  int _selectedIndex = 0;
//  void _handleTap() {
//    setState(() {
//      _active = !_active;
//    });
//  }

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        // body: TabBarView(
        //   children: <Widget>[
        //     HomePage(),
        //     InfoPage(),
        //     NewsPage(),
        //     YouTubePage(),
        //     InforAppPage(),
        //   ],
        //   controller: controller,
        // ),
        body: IndexedStack(
          children: <Widget>[
            HomePage(),
            InfoPage(),
            NewsPage(),
            YouTubePage(),
            InforAppPage(),
          ],
          index: _selectedIndex,
        ),
        bottomNavigationBar: Material(
          child: TabBar(
            labelColor: kPrimaryColor,
            unselectedLabelColor: kShadowColor,
            tabs: <Widget>[
              Tab(
                icon: Icon(MdiIcons.virus, size: 25),
              ),
              Tab(icon: Icon(MaterialCommunityIcons.hospital, size: 35)),
              Tab(icon: Icon(Entypo.newsletter, size: 25)),
              Tab(icon: Icon(Entypo.youtube, size: 25)),
              Tab(icon: Icon(AntDesign.profile, size: 25)),
            ],
            // controller: controller,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
