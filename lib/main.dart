import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:learning_tracker/providers/todo_provider.dart';
import 'package:learning_tracker/services/service_locator.dart';

import 'package:provider/provider.dart';
import 'package:learning_tracker/screen/Reading.dart';
import 'package:learning_tracker/screen/home.dart';
import 'package:learning_tracker/screen/login.dart';
import 'package:learning_tracker/screen/playlists.dart';
import 'package:learning_tracker/screen/videolist.dart';
import 'package:learning_tracker/screen/watching.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupLocator();
  runApp(MultiProvider(
    providers: [Provider<TodoStateModel>(create: (_) => TodoStateModel())],
    child: App(),
  ));
}

class App extends StatefulWidget {
  const App({Key key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  int _selectedIndex = 0;
  List<Widget> widgets = [Home(), Reading(), Playlist(), Login()];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: (setting) {
          var uri = Uri.parse(setting.name);
          if (uri.pathSegments.length == 2 &&
              uri.pathSegments.first == 'playlist') {
            var id = uri.pathSegments[1];
            return MaterialPageRoute(builder: (context) => VideoList(id: id));
          }

          if (setting.name == '/') {
            return MaterialPageRoute(builder: (context) => Home());
          } else if (setting.name == 'playlist') {
            return MaterialPageRoute(builder: (context) => Playlist());
          } else if (setting.name == 'watching') {
            return MaterialPageRoute(builder: (context) => Watching());
          } else if (setting.name == 'login') {
            return MaterialPageRoute(builder: (context) => Login());
          } else {
            return MaterialPageRoute(
                builder: (context) => Text('Unknown screen'));
          }
        },
        theme: ThemeData.light(),
        home: Container(
            child: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              User user = snapshot.data;
              if (user == null) {
                return Login();
              } else {
                return (Scaffold(
                  appBar: AppBar(
                    title: const Text('My Youtube'),
                  ),
                  body: widgets.elementAt(_selectedIndex),
                  bottomNavigationBar: BottomNavigationBar(
                    currentIndex: _selectedIndex,
                    type: BottomNavigationBarType.fixed,
                    items: const <BottomNavigationBarItem>[
                      BottomNavigationBarItem(
                        icon: Icon(Icons.home),
                        label: 'Home',
                        backgroundColor: Colors.blue,
                      ),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.book),
                          label: 'Reading',
                          backgroundColor: Colors.red),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.video_collection),
                          label: 'Playlist'),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.settings), label: 'Settings'),
                    ],
                    onTap: (index) => setState(() => _selectedIndex = index),
                  ),
                ));
              }
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        )),
      ),
    );
  }
}
