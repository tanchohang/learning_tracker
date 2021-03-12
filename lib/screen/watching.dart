import 'package:flutter/material.dart';
import 'package:learning_tracker/services/service_locator.dart';
import 'package:learning_tracker/services/youtubeAPI.dart';

class Watching extends StatefulWidget {
  Watching({Key key}) : super(key: key);

  @override
  _WatchingState createState() => _WatchingState();
}

class _WatchingState extends State<Watching> {
  List<String> watchlist;
  @override
  void initState() {
    super.initState();
    watchlist = getIt<YoutubeService>().watchlist;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView.builder(
            itemCount: watchlist.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('${watchlist[index]}'),
              );
            }));
  }
}
