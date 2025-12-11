import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class ApiAsyncScreen extends StatefulWidget {
  const ApiAsyncScreen({super.key});

  @override
  State<ApiAsyncScreen> createState() => _ApiScreenState();
}

class _ApiScreenState extends State<ApiAsyncScreen> {
  final List<String> _logs = [];
  bool _isLoading = false;

  void _addLog(String message) {
    setState(() {
      _logs.add('[${DateTime.now().toString().substring(11, 19)}] $message');
    });
  }

  Future<String> fetchDataFromApi() async {
    final random = Random();

    _addLog('-> Початок ініціалізації API...');

    await Future.delayed(const Duration(seconds: 2));
    _addLog('Ініціалізація успішна');

    _addLog('-> Надсилання запиту до сервера...');
    await Future.delayed(const Duration(milliseconds: 800));

    if (random.nextInt(100) < 10) {
      throw Exception('Сервер недоступний');
    }

    _addLog('Дані успішно отримано');

    _addLog('-> Обробка даних...');
    await Future.delayed(const Duration(seconds: 3));

    _addLog('Дані оброблено');

    return 'Готово!';
  }

  Future<void> _startApi() async {
    setState(() {
      _isLoading = true;
      _logs.clear();
    });

    try {
      final result = await fetchDataFromApi();
      _addLog(result);
    } catch (e) {
      _addLog(e.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Імітація API'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _isLoading ? null : _startApi,
              child: _isLoading
                  ? const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        ),
                        SizedBox(width: 12),
                        Text('Виконується...'),
                      ],
                    )
                  : const Text(
                      'Запустити API',
                      style: TextStyle(fontSize: 18),
                    ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListView.builder(
                  itemCount: _logs.length,
                  itemBuilder: (context, index) {
                    final log = _logs[index];

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Text(
                        log,
                        style: const TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 13,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
