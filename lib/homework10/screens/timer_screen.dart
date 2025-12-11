import 'dart:async';
import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Зворотний відлік 10 секунд'),
        centerTitle: true,
      ),
      body: Center(
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
                style:
                    const TextStyle(fontSize: 80, fontWeight: FontWeight.bold),
              );
            }

            return const Text('Стрім завершено без даних');
          },
        ),
      ),
    );
  }
}
