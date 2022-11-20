import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_android/blocs/auth_bloc.dart';
import 'package:flutter_login_android/screens/login.dart';
import 'package:provider/provider.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => AuthBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Facebook login',
        // darkTheme: ThemeData.dark(),
        theme: ThemeData(
          // brightness: Brightness.dark,
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: AnimatedSplashScreen(
          splashIconSize: 300,
          animationDuration: Duration(milliseconds: 200),
          splash: Image.asset('lib/assets/giphy.gif'),
          splashTransition: SplashTransition.fadeTransition,
          backgroundColor: Color(0xff161519),
          nextScreen: Login(),
        ),
      ),
    );
  }
}
