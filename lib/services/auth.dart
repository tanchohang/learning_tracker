import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  String token;
  GoogleSignInAuthentication googleAuth;
  Future<UserCredential> signIn() async {
    final GoogleSignInAccount googleSignInAccount =
        await GoogleSignIn(scopes: ['https://www.googleapis.com/auth/youtube'])
            .signIn();

    GoogleSignInAuthentication googleAuth =
        await googleSignInAccount.authentication;

    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
    token = googleAuth.accessToken;

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<UserCredential> signInAnonymously() async {
    return await FirebaseAuth.instance.signInAnonymously();
  }

  void signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
