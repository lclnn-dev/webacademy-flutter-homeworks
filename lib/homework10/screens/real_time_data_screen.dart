import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

// class RealTimeDataApp extends StatelessWidget {
//   const RealTimeDataApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Real-Time Data',
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Імітація Real-Time data'),
//           centerTitle: true,
//         ),
//         body: const RealTimeDataScreen(),
//       ),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

class RealTimeDataScreen extends StatefulWidget {
  const RealTimeDataScreen({super.key});

  @override
  State<RealTimeDataScreen> createState() => _RealTimeDataScreenState();
}

class _RealTimeDataScreenState extends State<RealTimeDataScreen> {
  StreamController<int>? _streamController;
  StreamSubscription<int>? _subscription;

  bool get isRunning => _subscription != null;

  @override
  void dispose() {
    _streamController?.close();
    _subscription?.cancel();
    super.dispose();
  }

  Stream<int> generateRealTimeData() async* {
    final random = Random();

    while (true) {
      await Future.delayed(const Duration(seconds: 2));
      final value = random.nextInt(100) + 1;

      if (value > 90) {
        throw Exception('$value > 90');
      }
      yield value;
    }
  }

  void startStream() {
    if (_subscription != null) return;

    _streamController = StreamController<int>.broadcast();

    _subscription = generateRealTimeData().listen(
      (data) => _streamController!.add(data),
      onError: (error) {
        _streamController!.addError(error);
        _subscription?.cancel();
        _subscription = null;
        if (mounted) setState(() {});
      },
      onDone: () {
        _subscription = null;
        _streamController?.close();
        _streamController = null;
        if (mounted) setState(() {});
      },
    );

    setState(() {});
  }

  void stopStream() {
    _subscription?.cancel();
    _streamController?.close();
    _streamController = null;
    _subscription = null;
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Імітація Real-Time data'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _streamController == null
                ? const Text('Потік не запущено',
                    style: TextStyle(fontSize: 24))
                : StreamBuilder<int>(
                    stream: _streamController!.stream,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Column(
                          children: [
                            const Icon(Icons.error,
                                color: Colors.red, size: 64),
                            const SizedBox(height: 16),
                            Text(
                              '${snapshot.error}',
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        );
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }

                      if (snapshot.hasData) {
                        final value = snapshot.data!;
                        return Text('$value',
                            style: const TextStyle(
                                fontSize: 80, fontWeight: FontWeight.bold));
                      }

                      return const Text('Очікування даних...');
                    }),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: isRunning ? null : startStream,
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('Запустити'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                ),
                const SizedBox(width: 20),
                ElevatedButton.icon(
                  onPressed: isRunning ? stopStream : null,
                  icon: const Icon(Icons.stop),
                  label: const Text('Зупинити'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              isRunning ? 'Потік активний...' : '',
            ),
          ],
        ),
      ),
    );
  }
}
