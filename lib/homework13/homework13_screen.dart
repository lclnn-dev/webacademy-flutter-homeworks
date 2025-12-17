import 'package:flutter/material.dart';
import 'screens/settings_screen.dart';
import 'screens/add_transaction_screen.dart';
import 'screens/transactions_list_screen.dart';

class Homework13Screen extends StatelessWidget {
  const Homework13Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return const FinanceApp();
  }
}

class FinanceApp extends StatefulWidget {
  const FinanceApp({super.key});

  @override
  State<FinanceApp> createState() => _FinanceAppState();
}

class _FinanceAppState extends State<FinanceApp> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const TransactionsListScreen(),
    const AddTransactionScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Мої фінанси'), centerTitle: true),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Транзакції'),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_circle), label: 'Додати'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Налаштування'),
        ],
      ),
    );
  }
}
