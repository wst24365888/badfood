import 'package:firebase_auth/firebase_auth.dart';

Future<UserCredential> signInWithGoogle() async {
  // Create a new provider
  final GoogleAuthProvider googleProvider = GoogleAuthProvider();

  googleProvider.addScope('https://www.googleapis.com/auth/contacts.readonly');
  googleProvider.setCustomParameters({'login_hint': 'user@example.com'});

  // Once signed in, return the UserCredential
  return FirebaseAuth.instance.signInWithPopup(googleProvider);
}
