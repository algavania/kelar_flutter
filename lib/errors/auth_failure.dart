import 'package:firebase_auth/firebase_auth.dart';
import 'package:kelar_flutter/errors/failures.dart';

class AuthFailure extends FirebaseAuthException {
  AuthFailure(String code, String message)
      : super(code: code, message: message) {
    switch (code) {
      case 'user-not-found':
        throw Failure('User not found');
      case 'wrong-password':
        throw Failure('Wrong password');
      default:
        throw Failure(message);
    }
  }
}
