import 'package:covid_track/youtube_screen/servive_api.dart';
import 'package:covid_track/youtube_screen/video_model.dart';
import 'package:covid_track/youtube_screen/video_screen.dart';
import 'package:covid_track/youtube_screen/youtube_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../resources/consts.dart';

class YouTubePage extends StatefulWidget {
  @override
  _YouTubePageState createState() => _YouTubePageState();
}

class _YouTubePageState extends State<YouTubePage> {
  Channel _channel;
  bool _isLoading = false;
  GlobalKey<RefreshIndicatorState> _refreshKey;
  @override
  void initState() {
    super.initState();
    _refreshKey = GlobalKey<RefreshIndicatorState>();
    _initChannel();
  }

  _initChannel() async {
    Channel channel = await APIService.instance
        .fetchChannel(channelId: 'UCabsTV34JwALXKGMqHpvUiA');
    setState(() {
      _channel = channel;
    });
  }

  _loadMoreVideos() async {
    _isLoading = true;
    List<Video> moreVideos = await APIService.instance
        .fetchVideosFromPlaylist(playlistId: _channel.uploadPlaylistId);
    List<Video> allVideos = _channel.videos..addAll(moreVideos);
    setState(() {
      _channel.videos = allVideos;
    });
    _isLoading = false;
  }

  _buildVideo(Video video) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => VideoScreen(
            id: video.id,
            description: video.description,
            title: video.title,
            publishedAt: video.publishedAt,
            profilePictureUrl: _channel.profilePictureUrl,
          ),
        ),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  width: double.infinity,
                  height: 195.0,
                  child: FadeInImage.assetNetwork(
                    image: video.thumbnailUrl,
                    placeholder: "assets/loading.gif",
                    fit: BoxFit.cover,
                  )),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundColor: kShadowColor.withOpacity(0.3),
                          radius: 20.0,
                          backgroundImage:
                              NetworkImage(_channel.profilePictureUrl),
                        ),
                        SizedBox(width: 7),
                        Expanded(
                          child: Text(
                            video.title,
                            maxLines: 3,
                            // textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          DateFormat("HH:mm - dd/MM/yyyy")
                              .format(DateTime.parse(video.publishedAt)),
                          style: kSubTextStyle,
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Container(
                      child: Text(
                        " " + video.description,
                        // textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bản tin Covid-19'),
        backwardsCompatibility: false,
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarColor: Colors.transparent),
      ),
      // appBar: new PreferredSize(
      //   child: GradientAppBar("Bản tin Covid-19"),
      //   preferredSize: new Size(MediaQuery.of(context).size.width, 150.0),
      // ),

      body: _channel != null
          ? NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollDetails) {
                if (!_isLoading &&
                    _channel.videos.length != int.parse(_channel.videoCount) &&
                    scrollDetails.metrics.pixels ==
                        scrollDetails.metrics.maxScrollExtent) {
                  _loadMoreVideos();
                }

                return false;
              },
              child: RefreshIndicator(
                key: _refreshKey,
                onRefresh: () => _initChannel(),
                child: SafeArea(
                  child: ListView.builder(
                    itemCount: 1 + _channel.videos.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (index == 0) {
                        return Container();
                      }
                      Video video = _channel.videos[index - 1];
                      return _buildVideo(video);
                    },
                  ),
                ),
              ),
            )
          : Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).primaryColor,
                ),
              ),
            ),
    );
  }
}
