import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login_android/services/auth_service.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';

class AuthBloc {
  final authService = AuthService();
  final fb = FacebookLogin();

  Stream<User> get currentUser => authService.currentUser;

  loginFacebook() async {
    print('Starting Facebook Login');

    final res = await fb.logIn(permissions: [FacebookPermission.publicProfile, FacebookPermission.email, FacebookPermission.userBirthday]);

    switch (res.status) {
      case FacebookLoginStatus.Success:
        print('It worked');

        //Get Token
        final FacebookAccessToken fbToken = res.accessToken;

        //Convert to Auth Credential
        final AuthCredential credential = FacebookAuthProvider.credential(res.accessToken.token);

        //User Credential to Sign in with Firebase
        final result = await authService.signInWithCredential(credential);

        print('${result.user.displayName} is now logged in');

        break;

      case FacebookLoginStatus.Cancel:
        print('User cancelled the Login');
        break;

      case FacebookLoginStatus.Error:
        print('An error occurred');
        break;
    }
  }

  logout() {
    authService.logout();
  }
}
