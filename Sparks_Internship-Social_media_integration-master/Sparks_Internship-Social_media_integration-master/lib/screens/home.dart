import 'dart:async';
import 'package:flutter_login_android/paint/blue_painter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_android/blocs/auth_bloc.dart';
import 'package:flutter_login_android/screens/maindrawer.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:provider/provider.dart';

import 'login.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  StreamSubscription<User> homeStateSubscription;

  @override
  void initState() {
    var authBloc = Provider.of<AuthBloc>(context, listen: false);
    homeStateSubscription = authBloc.currentUser.listen((fbUser) {
      if (fbUser == null) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Login()));
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    homeStateSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var authBloc = Provider.of<AuthBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Facebook ID'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      drawer: Drawer(
        child: MainDrawer(),
      ),
      backgroundColor: Color(0xff161519),
      body: CustomPaint(
        painter: BluePainter(),
        child: Center(
          child: StreamBuilder<User>(
              stream: authBloc.currentUser,
              builder: (context, snapshot) {
                if (!snapshot.hasData) return CircularProgressIndicator();
                return Padding(
                  padding: const EdgeInsets.fromLTRB(10, 30, 0, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(100, 0, 0, 0),
                        child: CircleAvatar(radius: 70, backgroundImage: NetworkImage(snapshot.data.photoURL + '?width=500&500')),
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
                        snapshot.data.displayName,
                        style: TextStyle(fontSize: 25, color: Colors.amberAccent[200]),
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
                        snapshot.data.email,
                        style: TextStyle(fontSize: 20, color: Colors.amberAccent[200]),
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(60, 0, 0, 0),
                        child: SignInButton(
                          Buttons.Facebook,
                          text: 'Sign out of Facebook',
                          onPressed: () {
                            authBloc.logout();
                          },
                          padding: EdgeInsets.symmetric(vertical: 2, horizontal: 2),
                        ),
                      )
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}
