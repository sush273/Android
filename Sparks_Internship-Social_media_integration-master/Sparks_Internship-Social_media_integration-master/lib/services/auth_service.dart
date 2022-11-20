import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  // ignore: deprecated_member_use
  Stream<User> get currentUser => _auth.onAuthStateChanged;
  Future<UserCredential> signInWithCredential(AuthCredential credential) => _auth.signInWithCredential(credential);
  Future<void> logout() => _auth.signOut();
}
