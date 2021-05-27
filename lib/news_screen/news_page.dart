import 'package:cached_network_image/cached_network_image.dart';
import 'package:covid_track/resources/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webfeed/webfeed.dart';

class NewsPage extends StatefulWidget {
  @override
  NewsPageState createState() => NewsPageState();
}

class NewsPageState extends State<NewsPage> {
  static const String FEED_URL = 'https://vietnamnet.vn/rss/covid-19.rss';
  // 'https://dantri.com.vn/suc-khoe/dai-dich-covid-19.rss';

  RssFeed _feed;
  String _title;
  static const String loadingFeedMsg = 'Đang tải trang...';
  static const String feedLoadErrorMsg = 'Không thể tải trang';
  static const String feedOpenErrorMsg = 'Không thể mở liên kết';
  static const String placeholderImg = 'assets/no_image.png';
  GlobalKey<RefreshIndicatorState> _refreshKey;

  updateTitle(title) {
    setState(() {
      _title = title;
    });
  }

  updateFeed(feed) {
    setState(() {
      _feed = feed;
    });
  }

  Future<void> openFeed(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: false,
      );
      return;
    }
    updateTitle(feedOpenErrorMsg);
  }

  load() async {
    updateTitle(loadingFeedMsg);
    loadFeed().then((result) {
      if (null == result || result.toString().isEmpty) {
        updateTitle(feedLoadErrorMsg);
        return;
      }
      updateFeed(result);
      updateTitle(_feed.title);
    });
  }

  Future<RssFeed> loadFeed() async {
    try {
      final client = http.Client();
      final response = await client.get(FEED_URL);
      return RssFeed.parse(response.body);
    } catch (e) {}
    return null;
  }

  @override
  void initState() {
    super.initState();
    _refreshKey = GlobalKey<RefreshIndicatorState>();
    load();
  }

  title(title) {
    return Text(
      title,
      style: TextStyle(fontSize: 16.5, fontWeight: FontWeight.w500),
      maxLines: 2,
      overflow: TextOverflow.clip,
    );
  }

  subtitle(subTitle) {
    return Text(
      DateFormat("HH:mm - dd/MM/yyyy").format((subTitle)),
      // subTitle,
      style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400),
      overflow: TextOverflow.ellipsis,
    );
  }

  description(desCription) {
    return Text(
      desCription,
      // subTitle,
      style: TextStyle(
          fontSize: 14.5, fontWeight: FontWeight.w500, color: kTitleTextColor),
      maxLines: 4,
      overflow: TextOverflow.ellipsis,
    );
  }

  thumbnail(imageUrl) {
    return Padding(
      padding: EdgeInsets.only(left: 15.0),
      child: CachedNetworkImage(
        placeholder: (context, url) => Image.asset(placeholderImg),
        imageUrl: imageUrl,
        height: 50,
        width: 70,
        alignment: Alignment.center,
        fit: BoxFit.fill,
      ),
    );
  }

  rightIcon() {
    return Icon(
      Icons.touch_app_outlined,
      color: Colors.grey,
      size: 25.0,
    );
  }

  list() {
    return ListView.builder(
      itemCount: _feed.items.length,
      itemBuilder: (BuildContext context, int index) {
        final item = _feed.items[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 5),
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: ListTile(
                title: title(item.title),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: subtitle(item.pubDate),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: description(item.description),
                    ),
                  ],
                ),
                leading: Container(
                    padding: EdgeInsets.only(left: 8),
                    child: Image.asset("assets/no_image.png")),
                contentPadding: EdgeInsets.all(5.0),
                onTap: () => openFeed(item.link),
              ),
            ),
          ),
        );
      },
    );
  }

  isFeedEmpty() {
    return null == _feed || null == _feed.items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
        backwardsCompatibility: false,
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarColor: Colors.transparent),
      ),

      // appBar: new PreferredSize(
      //   child: GradientAppBar(_title),
      //   preferredSize: new Size(MediaQuery.of(context).size.width, 150.0),
      // ),
      body: isFeedEmpty()
          ? Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              key: _refreshKey,
              child: list(),
              onRefresh: () => load(),
            ),
    );
  }
}
