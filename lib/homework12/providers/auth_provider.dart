import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppAuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? emailError;
  String? passwordError;
  String? firebaseError;

  void clearErrors() {
    emailError = null;
    passwordError = null;
    firebaseError = null;
    notifyListeners();
  }

  bool validateEmail(String email) {
    if (email.isEmpty) {
      emailError = "Email не може бути порожнім";
      return false;
    }

    if (!email.contains("@") || !email.contains(".")) {
      emailError = "Некоректний email";
      return false;
    }

    emailError = null;
    return true;
  }

  bool validatePassword(String pass) {
    if (pass.isEmpty) {
      passwordError = "Пароль не може бути порожнім";
      return false;
    }

    passwordError = null;
    return true;
  }

  Future<User?> login(String email, String password) async {
    if (!validateEmail(email) | !validatePassword(password)) {
      notifyListeners();
      return null;
    }

    try {
      final res = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return res.user;
    } on FirebaseAuthException catch (e) {
      firebaseError = _mapFirebaseError(e);
      notifyListeners();
      return null;
    }
  }

  Future<User?> register(String email, String password) async {
    if (!validateEmail(email) | !validatePassword(password)) {
      notifyListeners();
      return null;
    }

    try {
      final res = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return res.user;
    } on FirebaseAuthException catch (e) {
      firebaseError = _mapFirebaseError(e);
      notifyListeners();
      return null;
    }
  }

  Future<void> logout() async => _auth.signOut();

  String _mapFirebaseError(FirebaseAuthException e) {
    switch (e.code) {
      case "email-already-in-use":
        return "Цей email вже зареєстрований";
      case "invalid-credential":
        return "Невірний пароль чи логін";
      case "weak-password":
        return "Пароль має містити щонайменше 6 символів";

      default:
        return "Помилка: ${e.message}";
    }
  }
}
