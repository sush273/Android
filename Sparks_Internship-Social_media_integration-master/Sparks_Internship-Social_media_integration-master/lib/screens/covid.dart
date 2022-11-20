import 'package:flutter/material.dart';
import 'package:flutter_login_android/screens/login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Covid extends StatefulWidget {
  @override
  _CovidState createState() => _CovidState();
}

class _CovidState extends State<Covid> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Covid-19 tracker'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Login()));
        },
        child: Icon(FontAwesomeIcons.home),
        backgroundColor: Colors.black,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: WebView(
          javascriptMode: JavascriptMode.unrestricted,
          // initialUrl: 'https://www.bing.com/covid/local/india?form=C19ANS',
          // initialUrl: 'https://www.youtube.com/',
          initialUrl: 'https://www.worldometers.info/coronavirus/',
        ),
      ),
    );
  }
}
