import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learning_tracker/services/auth.dart';
import 'package:learning_tracker/services/service_locator.dart';

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MaterialButton(
              onPressed: () async {
                UserCredential user = await getIt<AuthService>().signIn();
                print(user.user.displayName);
              },
              child: Text('Sign In'),
              color: Colors.blue[600],
              textColor: Colors.white,
            ),
            MaterialButton(
              onPressed: () async {
                UserCredential user =
                    await getIt<AuthService>().signInAnonymously();
                print(user.user.uid);
              },
              child: Text('Sign In Anonymously'),
              color: Colors.blue[600],
              textColor: Colors.white,
            ),
            MaterialButton(
              onPressed: () => getIt<AuthService>().signOut(),
              child: Text('Logout'),
              color: Colors.red[400],
              textColor: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
