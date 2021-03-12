import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:learning_tracker/services/auth.dart';
import 'package:learning_tracker/services/service_locator.dart';
import '../models/playlist.dart';

class YoutubeService {
  // final String _baseUrl = 'www.googleapis.com/';
  List<String> watchlist = [];

  Future<PlaylistM> playlist(String pageToken) async {
    String token = getIt<AuthService>().token;
    Uri uri = Uri.parse(
        "https://youtube.googleapis.com/youtube/v3/playlists?part=snippet&pageToken=$pageToken&mine=true&access_token=$token");
    final res = await http.get(uri);
    if (res.statusCode == 200) {
      return PlaylistM.fromJson(jsonDecode(res.body));
    } else {
      throw Exception('failed to fetch playlists');
    }
  }

  Future<Map<String, dynamic>> videos(String playlistId) async {
    String token = getIt<AuthService>().token;
    Uri uri = Uri.parse(
        "https://youtube.googleapis.com/youtube/v3/playlistItems?part=snippet&playlistId=$playlistId&mine=true&access_token=$token");
    final res = await http.get(uri);
    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      throw Exception('failed to fetch playlists');
    }
  }
}
