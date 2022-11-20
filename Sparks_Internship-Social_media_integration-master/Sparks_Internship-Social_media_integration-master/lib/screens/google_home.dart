import 'package:flutter/material.dart';
import 'package:flutter_login_android/paint/background_painter.dart';
import 'package:flutter_login_android/screens/login.dart';
import 'package:flutter_login_android/screens/maindrawer.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'login.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleHome extends StatefulWidget {
  @override
  _GoogleHomeState createState() => _GoogleHomeState();
}

class _GoogleHomeState extends State<GoogleHome> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 2));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Google ID'),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
        drawer: Drawer(
          child: MainDrawer(),
        ),
        backgroundColor: Color(0xff161519),
        body: SizedBox.expand(
          child: CustomPaint(
            painter: BackgroundPainter(
              animation: _controller.view,
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(75, 0, 0, 0),
                    child: CircleAvatar(
                        radius: 70,
                        backgroundImage: NetworkImage(
                            'https://lh3.googleusercontent.com/ogw/ADGmqu-D9dInKuXyT-oVnHJ4e5HGBY4OwPZKp6glhdDjhg=s32-c-mo' +
                                '?width=500&500')),
                  ),
                  Divider(
                    color: Colors.white,
                    height: 100,
                    thickness: .5,
                    indent: 30,
                    endIndent: 30,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.person,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Name',
                        style: TextStyle(fontSize: 15, color: Colors.white, letterSpacing: 2.0),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Vikas Pradhan',
                    style: TextStyle(fontSize: 25, color: Colors.amberAccent[200], fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.mail_outline,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Email',
                        style: TextStyle(fontSize: 15, color: Colors.white, letterSpacing: 2.0),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'pradhanvikas11@gmail.com',
                    style: TextStyle(fontSize: 25, color: Colors.amberAccent[200], fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                    child: Hero(
                      tag: 'GoogleButton',
                      child: SignInButton(
                        Buttons.Google,
                        text: 'Sign out of Google',
                        onPressed: () {
                          _googleSignIn
                              .signOut()
                              .then((user) => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Login())));
                          _controller.forward(from: 0);
                        },
                        padding: EdgeInsets.symmetric(vertical: 2, horizontal: 2),
                      ),
                    ),
                  )
                ],
              )),
            ),
          ),
        ));
  }
}
