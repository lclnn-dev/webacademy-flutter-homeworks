import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const TimerApp());
}

class TimerApp extends StatelessWidget {
  const TimerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Таймер',
      home: Scaffold(
        appBar: AppBar(
            centerTitle: true, title: const Text('Зворотний відлік 10 секунд')),
        body: const TimerScreen(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TimerScreen extends StatelessWidget {
  const TimerScreen({super.key});

  Stream<int> countdownTimer() async* {
    for (int i = 10; i >= 0; i--) {
      await Future.delayed(const Duration(seconds: 1));
      yield i;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: StreamBuilder<int>(
        stream: countdownTimer(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error, color: Colors.red, size: 64),
                const SizedBox(height: 16),
                Text(
                  '${snapshot.error}',
                  style: const TextStyle(fontSize: 18, color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ],
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          if (snapshot.hasData) {
            if (snapshot.data == 0) {
              return const Text(
                'Таймер завершено!',
                style: TextStyle(fontSize: 28),
              );
            }

            return Text(
              '${snapshot.data}',
              style: const TextStyle(fontSize: 80, fontWeight: FontWeight.bold),
            );
          }

          return const Text('Стрім завершено без даних');
        },
      ),
    );
  }
}
