import 'package:flutter/material.dart';
import 'package:flutter_login_android/screens/covid.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        child: Padding(
          padding: EdgeInsets.only(top: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50.0,
                backgroundImage: NetworkImage(
                  "https://media-exp1.licdn.com/dms/image/C4E03AQGQ7ngewCtTLw/profile-displayphoto-shrink_200_200/0/1580387893314?e=1613606400&v=beta&t=nZVjbMgOKvNBlC5rJOZyyb5Wm6ZFXxS5-sYU_L0TTPE",
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                "Vikas Pradhan",
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                "Intern at Sparks Foundation",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
      SizedBox(
        height: 20.0,
      ),
      //Now let's Add the button for the Menu
      //and let's copy that and modify it
      ListTile(
        onTap: () {
          openURLFlutter();
        },
        leading: Icon(
          FontAwesomeIcons.dev,
          color: Colors.blue,
        ),
        title: Text("Developed with Flutter"),
      ),

      ListTile(
        onTap: () {
          openURLGit();
        },
        leading: Icon(
          FontAwesomeIcons.github,
          color: Colors.black,
        ),
        title: Text("Source Code"),
      ),

      ListTile(
        onTap: () {
          openURL();
        },
        leading: Icon(
          FontAwesomeIcons.linkedin,
          color: Colors.blueAccent,
        ),
        title: Text("Contact me"),
      ),

      ListTile(
        onTap: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Covid()));
        },
        leading: Icon(
          FontAwesomeIcons.hospital,
          color: Colors.red,
        ),
        title: Text("Covid-19 tracker"),
      ),

      ListTile(
        onTap: () {
          openURLApp();
        },
        leading: Icon(
          FontAwesomeIcons.googlePlay,
          color: Colors.green,
        ),
        title: Text("My other apps"),
      ),
    ]);
  }

  openURL() {
    String url = "https://in.linkedin.com/in/vikas-pradhan-80088a1a0";
    launch(url);
  }

  openURLGit() {
    String url = "https://github.com/VRedBull/flutter_android_login";
    launch(url);
  }

  openURLFlutter() {
    String url = "https://flutter.dev/";
    launch(url);
  }

  openURLApp() {
    String url = "https://play.google.com/store/apps/details?id=com.vikas.photo_calendar";
    launch(url);
  }
}
