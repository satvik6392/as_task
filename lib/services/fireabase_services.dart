import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServices{
Future<UserCredential?> signUpWithEmailPassword(String email, String password) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    print(userCredential);
    return userCredential;
  } catch (e) {
    print('coming here--->${e.toString()}');
    print(e.toString());
    return null;
  }
}

Future<UserCredential?> signInWithEmailPassword(String email, String password) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential;
  } catch (e) {
     print('coming here--->${e.toString()}');
    print(e.toString());
    return null;
  }
}

/// password reset
Future<dynamic> sendPasswordResetEmail(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      print('Password reset email sent');
      return true;
    } catch (e) {
      print('Error sending password reset email: ${e.toString()}');
      return null;
      
      // throw e;
    }
  }

}

