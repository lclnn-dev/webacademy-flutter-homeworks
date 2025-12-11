import 'package:first_project/homework10/screens/real_time_data_screen.dart';
import 'package:first_project/homework10/screens/timer_screen.dart';
import 'package:flutter/material.dart';

import 'screens/api_screen.dart';
import 'screens/chat_bot_screen.dart';

class Homework10Screen extends StatelessWidget {
  const Homework10Screen({super.key});

  static const List<Map<String, dynamic>> tasks = [
    {
      'title': 'Chat-bot',
      'icon': Icons.smart_toy_outlined,
      'screen': ChatBotScreen()
    },
    {
      'title': 'Timer',
      'icon': Icons.timer_outlined,
      'screen': TimerScreen()
    },
    {
      'title': 'Real-time data',
      'icon': Icons.show_chart_outlined,
      'screen': RealTimeDataScreen()
    },
    {
      'title': 'API async',
      'icon': Icons.api_outlined,
      'screen': ApiAsyncScreen()
    },
  ];

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double availableHeight =
        screenHeight - kToolbarHeight - MediaQuery.of(context).padding.top - 40;

    final double cardHeight = availableHeight / 4;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Homework 10'),
        centerTitle: true,
      ),
      body: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(20),
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return SizedBox(
            height: cardHeight,
            child: _TaskCard(
              title: task['title'] as String,
              icon: task['icon'] as IconData,
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => task['screen'] as Widget),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _TaskCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const _TaskCard(
      {required this.title, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Row(
            children: [
              Icon(icon,
                  size: 50, color: Theme.of(context).colorScheme.primary),
              const SizedBox(width: 20),
              Expanded(
                child: Text(title, style: const TextStyle(fontSize: 25)),
              ),
              const Icon(Icons.arrow_forward_ios, size: 20, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
