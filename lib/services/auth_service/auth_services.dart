import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  static const String _accountsListKey = "saved_accounts_list";

  Future<User?> signUp(String email, String password) async {
    UserCredential userCred = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    await _savePassword(email, password);
    await _addAccountToList(email);
    return userCred.user;
  }

  Future<User?> signIn(String email, String password) async {
    UserCredential userCred = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    await _savePassword(email, password);
    await _addAccountToList(email);
    return userCred.user;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  User? get currentUser => _auth.currentUser;

  Future<void> _savePassword(String email, String password) async {
    await _storage.write(key: "password_$email", value: password);
  }

  Future<String?> getPassword(String email) async {
    return _storage.read(key: "password_$email");
  }

  Future<void> _addAccountToList(String email) async {
    final accounts = await getSavedAccounts();
    if (!accounts.contains(email)) {
      accounts.add(email);
      await _storage.write(key: _accountsListKey, value: accounts.join(","));
    }
  }

  Future<List<String>> getSavedAccounts() async {
    final raw = await _storage.read(key: _accountsListKey);
    if (raw == null || raw.isEmpty) return [];
    return raw.split(",");
  }

  Future<User?> switchAccount(String email, String password) async {
    await signOut();
    return await signIn(email, password);
  }

  Future<void> removeAccount(String email) async {
    await _storage.delete(key: "password_$email");
    final accounts = await getSavedAccounts();
    debugPrint("Account");
    accounts.remove(email);
    await _storage.write(key: _accountsListKey, value: accounts.join(","));
  }


  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn.instance;

      final GoogleSignInAccount googleUser =
      await googleSignIn.authenticate();

      final GoogleSignInAuthentication googleAuth =
          googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      final userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);
      await _addAccountToList(googleUser.email);

      return userCredential.user;
    } on GoogleSignInException catch (e) {
      if (e.code == GoogleSignInExceptionCode.canceled) {
        return null;
      }
      throw Exception("Google Sign-In failed: ${e.description ?? e.code}");
    } on FirebaseAuthException catch (e) {
      throw Exception("Firebase error: ${e.message}");
    } catch (e) {
      throw Exception("Google Sign-In failed: $e");
    }
  }

}