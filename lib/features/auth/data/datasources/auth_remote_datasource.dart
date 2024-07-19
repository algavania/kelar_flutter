import 'package:firebase_auth/firebase_auth.dart';
import 'package:kelar_flutter/core/shared_data.dart';
import 'package:kelar_flutter/database/db_constants.dart';
import 'package:kelar_flutter/errors/auth_failure.dart';
import 'package:kelar_flutter/errors/failures.dart';
import 'package:kelar_flutter/features/auth/data/models/user_model.dart';
import 'package:kelar_flutter/utils/shared_preferences_util.dart';

abstract class AuthRemoteDataSource {
  Future<void> login(String email, String password);

  Future<void> register(UserModel user);

  Future<void> logout();
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  @override
  Future<void> login(String email, String password) async {
    try {
      final res = await DbConstants.auth
          .signInWithEmailAndPassword(email: email, password: password);
      final snapshot = await DbConstants.db
          .collection(DbConstants.users)
          .doc(res.user!.uid)
          .get();
      final user = UserModel.fromJson(snapshot.data()!);
      SharedData.user = user;
      await SharedPreferencesUtil.setUserData(user);
    } on FirebaseAuthException catch (e) {
      throw AuthFailure(e.code, e.message ?? 'Error');
    }
  }

  @override
  Future<void> register(UserModel user) async {
    try {
      if (user.password == null) throw Failure('Password is empty');
      final res = await DbConstants.auth.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password!,
      );
      await res.user?.updateDisplayName(user.name);
      await DbConstants.db.collection(DbConstants.users).doc(res.user!.uid).set(
            user.toJson(),
          );
      await DbConstants.auth.signOut();
    } on FirebaseAuthException catch (e) {
      throw AuthFailure(e.code, e.message ?? 'Error');
    }
  }

  @override
  Future<void> logout() async {
    await DbConstants.auth.signOut();
    await SharedPreferencesUtil.clearAllPrefs();
  }
}
