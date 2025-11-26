import 'package:first_project/homework8/screens/to_do_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Homework8App());
}

class Homework8App extends StatelessWidget {
  const Homework8App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To-Do List',
      theme: ThemeData(
         colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      home: const ToDoScreen(),
    );
  }
}
