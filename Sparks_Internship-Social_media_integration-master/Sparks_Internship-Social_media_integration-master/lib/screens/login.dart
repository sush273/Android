import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_android/blocs/auth_bloc.dart';
import 'package:flutter_login_android/paint/background_painter.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:provider/provider.dart';
import 'google_home.dart';
import 'home.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:url_launcher/url_launcher.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  double _widthF = 200.0;
  double _heightF = 30.0;

  double _widthG = 200.0;
  double _heightG = 30.0;

  void _updateStateGoogle() {
    setState(() {
      _widthG = 250.0;
      _heightG = 50.0;
    });
  }

  void _updateStateFacebook() {
    setState(() {
      _widthF = 250.0;
      _heightF = 50.0;
    });
  }

  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  _login() async {
    try {
      await _googleSignIn.signIn();
      setState(() {});
    } catch (err) {
      print(err);
    }
  }

  logout() {
    _googleSignIn.signOut();
    setState(() {});
  }

  StreamSubscription<User> loginStateSubscription;
  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 2));
    var authBloc = Provider.of<AuthBloc>(context, listen: false);
    loginStateSubscription = authBloc.currentUser.listen((fbUser) {
      if (fbUser != null) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Home()));
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    loginStateSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int pressTimes = 2;
    var authBloc = Provider.of<AuthBloc>(context);
    return Scaffold(
      backgroundColor: Color(0xff161519),
      body: SizedBox.expand(
        child: CustomPaint(
          painter: BackgroundPainter(
            animation: _controller.view,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                  child: Text(
                    'Sign in',
                    style: TextStyle(color: Colors.white, fontSize: 70, fontWeight: FontWeight.w200),
                  ),
                ),
                Divider(
                  color: Colors.white,
                  height: 100,
                  thickness: .5,
                  indent: 30,
                  endIndent: 30,
                ),
                AnimatedContainer(
                  width: _widthF,
                  height: _heightF,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.bounceOut,
                  child: SignInButton(
                    Buttons.Facebook,
                    onPressed: () {
                      authBloc.loginFacebook();
                      _updateStateFacebook();
                      _controller.forward(from: 0);
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                AnimatedContainer(
                  width: _widthG,
                  height: _heightG,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.bounceOut,
                  color: Colors.blueAccent,
                  child: Hero(
                    tag: 'GoogleButton',
                    child: SignInButton(
                      Buttons.GoogleDark,
                      onPressed: () {
                        _login()
                            .then((user) => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => GoogleHome())));
                        _updateStateGoogle();
                        _controller.forward(from: 0);
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: Image(
          image: NetworkImage('https://www.thesparksfoundationsingapore.org/images/logo_small.png', scale: 0.1),
        ),
        onPressed: () {
          openURL();
          if (pressTimes % 2 == 0) {
            _controller.forward(from: 0);
          } else {
            _controller.reverse();
          }
          setState(() {
            pressTimes = pressTimes + 1;
          });
        },
        highlightElevation: 3,
      ),
    );
  }

  openURL() {
    String url = "https://www.linkedin.com/company/the-sparks-foundation/";
    launch(url);
  }
}
