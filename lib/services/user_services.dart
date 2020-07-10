import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserServices {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final FacebookLogin _facebookLogin;

  UserServices({
    FirebaseAuth firebaseAuth,
    GoogleSignIn googleSignIn,
    FacebookLogin facebookLogin,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn(),
        _facebookLogin = facebookLogin ?? FacebookLogin();

  Future<FirebaseUser> signInWithGoogle() async {
    final GoogleSignInAccount googleAccount = await _googleSignIn.signIn();

    final GoogleSignInAuthentication googleAuthentication =
        await googleAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      idToken: googleAuthentication.idToken,
      accessToken: googleAuthentication.accessToken,
    );

    await _firebaseAuth.signInWithCredential(credential);
    return _firebaseAuth.currentUser();
  }

  Future<FirebaseUser> signInWithFacebook() async {
    FacebookLoginResult result = await _facebookLogin.logIn(['email']);

    var token = result.accessToken.token;
    var credential = FacebookAuthProvider.getCredential(accessToken: token);
    await _firebaseAuth.signInWithCredential(credential);
    return _firebaseAuth.currentUser();
  }

  Future<void> signInWithCredentials({
    String email,
    String password,
  }) async {
    return await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signUp({
    String email,
    String password,
  }) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    return Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),
      _facebookLogin.logOut(),
    ]);
  }

  Future<bool> isSignedIn() async {
    final currentUser = await _firebaseAuth.currentUser();
    return currentUser != null;
  }

  Future<String> getUser() async {
    return (await _firebaseAuth.currentUser()).email;
  }
}
