import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoScreen extends StatefulWidget {
  final String id;
  final String description;
  final String title;
  final String publishedAt;
  final String profilePictureUrl;

  VideoScreen(
      {this.id,
      this.description,
      this.title,
      this.publishedAt,
      this.profilePictureUrl});

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.id,
      flags: YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        backwardsCompatibility: false,
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarColor: Colors.transparent),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
                onReady: () {
                  print('Player is ready.');
                },
              ),
              _buildScreenView(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScreenView() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      child: Column(
        children: <Widget>[
          Text(
            widget.title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Container(
            padding: const EdgeInsets.only(top: 3),
            alignment: Alignment.centerLeft,
            child: Text(
              "Xu???t b???n: " +
                  DateFormat("HH:mm - dd/MM/yyyy")
                      .format(DateTime.parse(widget.publishedAt)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Text(
              widget.description,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
          )
        ],
      ),
    );
  }
}
