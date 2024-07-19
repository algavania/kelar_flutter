import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DbConstants {
  static final db = FirebaseFirestore.instance;
  static final auth = FirebaseAuth.instance;

  static const users = 'users';
  static const sensors = 'sensors';
}
