import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthServices {
  Future<bool> loginWithEmailAndPassword(String email, String password);
  Future<bool> registerWithEmailAndPassword(String email, String password);
  Future<bool> loginWithGoogle();
  User? user();
  Future<void> logout();
}

class AuthServicesImpl implements AuthServices {
  final _firebaseAuth = FirebaseAuth.instance;
  final _googleAuth = GoogleSignIn.instance;

  @override
  Future<bool> loginWithEmailAndPassword(String email, String password) async {
    final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = userCredential.user;
    if (user != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> registerWithEmailAndPassword(
    String email,
    String password,
  ) async {
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = userCredential.user;
    if (user != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  User? user() {
    return _firebaseAuth.currentUser;
  }

  @override
  Future<void> logout() async {
    await _firebaseAuth.signOut();
    await _googleAuth.signOut();
  }

  @override
  Future<bool> loginWithGoogle() async {
    try {
      await _googleAuth.initialize();
      final GoogleSignInAccount gUser = await _googleAuth.authenticate();
      final gAuth = gUser.authentication;
      if (gAuth.idToken == null) return false;
      final credential = GoogleAuthProvider.credential(
        idToken: gAuth.idToken,
      );
      final userCredential = await _firebaseAuth.signInWithCredential(
        credential,
      );
      return userCredential.user != null;
    } catch (e) {
      return false;
    }

    // final gUser = await GoogleSignIn().signIn();
    // final gAuth = await gUser?.authentication;
    // final credential = GoogleAuthProvider.credential(
    //   accessToken: gAuth?.accessToken,
    //   idToken: gAuth?.idToken, );
    // final userCredential = await _firebaseAuth.signInWithCredential(credential);
    // if (userCredential.user != null) {
    //   return true;
    // } else {
    //   return false;
    // }
  }
}
