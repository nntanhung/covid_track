import 'dart:convert';
import 'dart:io';

import 'package:covid_track/youtube_screen/video_model.dart';

import 'youtube_model.dart';
import 'package:http/http.dart' as http;
import 'video_model.dart';

class APIService {
  APIService._instantiate();

  static final APIService instance = APIService._instantiate();

  final String _baseUrl = 'www.googleapis.com';
  String _nextPageToken = '';
  String apiKey = 'AIzaSyDdN27BPlWqASgg972-T6LRKm6TaQtPG0E';

  Future<Channel> fetchChannel({String channelId}) async {
    Map<String, String> parameters = {
      'part': 'snippet, contentDetails, statistics',
      'id': channelId,
      'key': apiKey,
    };

    Uri uri = Uri.https(
      _baseUrl,
      '/youtube/v3/channels',
      parameters,
    );
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body)['items'][0];
      Channel channel = Channel.fromMap(data);

      channel.videos = await fetchVideosFromPlaylist(
        playlistId: channel.uploadPlaylistId,
      );
      return channel;
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }

  Future<List<Video>> fetchVideosFromPlaylist({String playlistId}) async {
    Map<String, String> parameters = {
      'part': 'snippet',
      'playlistId': "PL1Vi4Nt_Cpb6q3onrLHLgi38Nmcpgbgp-",
      // 'playlistId': playlistId,
      'maxResults': '6',
      'pageToken': _nextPageToken,
      'key': apiKey,
    };
    Uri uri = Uri.https(
      _baseUrl,
      '/youtube/v3/playlistItems',
      parameters,
    );
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    // Get Playlist Videos
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      _nextPageToken = data['nextPageToken'] ?? '';
      List<dynamic> videosJson = data['items'];

      // Fetch first six videos from uploads playlist
      List<Video> videos = [];
      videosJson.forEach(
        (json) => videos.add(
          Video.fromMap(json['snippet']),
        ),
      );
      return videos;
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }
}
