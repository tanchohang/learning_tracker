import 'package:flutter/material.dart';
import 'package:learning_tracker/screen/todo_view.dart';

import 'package:learning_tracker/screen/watching.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: PreferredSize(
              child: Container(
                color: Colors.blue,
                child: TabBar(
                  tabs: [
                    Tab(icon: Icon(Icons.note_add)),
                    Tab(icon: Icon(Icons.video_collection_sharp)),
                    Tab(icon: Icon(Icons.book_online_rounded))
                  ],
                ),
              ),
              preferredSize: Size.fromHeight(kToolbarHeight)),
          body: TabBarView(
            children: [Todo(), Watching(), Text('Reading list')],
          ),
        ),
      ),
    );
  }
}
