import 'package:flutter/material.dart';
import 'package:learning_tracker/services/service_locator.dart';
import 'package:learning_tracker/services/youtubeAPI.dart';

class VideoList extends StatefulWidget {
  final String id;
  VideoList({this.id, Key key}) : super(key: key);

  @override
  _VideoListState createState() => _VideoListState();
}

class _VideoListState extends State<VideoList> {
  Future<Map<String, dynamic>> _videos;

  @override
  void initState() {
    super.initState();
    _videos = getIt<YoutubeService>().videos(widget.id);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Playlist Name'),
      ),
      body: FutureBuilder(
        future: _videos,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
                child: ListView(
                    children:
                        List.generate(snapshot.data['items'].length, (index) {
              return GestureDetector(
                onTap: () {},
                child: Container(
                  child: Column(children: [
                    Text(
                      '${(snapshot.data["items"][index]['snippet'])["title"]}',
                      style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.normal),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          addToWatchlist((snapshot.data["items"][index]
                              ['snippet'])["title"]);
                        },
                        child: Text('Add'))
                  ]),
                  color: Colors.amber[100],
                  margin: const EdgeInsets.all(15),
                ),
              );
            })));
          } else if (snapshot.hasError) {
            return Text('Error Fetching Videos');
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  addToWatchlist(String w) {
    getIt<YoutubeService>().watchlist.add(w);
    print(getIt<YoutubeService>().watchlist);
  }
}
