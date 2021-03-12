import 'package:flutter/material.dart';
import 'package:learning_tracker/models/playlist.dart';
import 'package:learning_tracker/services/service_locator.dart';
import 'package:learning_tracker/services/youtubeAPI.dart';

class Playlist extends StatefulWidget {
  Playlist({Key key}) : super(key: key);

  @override
  _PlaylistState createState() => _PlaylistState();
}

class _PlaylistState extends State<Playlist> {
  Future<PlaylistM> _playlists;

  @override
  void initState() {
    super.initState();
    // getIt<YoutubeService>().playlist();
    _playlists = getIt<YoutubeService>().playlist("");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: FutureBuilder(
        future: _playlists,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                Container(
                  child: GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 3,
                      children:
                          List.generate(snapshot.data.items.length, (index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context,
                                'playlist/${snapshot.data.items[index].id}');
                          },
                          child: Container(
                            child: Center(
                              child: Text(
                                '${snapshot.data.items[index].snippet.title}',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                            color: Colors.amber[100],
                            margin: const EdgeInsets.all(15),
                          ),
                        );
                      })),
                ),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _playlists = getIt<YoutubeService>()
                            .playlist('${snapshot.data.nextPageToken}');
                      });
                    },
                    child: Text('Load more')),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _playlists = getIt<YoutubeService>()
                            .playlist('${snapshot.data.prevPageToken}');
                      });
                    },
                    child: Text('Prev'))
              ],
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
