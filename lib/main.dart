import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'homework10/homework_10_screen.dart';
import 'homework11/homework11_screen.dart';
import 'homework12/homework12_screen.dart';
import 'homework12/providers/auth_provider.dart';
import 'homework12/repositories/habits_repository.dart';
import 'homework12/repositories/habits_repository_impl.dart';
import 'homework12/services/habits_service.dart';
import 'theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppAuthProvider()),
        Provider<HabitsRepository>(
          create: (_) => HabitsRepositoryImpl(),
        ),
        Provider<HabitsService>(
          create: (context) => HabitsService(
            repository: context.read<HabitsRepository>(),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

const String hw10 = '/homework_10';
const String hw11 = '/homework_11';
const String hw12 = '/homework_12';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final _textTheme = Typography.material2021().black;
  static final MaterialTheme _theme = MaterialTheme(_textTheme);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Homeworks',
      theme: _theme.dark(),
      darkTheme: _theme.dark(),
      themeMode: ThemeMode.dark,
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
      routes: {
        hw10: (_) => const Homework10Screen(),
        hw11: (_) => const Homework11Screen(),
        hw12: (_) => const Homework12Screen(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const List<Map<String, String>> tasks = [
    {'title': 'Homework 10 — Async', 'route': hw10},
    {'title': 'Homework 11 — Posts & Comments', 'route': hw11},
    {'title': 'Homework 12 — Habits', 'route': hw12},
    // ...
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Homeworks')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            final task = tasks[index];
            return TaskButton(title: task['title']!, route: task['route']!);
          },
        ),
      ),
    );
  }
}

class TaskButton extends StatelessWidget {
  final String title;
  final String route;

  const TaskButton({super.key, required this.title, required this.route});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      child: ElevatedButton(
        onPressed: () => Navigator.pushNamed(context, route),
        style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(18)),
        child: Text(title, style: const TextStyle(fontSize: 18)),
      ),
    );
  }
}
