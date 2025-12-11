import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:first_project/homework12/screens/login_screen.dart';
import 'package:first_project/homework12/screens/habits_screen.dart';

class Homework12Screen extends StatelessWidget {
  const Homework12Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          final user = snapshot.data;
          return user == null ? const LoginScreen() : const HabitsScreen();
        },
      ),
    );
  }
}
