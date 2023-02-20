import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:socialmedia_sparks/profilepage.dart';
import 'package:socialmedia_sparks/routesGenerator.dart';
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoggedIn = false;

  void onLoginStatusChanged(bool isLoggedIn) {
    setState(() {
      this.isLoggedIn = isLoggedIn;
    });
  }
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
      final currentuser = await _googleSignIn.currentUser;
      final name = await currentuser!.displayName;
      final email = await currentuser!.email;
      final profilePicture = await currentuser.photoUrl;
      profile_key.currentState
          ?.pushNamed('/profile_page', arguments: [name.toString(), email.toString(),profilePicture.toString()]);
      setState(() {});
    }
    catch (error) {
      print(error);
    }
  }
  void initiateFacebookLogin() async {
    var facebookLogin = FacebookLogin();
    final profile = await facebookLogin.getUserProfile();
    var facebookLoginResult =
    await facebookLogin.logIn();
    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.error:
        onLoginStatusChanged(false);
        break;
      case FacebookLoginStatus.cancel:
        onLoginStatusChanged(false);
        break;
      case FacebookLoginStatus.success:
        onLoginStatusChanged(true);
        profile_key.currentState
            ?.pushNamed('/profile_page', arguments: [profile!.name.toString(), facebookLogin.getUserEmail().toString(), facebookLogin.getProfileImageUrl(width: 100).toString()]);
        setState(() {});
        (context) =>  ProfilePage(name: profile!.name.toString(), email: facebookLogin.getUserEmail().toString(), profilePicture: facebookLogin.getProfileImageUrl(width: 100).toString());
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(

          child: isLoggedIn
              ? Text("Logged In")
              : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Image.asset(
              'assets/images/logo.png',
              height: 200.0,
              width: 200.0,
            ),
            SizedBox(height: 40.0),
            Text(
              'Welcome!',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 40.0),
            ElevatedButton(
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                ),
              ),
              onPressed: _handleSignIn,
    style: ElevatedButton.styleFrom(
    primary: Colors.white30, // Background color
    shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(8.0),
    ))
    ),
            ElevatedButton(
              child: Text("Sign in with Facebook", style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),),
              onPressed: () => initiateFacebookLogin(),
                style: ElevatedButton.styleFrom(
                    primary: Colors.blueAccent, // Background color
                    shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(8.0),
                    ))

            ),
            ]),

          ),
        ),
        ),
      );
  }
}
